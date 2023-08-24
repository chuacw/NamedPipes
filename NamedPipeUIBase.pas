unit NamedPipeUIBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, NamedPipesImpl, Vcl.Mask;

type
  TfrmNamedPipeBase = class(TForm)
    GroupBox1: TGroupBox;
    leServer: TLabeledEdit;
    lePipeName: TLabeledEdit;
    memoServer: TMemo;
    btnConnect: TButton;
    leMessage: TLabeledEdit;
    btnSendMessage: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure btnConnectClick(Sender: TObject);
    procedure btnSendMessageClick(Sender: TObject);
  protected
    { Private declarations }
    NamedPipe: TNamedPipe;
  public
    { Public declarations }
  end;

var
  frmNamedPipeBase: TfrmNamedPipeBase;

implementation

uses NamedPipeThreads;

{$R *.dfm}

procedure TfrmNamedPipeBase.btnConnectClick(Sender: TObject);
begin
  if not Assigned(NamedPipe) then
    begin
      NamedPipe := NamedPipeClass.Create(lePipeName.Text,
        leServer.Text);
    end;
  if NamedPipe.Open then
    begin
      btnSendMessage.Default := True;
      btnSendMessage.Enabled := True;
      btnConnect.Default := False;
      TNamedPipeThread.Create(NamedPipe, memoServer);
    end else
    begin
      ShowMessage('Unable to connect to server! Activate server first!');
    end;
end;

procedure TfrmNamedPipeBase.btnSendMessageClick(Sender: TObject);
begin
  if Assigned(NamedPipe) then
    begin
      NamedPipe.Write(leMessage.Text);
      leMessage.Text := '';
    end else
    begin
      ShowMessage('Named Pipe not opened');
    end;
end;

end.

