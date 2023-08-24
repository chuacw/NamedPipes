object frmNamedPipeBase: TfrmNamedPipeBase
  Left = 115
  Top = 174
  Width = 525
  Height = 296
  Caption = 'Named Pipe Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 517
    Height = 147
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Named Pipe Details'
    TabOrder = 0
    DesignSize = (
      517
      147)
    object leServer: TLabeledEdit
      Left = 12
      Top = 28
      Width = 121
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Server'
      TabOrder = 0
      Text = '.'
    end
    object lePipeName: TLabeledEdit
      Left = 146
      Top = 26
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Pipe Name'
      TabOrder = 1
      Text = 'NamedPipeDemo'
    end
    object btnConnect: TButton
      Left = 432
      Top = 28
      Width = 75
      Height = 25
      Caption = 'Connect'
      Default = True
      TabOrder = 2
      OnClick = btnConnectClick
    end
    object leMessage: TLabeledEdit
      Left = 4
      Top = 120
      Width = 511
      Height = 21
      Anchors = [akLeft, akTop, akRight, akBottom]
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'Message'
      TabOrder = 3
    end
    object btnSendMessage: TButton
      Left = 328
      Top = 28
      Width = 75
      Height = 25
      Caption = 'Send'
      Enabled = False
      TabOrder = 4
      OnClick = btnSendMessageClick
    end
    object LabeledEdit1: TLabeledEdit
      Left = 12
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 71
      EditLabel.Height = 13
      EditLabel.Caption = 'NT User Name'
      TabOrder = 5
    end
    object LabeledEdit2: TLabeledEdit
      Left = 146
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 89
      EditLabel.Height = 13
      EditLabel.Caption = 'NT User Password'
      PasswordChar = '*'
      TabOrder = 6
    end
  end
  object memoServer: TMemo
    Left = 0
    Top = 147
    Width = 517
    Height = 122
    Align = alClient
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
end
