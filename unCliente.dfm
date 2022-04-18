object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'Cliente'
  ClientHeight = 349
  ClientWidth = 691
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object PanelCliente: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 349
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = -6
    ExplicitHeight = 475
    DesignSize = (
      691
      349)
    object lblCPFNCPJ: TLabel
      Left = 24
      Top = 69
      Width = 24
      Height = 15
      Caption = 'CPF:'
    end
    object lblRGIE: TLabel
      Left = 24
      Top = 117
      Width = 18
      Height = 15
      Caption = 'RG:'
    end
    object lblData: TLabel
      Left = 195
      Top = 115
      Width = 83
      Height = 15
      Caption = 'Data Cadastro:'
    end
    object lblTelefone: TLabel
      Left = 195
      Top = 69
      Width = 47
      Height = 15
      Caption = 'Telefone:'
    end
    object lblCEP: TLabel
      Left = 24
      Top = 173
      Width = 24
      Height = 15
      Caption = 'CEP:'
    end
    object edtNome: TLabeledEdit
      Left = 24
      Top = 32
      Width = 417
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 36
      EditLabel.Height = 15
      EditLabel.Caption = 'Nome:'
      MaxLength = 100
      TabOrder = 0
      Text = ''
    end
    object rgPF: TRadioButton
      Left = 464
      Top = 35
      Width = 97
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Pessoa F'#237'sica'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rgPFClick
    end
    object rgPJ: TRadioButton
      Left = 567
      Top = 35
      Width = 102
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Pessoa Jur'#237'dica'
      TabOrder = 2
      OnClick = rgPFClick
    end
    object edtCPFCNPJ: TMaskEdit
      Left = 24
      Top = 88
      Width = 161
      Height = 23
      TabOrder = 3
      Text = ''
    end
    object edtRGIE: TMaskEdit
      Left = 24
      Top = 136
      Width = 158
      Height = 23
      TabOrder = 7
      Text = ''
    end
    object dtpData: TDateTimePicker
      Left = 195
      Top = 136
      Width = 126
      Height = 23
      Date = 44668.000000000000000000
      Time = 0.510621828703733600
      Enabled = False
      Kind = dtkDateTime
      ParentShowHint = False
      ShowHint = False
      TabOrder = 8
    end
    object chkAtivo: TCheckBox
      Left = 344
      Top = 139
      Width = 97
      Height = 17
      Caption = 'Ativo'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object edtTelefone: TMaskEdit
      Left = 195
      Top = 88
      Width = 120
      Height = 23
      EditMask = '!\(99\)9999-99999;1;_'
      MaxLength = 14
      TabOrder = 4
      Text = '(  )    -     '
    end
    object BtnAdd: TButton
      Left = 327
      Top = 87
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 5
      OnClick = BtnAddClick
    end
    object ListBoxTelefones: TListBox
      Left = 424
      Top = 88
      Width = 245
      Height = 71
      ItemHeight = 15
      TabOrder = 6
      OnDblClick = ListBoxTelefonesDblClick
    end
    object edtCEP: TMaskEdit
      Left = 24
      Top = 192
      Width = 65
      Height = 23
      EditMask = '00000\-000;1;_'
      MaxLength = 9
      TabOrder = 10
      Text = '     -   '
      OnExit = edtCEPExit
      OnKeyPress = edtCEPKeyPress
    end
    object edtLogradouro: TLabeledEdit
      Left = 104
      Top = 192
      Width = 441
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 65
      EditLabel.Height = 15
      EditLabel.Caption = 'Logradouro:'
      MaxLength = 150
      TabOrder = 11
      Text = ''
    end
    object edtNumero: TLabeledEdit
      Left = 561
      Top = 192
      Width = 108
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 17
      EditLabel.Height = 15
      EditLabel.Caption = 'N'#186':'
      MaxLength = 5
      TabOrder = 12
      Text = ''
    end
    object edtBairro: TLabeledEdit
      Left = 24
      Top = 240
      Width = 297
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 34
      EditLabel.Height = 15
      EditLabel.Caption = 'Bairro:'
      MaxLength = 100
      TabOrder = 13
      Text = ''
    end
    object edtCidade: TLabeledEdit
      Left = 339
      Top = 240
      Width = 330
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 40
      EditLabel.Height = 15
      EditLabel.Caption = 'Cidade:'
      MaxLength = 100
      TabOrder = 14
      Text = ''
    end
    object edtUF: TLabeledEdit
      Left = 24
      Top = 288
      Width = 65
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      EditLabel.Width = 17
      EditLabel.Height = 15
      EditLabel.Caption = 'UF:'
      MaxLength = 2
      TabOrder = 15
      Text = ''
    end
    object edtPais: TLabeledEdit
      Left = 95
      Top = 288
      Width = 244
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      EditLabel.Width = 24
      EditLabel.Height = 15
      EditLabel.Caption = 'Pa'#237's:'
      MaxLength = 100
      TabOrder = 16
      Text = ''
    end
    object btnSalvar: TButton
      Left = 464
      Top = 287
      Width = 136
      Height = 25
      Caption = 'Salvar'
      TabOrder = 17
      OnClick = btnSalvarClick
    end
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    Left = 312
    Top = 152
  end
  object RESTClient: TRESTClient
    BaseURL = 'https://viacep.com.br/ws'
    Params = <>
    Left = 392
    Top = 152
  end
  object RESTResponse: TRESTResponse
    Left = 352
    Top = 216
  end
end
