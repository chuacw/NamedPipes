unit NamedPipeServerImpl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NamedPipeUIBase, StdCtrls, ExtCtrls, Vcl.Mask;

type
  TfrmNamedPipeServer = class(TfrmNamedPipeBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNamedPipeServer: TfrmNamedPipeServer;

implementation

uses NamedPipesImpl;

{$R *.dfm}

initialization
 NamedPipeClass := TNamedPipeServer;
end.
