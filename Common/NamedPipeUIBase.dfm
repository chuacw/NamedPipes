object frmNamedPipeBase: TfrmNamedPipeBase
  Left = 129
  Top = 179
  Caption = 'Named Pipe Server'
  ClientHeight = 598
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
    Height = 351
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Caption = 'Named Pipe Details'
    TabOrder = 0
    ExplicitHeight = 361
    DesignSize = (
      1303
      351)
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
      Width = 1308
      Height = 42
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 114
      EditLabel.Height = 32
      EditLabel.Margins.Left = 8
      EditLabel.Margins.Top = 8
      EditLabel.Margins.Right = 8
      EditLabel.Margins.Bottom = 8
      EditLabel.Caption = 'Message'
      TabOrder = 3
      Text = ''
      ExplicitWidth = 1288
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
    Top = 351
    Width = 1303
    Height = 247
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitTop = 366
    ExplicitWidth = 1283
    ExplicitHeight = 152
  end
end
