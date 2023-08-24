unit NamedPipesImpl;

interface

uses
  SyncObjs, Windows, SysUtils;

const
  NamedPipeLocalHost = '.';
  NamedPipeIOBufferSize = 16384;
  NamedPipeOutputBufferSize = NamedPipeIOBufferSize;
  NamedPipeInputBufferSize = NamedPipeIOBufferSize;
type

  TError = procedure (const Msg: string) of object;

  TNamedPipeUser = type string;
  TNamedPipeServerName = type string;
  TNamedPipeMessage = type string;
  TNamedPipeName = type string;
  TNamedPipePassword = type string;

  TNamedPipe = class
  private
    FError: Cardinal;
    FOnError: TError;
    function GetPipeName: TNamedPipeName;
    function GetConnected: Boolean;
    procedure SetError(const Value: Cardinal);
  protected
    FSD: TSecurityDescriptor;
    FSA: TSecurityAttributes;

    FConnectEvent, FReadEvent, FWriteEvent: TEvent;
    FConnectOverlapped, FReadOverlapped, FWriteOverlapped: TOverlapped;
    FName: string;
    FMessage: TNamedPipeMessage;
    FServer: TNamedPipeServerName;
    FPipeName: TNamedPipeName;
    FUserName: TNamedPipeUser;
    FPassword: TNamedPipePassword;
    FHandle: THandle;
    FTimeOut: Cardinal;
    FPending: Boolean;
    function GetHandle: THandle;
    procedure CreateHandle; virtual; abstract;

    procedure DoError(const Msg: string); virtual;

    procedure CreateEvents;
    property PipeName: TNamedPipeName read GetPipeName;
    property Error: Cardinal read FError write SetError;

  public
    constructor Create(const PipeName: TNamedPipeName;
      const Server: TNamedPipeServerName = NamedPipeLocalHost);
    destructor Destroy; override;

    procedure CheckConnected; virtual; abstract;
    function Open(const UserName: TNamedPipeUser ='';
                  const Password: TNamedPipePassword =''): Boolean; virtual;
    procedure Close;

    function Read: TNamedPipeMessage; overload;
    procedure Read(var Buffer: TNamedPipeMessage); overload;
    procedure Write(const Message: TNamedPipeMessage); virtual;

    procedure Connect; virtual; abstract;
    procedure Disconnect; virtual;

    property Connected: Boolean read GetConnected;
    property Handle: THandle read GetHandle;
    property TimeOut: Cardinal read FTimeOut write FTimeOut;

    property OnError: TError read FOnError write FOnError;
  end;

  TNamedPipeServer = class(TNamedPipe)
  protected
    procedure CreateHandle; override;
  public
    procedure CheckConnected; override;
    procedure Connect; override;
    function Open(const UserName: TNamedPipeUser ='';
                  const Password: TNamedPipePassword =''): Boolean; override;
  end;

  TNamedPipeClient = class(TNamedPipe)
  protected
    procedure CreateHandle; override;
  public
    procedure CheckConnected; override;
    procedure Connect; override;
    function Open(const UserName: TNamedPipeUser ='';
                  const Password: TNamedPipePassword =''): Boolean; override;
  end;

  ENamedPipe = class(Exception)
  end;

 TNamedPipeClass = class of TNamedPipe;

var
  NamedPipeClass: TNamedPipeClass;

implementation

function NetLogon(const Server, User, Password: WideString; out ErrorMessage: string): Boolean;
var
  NR: TNetResourceW;
  Flags: DWord;
  ServerResource: WideString;
  Err: DWord;
begin
  Flags := 0;
  NR.dwScope := RESOURCE_GLOBALNET;
  NR.dwType := RESOURCETYPE_ANY;
  NR.dwDisplayType := RESOURCEDISPLAYTYPE_GENERIC;
  ServerResource := Format('\\%s', [Server]);
  NR.lpRemoteName := PWideChar(ServerResource);
  NR.lpLocalName := nil;
  NR.lpProvider := nil;
  Err := WNetAddConnection2W(NR, PWideChar(Password), PWideChar(User), Flags);
  if Err <> NO_ERROR then
    begin
      Err := GetLastError;
      ErrorMessage := SysErrorMessage(Err);
    end;  
  Result := Err = NO_ERROR;
end;

function NetLogoff(const Server, User, Password: WideString): Boolean;
const
  FailIfOpenFilesorJobs = False;
var
  ServerResource: WideString;
  Err: DWord;
begin
  ServerResource := Format('\\%s', [Server]);
  Err := WNetCancelConnection2W(PWideChar(ServerResource),
                                CONNECT_UPDATE_PROFILE,
                                FailIfOpenFilesorJobs);
  Result := Err = NO_ERROR;
end;

procedure ErrorNamedPipe(const Message: string);
begin
  raise ENamedPipe.Create(Message);
end;

{ TNamedPipe }

procedure TNamedPipe.Close;
begin
  FReadEvent.Free;
  FWriteEvent.Free;
  FConnectEvent.Free;
  Disconnect;
  CloseHandle(FHandle);
  FHandle := 0;
  FPending := False;
  if FServer<>NamedPipeLocalHost then
   NetLogoff(FServer, FUserName, FPassword);
end;

constructor TNamedPipe.Create(const PipeName: TNamedPipeName; const Server: TNamedPipeServerName);
begin
  FName := ClassName;
  FPipeName := PipeName;
  FServer := Server;
  FTimeOut := 100; // 1000 = 1 sec
end;

procedure TNamedPipe.CreateEvents;
begin
  FReadEvent := TSimpleEvent.Create;
  FReadOverlapped.hEvent := FReadEvent.Handle;

  FWriteEvent := TSimpleEvent.Create;
  FWriteEvent.SetEvent;
  FWriteOverlapped.hEvent := FWriteEvent.Handle;

  FConnectEvent := TSimpleEvent.Create;
  FConnectOverlapped.hEvent := FConnectEvent.Handle;
end;

destructor TNamedPipe.Destroy;
begin
  Close;
  inherited;
end;

procedure TNamedPipe.Disconnect;
begin
  DisconnectNamedPipe(FHandle);
end;

function TNamedPipe.GetConnected: Boolean;
var
 Dummy: Cardinal;
begin
  Result := False;
  if not GetOverlappedResult(Handle, FConnectOverlapped, Dummy, False) then
    Error := GetLastError else
  case FConnectEvent.WaitFor(0) of
    wrTimeout:
      FPending := False;
    wrSignaled:
      Result := True;
  end;
end;

function TNamedPipe.GetHandle: THandle;
begin
  if FHandle = 0 then
    CreateHandle;
  Result := FHandle;
end;

function TNamedPipe.GetPipeName: TNamedPipeName;
begin
  Result := Format('\\%s\pipe\%s', [FServer, FPipeName]);
end;

function TNamedPipe.Read: TNamedPipeMessage;
begin
  Read(Result);
end;

function TNamedPipe.Open(const UserName: TNamedPipeUser; const Password: TNamedPipePassword): Boolean;
var
  ErrorMessage: string;
begin
  if FUserName = '' then
    FUserName := UserName;
  if FPassword = '' then
    FPassword := Password;
  Result := NetLogon(FServer, FUserName, FPassword, ErrorMessage);
end;

procedure TNamedPipe.Read(var Buffer: TNamedPipeMessage);
var
  ToReadSize, ReadSize: Cardinal;
begin
  SetLength(Buffer, NamedPipeOutputBufferSize);
  ToReadSize := Length(Buffer) * SizeOf(Buffer[1]);
  FReadEvent.ResetEvent;
  if not ReadFile(Handle, Buffer[1], ToReadSize, ReadSize, @FReadOverlapped) then
    begin
      OutputDebugString(PChar(SysErrorMessage(GetLastError)));
    end;
  FReadEvent.WaitFor(INFINITE);
  if ReadSize = 0 then
    begin
      if (not GetOverlappedResult(Handle, FReadOverlapped, ReadSize, True)) or
         (ReadSize = 0) then
       Error := GetLastError;
    end;
  SetLength(Buffer, ReadSize div SizeOf(FMessage[1]));
  FReadEvent.ResetEvent;
end;

procedure TNamedPipe.Write(const Message: TNamedPipeMessage);
var
  Temp: string;
  Error, WriteSize, WrittenSize: Cardinal;
begin
  CheckConnected;
  FWriteEvent.WaitFor(INFINITE);
  FWriteEvent.ResetEvent;
  FMessage := Message;
  WriteSize := Length(FMessage) * SizeOf(FMessage[1]);
  WrittenSize := 0;
  if not WriteFile(Handle, FMessage[1], WriteSize, WrittenSize, @FWriteOverlapped) then
    begin
      if not GetOverlappedResult(Handle, FWriteOverlapped, WrittenSize, False) then
        begin
          Error := GetLastError;
          Temp := SysErrorMessage(Error);
          FMessage := Temp;
        end;
    end;
end;

procedure TNamedPipe.SetError(const Value: Cardinal);
begin
  FError := Value;
  case Value of
    ERROR_PIPE_CONNECTED: FConnectEvent.SetEvent;
    ERROR_IO_PENDING: FPending := True;
    ERROR_IO_INCOMPLETE:  ;
    ERROR_BROKEN_PIPE:
      begin
        Close;
        Open;
      end;
  end;
end;

procedure TNamedPipe.DoError(const Msg: string);
begin
  if Assigned(FOnError) then
    try
      FOnError(Msg); // Protect against a silly user error
    except
    end;
end;

{ TNamedPipeClient }

procedure TNamedPipeClient.CheckConnected;
begin
end;

procedure TNamedPipeClient.Connect;
begin
end;

procedure TNamedPipeClient.CreateHandle;
const
  ReadWrite = GENERIC_READ or GENERIC_WRITE;
  FileShare = FILE_SHARE_READ or FILE_SHARE_WRITE;
  FileFlag = FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED;
var
  Mode: Cardinal;
begin
  FHandle := CreateFileW(PWideChar(PipeName), ReadWrite, FileShare, nil,
    OPEN_EXISTING, FileFlag, 0);
  Mode := GetLastError;
  FMessage := SysErrorMessage(Mode);
  if FHandle = INVALID_HANDLE_VALUE then
    FHandle := 0 else
  begin
    Mode := PIPE_READMODE_MESSAGE or PIPE_WAIT;
    SetNamedPipeHandleState(FHandle, Mode, nil, nil);
    CreateEvents;
    FConnectEvent.SetEvent;
  end;
end;

function TNamedPipeClient.Open(const UserName: TNamedPipeUser ='';
  const Password: TNamedPipePassword =''): Boolean;
begin
  inherited Open(UserName, Password);
  if WaitNamedPipeW(PWideChar(PipeName), NMPWAIT_USE_DEFAULT_WAIT) then
    begin
      CreateHandle;
      Result := True;
    end else
    begin
      DoError('Timed out waiting for server');
      Result := False;
    end;
end;

{ TNamedPipeServer }

procedure TNamedPipeServer.CheckConnected;
begin
  Connected;
end;

procedure TNamedPipeServer.Connect;
var
 TempError: Cardinal;
begin
  if not FPending then
    begin
      FConnectEvent.ResetEvent;
      DisconnectNamedPipe(Handle);
      if not ConnectNamedPipe(Handle, @FConnectOverlapped) then
        Error := GetLastError;
    end else
    begin
      if not GetOverlappedResult(Handle, FConnectOverlapped,
                                 TempError, True) then
        FPending := False;
    end;
end;

procedure TNamedPipeServer.CreateHandle;
begin
  InitializeSecurityDescriptor(@FSD, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@FSD, True, PACL(0), False);
  FSA.nLength := SizeOf(FSA);
  FSA.lpSecurityDescriptor := @FSD;
  FSA.bInheritHandle := True;

  FHandle := CreateNamedPipe(PChar(PipeName),
    PIPE_ACCESS_DUPLEX or FILE_FLAG_OVERLAPPED,
    PIPE_TYPE_MESSAGE or PIPE_READMODE_MESSAGE or
    PIPE_WAIT, PIPE_UNLIMITED_INSTANCES,
    NamedPipeOutputBufferSize,
    NamedPipeInputBufferSize, FTimeOut,
    @FSA);
    
  if FHandle <> INVALID_HANDLE_VALUE then
    CreateEvents else
    begin
      FHandle := 0;
      DoError('Unable to create handle');
    end;  
end;

function TNamedPipeServer.Open(const UserName: TNamedPipeUser ='';
  const Password: TNamedPipePassword =''): Boolean;
begin
  inherited Open(UserName, Password);
  CreateHandle;
  Result := FHandle <> 0;
  Connect;
end;

end.

