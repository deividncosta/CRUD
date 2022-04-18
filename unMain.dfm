object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'CRUD - Deivid Nascimento Costa'
  ClientHeight = 520
  ClientWidth = 873
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
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 873
    Height = 91
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnPesq: TButton
      Left = 463
      Top = 28
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 0
      OnClick = btnPesqClick
    end
    object btnNovo: TButton
      Left = 544
      Top = 28
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 1
      OnClick = btnNovoClick
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 91
    Width = 873
    Height = 410
    Align = alClient
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Title.Alignment = taCenter
        Title.Caption = 'NOME'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = []
        Width = 365
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPFCNPJ'
        Title.Alignment = taCenter
        Title.Caption = 'CPF / CNPJ'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = []
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RGIE'
        Title.Alignment = taCenter
        Title.Caption = 'RG / IE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = []
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI Semibold'
        Title.Font.Style = []
        Width = 80
        Visible = True
      end>
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 501
    Width = 873
    Height = 19
    Panels = <
      item
        Text = 'Clique com o bot'#227'o direito para mais op'#231#245'es'
        Width = 300
      end>
    ExplicitLeft = 376
    ExplicitTop = 176
    ExplicitWidth = 0
  end
  object edtNome: TLabeledEdit
    Left = 16
    Top = 29
    Width = 441
    Height = 23
    CharCase = ecUpperCase
    EditLabel.Width = 91
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome do cliente:'
    MaxLength = 100
    TabOrder = 3
    Text = ''
  end
  object chkAtivos: TCheckBox
    Left = 16
    Top = 58
    Width = 97
    Height = 17
    Caption = 'Somente ativos'
    TabOrder = 4
  end
  object PopupMenu: TPopupMenu
    Left = 672
    Top = 312
    object Editar1: TMenuItem
      Caption = 'Editar'
      OnClick = Editar1Click
    end
    object Deletar1: TMenuItem
      Caption = 'Remover'
      OnClick = Deletar1Click
    end
  end
  object FDMem: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 288
    Top = 248
    object FDMemID: TIntegerField
      FieldName = 'ID'
    end
    object FDMemNome: TStringField
      DisplayWidth = 150
      FieldName = 'Nome'
      Size = 150
    end
    object FDMemCPFCNPJ: TStringField
      FieldName = 'CPFCNPJ'
      Size = 25
    end
    object FDMemRGIE: TStringField
      FieldName = 'RGIE'
      Size = 50
    end
    object FDMemCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object FDMemATIVO: TBooleanField
      FieldName = 'ATIVO'
    end
  end
  object DataSource: TDataSource
    DataSet = FDMem
    Left = 200
    Top = 248
  end
end
