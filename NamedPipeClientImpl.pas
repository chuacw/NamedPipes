unit NamedPipeClientImpl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NamedPipeUIBase, StdCtrls, ExtCtrls;

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

uses NamedPipesImpl;

{$R *.dfm}

initialization
 NamedPipeClass := TNamedPipeClient;
end.
 