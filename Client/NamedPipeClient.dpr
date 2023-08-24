program NamedPipeClient;

uses
  Forms,
  NamedPipesImpl in 'NamedPipesImpl.pas',
  NamedPipeUIBase in 'NamedPipeUIBase.pas' {frmNamedPipeBase},
  NamedPipeThreads in 'NamedPipeThreads.pas',
  NamedPipeClientImpl in 'NamedPipeClientImpl.pas' {frmNamedPipeClient};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Named Pipe Client';
  Application.CreateForm(TfrmNamedPipeClient, frmNamedPipeClient);
  Application.Run;
end.
