object frmConfig: TfrmConfig
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es'
  ClientHeight = 246
  ClientWidth = 189
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object edtServer: TLabeledEdit
    Left = 24
    Top = 32
    Width = 145
    Height = 23
    EditLabel.Width = 46
    EditLabel.Height = 15
    EditLabel.Caption = 'Servidor:'
    TabOrder = 0
    Text = ''
  end
  object edtLogin: TLabeledEdit
    Left = 24
    Top = 83
    Width = 145
    Height = 23
    EditLabel.Width = 43
    EditLabel.Height = 15
    EditLabel.Caption = 'Usu'#225'rio:'
    TabOrder = 1
    Text = ''
  end
  object edtSenha: TLabeledEdit
    Left = 24
    Top = 136
    Width = 145
    Height = 23
    EditLabel.Width = 35
    EditLabel.Height = 15
    EditLabel.Caption = 'Senha:'
    PasswordChar = '*'
    TabOrder = 2
    Text = ''
  end
  object btnSalvar: TButton
    Left = 34
    Top = 205
    Width = 121
    Height = 25
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = btnSalvarClick
  end
  object Button1: TButton
    Left = 34
    Top = 174
    Width = 121
    Height = 25
    Caption = 'Testar'
    TabOrder = 4
    OnClick = Button1Click
  end
end
