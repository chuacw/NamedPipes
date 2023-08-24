program NamedPipeServer;

uses
  Forms,
  DebugThreadSupport in '..\..\Library\DebugThreadSupport.pas',
  NamedPipesImpl in 'NamedPipesImpl.pas',
  NamedPipeUIBase in 'NamedPipeUIBase.pas' {frmNamedPipeBase},
  NamedPipeThreads in 'NamedPipeThreads.pas',
  NamedPipeServerImpl in 'NamedPipeServerImpl.pas' {frmNamedPipeServer1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Named Pipe Server';
  Application.CreateForm(TfrmNamedPipeServer, frmNamedPipeServer);
  Application.Run;
end.
