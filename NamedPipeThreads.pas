unit NamedPipeThreads;

interface
uses Classes, StdCtrls, NamedPipesImpl;

type
  TNamedPipeThread = class(TThread)
  protected
    FNamedPipe: TNamedPipe;
    FMemo: TMemo;
    FMessage: WideString;
    procedure WriteMessage;
  public
    constructor Create(NamedPipe: TNamedPipe; Memo: TMemo);
    procedure Execute; override;
  end;

implementation


{ TNamedPipeThread }

constructor TNamedPipeThread.Create(NamedPipe: TNamedPipe; Memo: TMemo);
begin
  inherited Create(True);
  FNamedPipe := NamedPipe;
  FMemo := Memo;
  FreeOnTerminate := True;
  Resume;
end;

procedure TNamedPipeThread.Execute;
begin
  NameThreadForDebugging(ClassName);
  while not Terminated do
    begin
      if FNamedPipe.Connected then
        begin
          FNamedPipe.Read(FMessage);
          Synchronize(WriteMessage);
        end;
    end;
end;

procedure TNamedPipeThread.WriteMessage;
begin
  FMemo.Lines.Add(FMessage);
end;

end.
