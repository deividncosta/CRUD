unit unMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, IniFiles, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmMain = class(TForm)
    Panel: TPanel;
    DBGrid: TDBGrid;
    StatusBar: TStatusBar;
    PopupMenu: TPopupMenu;
    edtNome: TLabeledEdit;
    chkAtivos: TCheckBox;
    btnPesq: TButton;
    btnNovo: TButton;
    FDMem: TFDMemTable;
    FDMemID: TIntegerField;
    FDMemNome: TStringField;
    FDMemCPFCNPJ: TStringField;
    FDMemRGIE: TStringField;
    FDMemCEP: TStringField;
    DataSource: TDataSource;
    FDMemATIVO: TBooleanField;
    Editar1: TMenuItem;
    Deletar1: TMenuItem;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure btnPesqClick(Sender: TObject);
    procedure Deletar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadCliente;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses unCliente, unConfig, uDM;

procedure TfrmMain.btnNovoClick(Sender: TObject);
begin
  frmCliente := TfrmCliente.Create(Self);
  try
    frmCliente.ShowModal;
  finally
    frmCliente.DisposeOf;
  end;
end;

procedure TfrmMain.btnPesqClick(Sender: TObject);
begin
  LoadCliente;
end;

procedure TfrmMain.Deletar1Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja remover o registro?', 'Atenção', MB_YESNO + MB_ICONQUESTION) = ID_YES then
  begin
    with DM do
    begin
      FDQry.Close;
      FDQry.SQL.Clear;
      FDQry.SQL.Add('DELETE FROM CRUD.DBO.TELEFONE WHERE CLIENTE = :ID');
      FDQry.ParamByName('ID').AsInteger := FDMemID.AsInteger;
      FDQry.ExecSQL;
      FDQry.Close;
      FDQry.SQL.Clear;
      FDQry.SQL.Add('DELETE FROM CRUD.DBO.ENDERECO WHERE CLIENTE = :ID');
      FDQry.ParamByName('ID').AsInteger := FDMemID.AsInteger;
      FDQry.ExecSQL;
      FDQry.Close;
      FDQry.SQL.Clear;
      FDQry.SQL.Add('DELETE FROM CRUD.DBO.CLIENTE WHERE ID = :ID');
      FDQry.ParamByName('ID').AsInteger := FDMemID.AsInteger;
      FDQry.ExecSQL;
      ShowMessage('Registro removido com sucesso!');
      LoadCliente;
    end;
  end;
end;

procedure TfrmMain.Editar1Click(Sender: TObject);
begin
  with DM do
  begin
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('SELECT * FROM CRUD.DBO.CLIENTE A');
    FDQry.SQL.Add('INNER JOIN CRUD.DBO.ENDERECO B ON B.CLIENTE = A.ID');
    FDQry.SQL.Add('INNER JOIN CRUD.DBO.TELEFONE C ON C.CLIENTE = A.ID');
    FDQry.SQL.Add('WHERE A.ID = :ID');
    FDQry.ParamByName('ID').AsInteger := FDMemID.AsInteger;
    FDQry.Open;
    if not FDQry.IsEmpty then
    begin
      frmCliente := TfrmCliente.Create(nil);
      with frmCliente do
      begin
        edtNome.Text := FDQry.Fields[2].AsString;
        if FDQry.Fields[1].AsString = 'F' then
         rgPF.Checked := True
        else
          rgPJ.Checked   := False;
        IDCliente        := FDQry.Fields[0].AsInteger;
        edtCPFCNPJ.Text  := FDQry.Fields[3].AsString;
        edtRGIE.Text     := FDQry.Fields[4].AsString;
        dtpData.DateTime := FDQry.Fields[5].AsDateTime;
        chkAtivo.Checked := FDQry.Fields[6].AsBoolean;
        edtLogradouro.Text := FDQry.Fields[8].AsString;
        edtNumero.Text     := FDQry.Fields[9].AsString;
        edtCEP.Text        := FDQry.Fields[10].AsString;
        edtBairro.Text     := FDQry.Fields[11].AsString;
        edtCidade.Text     := FDQry.Fields[12].AsString;
        edtUF.Text         := FDQry.Fields[13].AsString;
        edtPais.Text       := FDQry.Fields[14].AsString;
        FDQry.First;
        while not FDQry.Eof do
        begin
          ListBoxTelefones.Items.Add('(' + FDQry.Fields[16].AsString + ')' + Copy(FDQry.Fields[17].AsString,0,4) + '-' + Copy(FDQry.Fields[17].AsString,5,9));
          FDQry.Next;
        end;
      end;
      frmCliente.ShowModal;
    end;
    FDQry.Close;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Arq: TIniFile;
begin
  if not FileExists(ExtractFileDir(GetCurrentDir) + 'Config.ini') then
  begin
    ShowMessage('Arquivo de configuração não encontrado.');
    frmConfig := TfrmConfig.Create(nil);
    try
      frmConfig.ShowModal;
    finally
      frmConfig.DisposeOf;
    end;
  end;
  Arq := TIniFile.Create(ExtractFileDir(GetCurrentDir) + 'Config.ini');
  DM.FDConn.Params.Values['Server']   := Arq.ReadString('CONFIG', 'SERVER', '');
  DM.FDConn.Params.Values['UserName'] := Arq.ReadString('CONFIG', 'USER', '');
  DM.FDConn.Params.Values['Password'] := Arq.ReadString('CONFIG', 'PASSWORD', '');
  Arq.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  LoadCliente;
end;

procedure TfrmMain.LoadCliente;
begin
  with DM do
  begin
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('SELECT ID, NOME, CPFCNPJ, RGIE, CEP, ATIVO FROM CRUD.DBO.CLIENTE A');
    FDQry.SQL.Add('INNER JOIN CRUD.DBO.ENDERECO B ON B.CLIENTE = A.ID');
    FDQry.SQL.Add('WHERE NOME LIKE('+QuotedStr('%' + Trim(edtNome.Text)+'%')+')');
    if chkAtivos.Checked then
      FDQry.SQL.Add('AND ATIVO = 1');
    FDQry.SQL.Add('ORDER BY NOME');
    FDQry.Open;
    FDMem.Active := True;
    FDMem.EmptyDataSet;
    FDQry.First;
    while not FDQry.Eof do
    begin
      FDMem.AppendRecord([
        FDQry.Fields[0].AsInteger,
        FDQry.Fields[1].AsString,
        FDQry.Fields[2].AsString,
        FDQry.Fields[3].AsString,
        FDQry.Fields[4].AsString,
        FDQry.Fields[5].AsBoolean
      ]);
      FDQry.Next;
    end;
    FDQry.Close;
  end;
end;

end.
