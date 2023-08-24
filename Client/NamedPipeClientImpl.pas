unit NamedPipeClientImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, NamedPipeUIBase, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmNamedPipeClient = class(TfrmNamedPipeBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNamedPipeClient: TfrmNamedPipeClient;

implementation

uses
  NamedPipesImpl;

{$R *.dfm}

initialization
  NamedPipeClass := TNamedPipeClient;
end.
 