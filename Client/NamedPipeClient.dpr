program NamedPipeClient;

uses
  Forms,
  NamedPipeClientImpl in 'NamedPipeClientImpl.pas' {frmNamedPipeClient},
  NamedPipeUIBase in '..\Common\NamedPipeUIBase.pas' {frmNamedPipeBase},
  NamedPipesImpl in '..\Common\NamedPipesImpl.pas',
  NamedPipeThreads in '..\Common\NamedPipeThreads.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Named Pipe Client';
  Application.CreateForm(TfrmNamedPipeClient, frmNamedPipeClient);
  Application.CreateForm(TfrmNamedPipeBase, frmNamedPipeBase);
  Application.Run;
end.
