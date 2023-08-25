unit NamedPipeClientImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, NamedPipeUIBase, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmNamedPipeClient = class(TfrmNamedPipeBase)
    procedure btnConnectClick(Sender: TObject);
  private
    { Private declarations }
    procedure Disconnect(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmNamedPipeClient: TfrmNamedPipeClient;

implementation

uses
  NamedPipesImpl;

{$R *.dfm}

procedure TfrmNamedPipeClient.btnConnectClick(Sender: TObject);
begin
  inherited;
  if FNamedPipe.Connected then
    begin
      FSavedCaption := btnConnect.Caption;
      FSavedOnClick := btnConnect.OnClick;
      btnConnect.Caption := 'Disconnect';
      btnConnect.OnClick := Disconnect;
    end;
end;

procedure TfrmNamedPipeClient.Disconnect(Sender: TObject);
begin
  FreeAndNil(FNamedPipe);
  btnConnect.Caption := FSavedCaption;
  btnConnect.OnClick := FSavedOnClick;
end;

initialization
  NamedPipeClass := TNamedPipeClient;
end.
 