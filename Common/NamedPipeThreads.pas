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
    procedure WriteMessage;
  public
    constructor Create(ANamedPipe: TNamedPipe; AMemo: TMemo);
    procedure Execute; override;
  end;

implementation


{ TNamedPipeThread }

constructor TNamedPipeThread.Create(ANamedPipe: TNamedPipe; AMemo: TMemo);
begin
  inherited Create(True);
  FNamedPipe := ANamedPipe;
  FMemo := AMemo;
  FreeOnTerminate := False;
end;

procedure TNamedPipeThread.Execute;
begin
  NameThreadForDebugging(ClassName);
  while not Terminated do
    begin
      if FNamedPipe.Connected then
        begin
          if FNamedPipe.Read(FMessage) then
            Synchronize(WriteMessage);
          Sleep(0);
        end;
    end;
end;

procedure TNamedPipeThread.WriteMessage;
begin
  FMemo.Lines.Add(FMessage);
  FMessage := '';
end;

end.
