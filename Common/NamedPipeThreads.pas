unit NamedPipeThreads;

interface

uses
  System.Classes, Vcl.StdCtrls, NamedPipesImpl;

type
  TNamedPipeThread = class(TThread)
  protected
    FNamedPipe: TNamedPipe;
    FMemo: TMemo;
    FMessage: TNamedPipeMessage;
    FMsgBuffer: TStringList;
    procedure WriteMessage;
  public
    constructor Create(ANamedPipe: TNamedPipe; AMemo: TMemo);
    destructor Destroy; override;
    procedure Execute; override;
  end;

implementation

uses
  Winapi.Windows;

function SetThreadDescription(threadHandle: THandle; pcwstr: PWideChar): HResult; stdcall;
  external kernel32 name 'SetThreadDescription';

{ TNamedPipeThread }

constructor TNamedPipeThread.Create(ANamedPipe: TNamedPipe; AMemo: TMemo);
begin
  inherited Create(True);
  FMsgBuffer := TStringList.Create;
  FNamedPipe := ANamedPipe;
  FMemo := AMemo;
  FreeOnTerminate := False;
end;

destructor TNamedPipeThread.Destroy;
begin
  FMsgBuffer.Free;
  inherited;
end;

procedure TNamedPipeThread.Execute;
var
  LLast: Integer;
begin
  NameThreadForDebugging(FNamedPipe.ClassName);
  SetThreadDescription(GetCurrentThread, PChar(FNamedPipe.ClassName));
  while not Terminated do
    begin
      if FNamedPipe.Connected then
        begin
          if FNamedPipe.Read(FMessage) then
            begin
              TMonitor.Enter(FMsgBuffer);
              try
                LLast := FMsgBuffer.Count;
                FMsgBuffer.Insert(LLast, FMessage);
              finally
                TMonitor.Exit(FMsgBuffer);
              end;
              Synchronize(WriteMessage);
            end;
          Sleep(0);
        end;
    end;
end;

procedure TNamedPipeThread.WriteMessage;
var
  LMessage: string;
  Index: Integer;
begin
  TMonitor.Enter(FMsgBuffer);
  try
    Index := FMsgBuffer.Count-1;
    LMessage := FMsgBuffer[Index];
    FMsgBuffer.Delete(Index);
    FMemo.Lines.Add(LMessage);
  finally
    TMonitor.Exit(FMsgBuffer);
  end;
  FMessage := '';
end;

end.
