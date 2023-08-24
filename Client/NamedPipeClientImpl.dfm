inherited frmNamedPipeClient: TfrmNamedPipeClient
  Left = 145
  Caption = 'Named Pipe Client'
  StyleElements = [seFont, seClient, seBorder]
  ExplicitLeft = 2
  ExplicitTop = 2
  PixelsPerInch = 240
  TextHeight = 32
  inherited GroupBox1: TGroupBox
    inherited leServer: TLabeledEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited lePipeName: TLabeledEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited leMessage: TLabeledEdit
      Width = 1308
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 1288
    end
    inherited LabeledEdit1: TLabeledEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited LabeledEdit2: TLabeledEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited memoServer: TMemo
    StyleElements = [seFont, seClient, seBorder]
  end
end
