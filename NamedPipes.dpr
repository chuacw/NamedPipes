program NamedPipes;

uses
  Forms,
  NamedPipesTest in 'NamedPipesTest.pas' {Form1},
  NamedPipesImpl in 'NamedPipesImpl.pas',
  NamedPipeThreads in 'NamedPipeThreads.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
