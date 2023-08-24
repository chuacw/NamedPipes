object frmNamedPipeBase: TfrmNamedPipeBase
  Left = 129
  Top = 179
  Caption = 'Named Pipe Server'
  ClientHeight = 520
  ClientWidth = 1303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 240
  TextHeight = 32
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1303
    Height = 368
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Named Pipe Details'
    TabOrder = 0
    ExplicitWidth = 1283
    ExplicitHeight = 366
    DesignSize = (
      1303
      368)
    object leServer: TLabeledEdit
      Left = 30
      Top = 70
      Width = 303
      Height = 40
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      EditLabel.Width = 80
      EditLabel.Height = 32
      EditLabel.Margins.Left = 8
      EditLabel.Margins.Top = 8
      EditLabel.Margins.Right = 8
      EditLabel.Margins.Bottom = 8
      EditLabel.Caption = 'Server'
      TabOrder = 0
      Text = '.'
    end
    object lePipeName: TLabeledEdit
      Left = 365
      Top = 65
      Width = 303
      Height = 40
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      EditLabel.Width = 136
      EditLabel.Height = 32
      EditLabel.Margins.Left = 8
      EditLabel.Margins.Top = 8
      EditLabel.Margins.Right = 8
      EditLabel.Margins.Bottom = 8
      EditLabel.Caption = 'Pipe Name'
      TabOrder = 1
      Text = 'NamedPipeDemo'
    end
    object btnConnect: TButton
      Left = 1080
      Top = 70
      Width = 188
      Height = 63
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = 'Connect'
      Default = True
      TabOrder = 2
      OnClick = btnConnectClick
    end
    object leMessage: TLabeledEdit
      Left = 10
      Top = 300
      Width = 1328
      Height = 42
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Anchors = [akLeft, akTop, akRight, akBottom]
      EditLabel.Width = 114
      EditLabel.Height = 32
      EditLabel.Margins.Left = 8
      EditLabel.Margins.Top = 8
      EditLabel.Margins.Right = 8
      EditLabel.Margins.Bottom = 8
      EditLabel.Caption = 'Message'
      TabOrder = 3
      Text = ''
      ExplicitWidth = 1308
      ExplicitHeight = 40
    end
    object btnSendMessage: TButton
      Left = 820
      Top = 70
      Width = 188
      Height = 63
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = 'Send'
      Enabled = False
      TabOrder = 4
      OnClick = btnSendMessageClick
    end
    object LabeledEdit1: TLabeledEdit
      Left = 30
      Top = 180
      Width = 303
      Height = 40
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      EditLabel.Width = 182
      EditLabel.Height = 32
      EditLabel.Margins.Left = 8
      EditLabel.Margins.Top = 8
      EditLabel.Margins.Right = 8
      EditLabel.Margins.Bottom = 8
      EditLabel.Caption = 'NT User Name'
      TabOrder = 5
      Text = ''
    end
    object LabeledEdit2: TLabeledEdit
      Left = 365
      Top = 180
      Width = 303
      Height = 40
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      EditLabel.Width = 228
      EditLabel.Height = 32
      EditLabel.Margins.Left = 8
      EditLabel.Margins.Top = 8
      EditLabel.Margins.Right = 8
      EditLabel.Margins.Bottom = 8
      EditLabel.Caption = 'NT User Password'
      PasswordChar = '*'
      TabOrder = 6
      Text = ''
    end
  end
  object memoServer: TMemo
    Left = 0
    Top = 368
    Width = 1303
    Height = 152
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitTop = 366
    ExplicitWidth = 1283
  end
end
