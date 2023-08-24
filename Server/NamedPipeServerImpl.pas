unit NamedPipeServerImpl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NamedPipeUIBase, StdCtrls, ExtCtrls, Vcl.Mask;

type
  TfrmNamedPipeServer = class(TfrmNamedPipeBase)
    procedure btnConnectClick(Sender: TObject);
  private
    { Private declarations }
    procedure Deactivate(Sender: TObject); reintroduce;
  public
    { Public declarations }
  end;

var
  frmNamedPipeServer: TfrmNamedPipeServer;

implementation

uses
  NamedPipesImpl;

{$R *.dfm}

procedure TfrmNamedPipeServer.btnConnectClick(Sender: TObject);
begin
  inherited;
  if Assigned(NamedPipe) then
    begin
      FSavedCaption := btnConnect.Caption;
      FSavedOnClick := btnConnect.OnClick;
      btnConnect.Caption := 'Deactivate';
      btnConnect.OnClick := Deactivate;
    end;
end;

procedure TfrmNamedPipeServer.Deactivate(Sender: TObject);
begin
  FreeAndNil(NamedPipe);
  btnConnect.OnClick := FSavedOnClick;
  btnConnect.Caption := FSavedCaption;
end;

initialization
  NamedPipeClass := TNamedPipeServer;
end.
