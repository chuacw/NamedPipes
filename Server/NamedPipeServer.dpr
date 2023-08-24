program NamedPipeServer;

uses
  Forms,
  NamedPipeServerImpl in 'NamedPipeServerImpl.pas' {frmNamedPipeServer1},
  NamedPipeUIBase in '..\Common\NamedPipeUIBase.pas' {frmNamedPipeBase},
  NamedPipesImpl in '..\Common\NamedPipesImpl.pas',
  NamedPipeThreads in '..\Common\NamedPipeThreads.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Named Pipe Server';
  Application.CreateForm(TfrmNamedPipeServer, frmNamedPipeServer);
  Application.CreateForm(TfrmNamedPipeBase, frmNamedPipeBase);
  Application.Run;
end.
