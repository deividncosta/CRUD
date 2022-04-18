unit unCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.JSON, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCliente = class(TForm)
    PanelCliente: TPanel;
    edtNome: TLabeledEdit;
    rgPF: TRadioButton;
    rgPJ: TRadioButton;
    edtCPFCNPJ: TMaskEdit;
    lblCPFNCPJ: TLabel;
    lblRGIE: TLabel;
    edtRGIE: TMaskEdit;
    dtpData: TDateTimePicker;
    lblData: TLabel;
    chkAtivo: TCheckBox;
    edtTelefone: TMaskEdit;
    lblTelefone: TLabel;
    BtnAdd: TButton;
    ListBoxTelefones: TListBox;
    edtCEP: TMaskEdit;
    lblCEP: TLabel;
    edtLogradouro: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtUF: TLabeledEdit;
    edtPais: TLabeledEdit;
    btnSalvar: TButton;
    RESTRequest: TRESTRequest;
    RESTClient: TRESTClient;
    RESTResponse: TRESTResponse;
    procedure FormShow(Sender: TObject);
    procedure rgPFClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure ListBoxTelefonesDblClick(Sender: TObject);
    procedure edtCEPKeyPress(Sender: TObject; var Key: Char);
    procedure edtCEPExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetMaks;
    procedure ConsultaCEP;
    function GetCPFCNPJ: String;
    function GetRGIE: String;
    function ValidaCampos(out CAMPO: String): Boolean;
    function GetTelefone(const NUMERO: String): String;
    procedure SaveCliente;
    procedure UpdateCliente;
  public
    { Public declarations }
    IDCliente: Integer;
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

uses uDM, unMain;

{ TfrmCliente }

procedure TfrmCliente.SaveCliente;
var
  ID, I: Integer;
  Telefone: String;
begin
  with DM do
  begin
    {$REGION 'Verifica o CPF/CNPJ'}
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('SELECT NOME FROM CRUD.DBO.CLIENTE WHERE CPFCNPJ = :CPFCNPJ');
    FDQry.ParamByName('CPFCNPJ').AsString := edtCPFCNPJ.Text;
    FDQry.Open();
    if not FDQry.IsEmpty then
    begin
      ShowMessage('Já existe um cliente(' + FDQry.Fields[0].AsString + ') cadastrado com esse CNPJ.');
      FDQry.Close;
      Exit;
    end;
    {$ENDREGION}
    {$REGION 'Gravar registro - TABELA CLIENTE'}
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('INSERT INTO CRUD.DBO.CLIENTE(TIPO, NOME, CPFCNPJ, RGIE)VALUES(:TIPO, :NOME, :CPFCNPJ, :RGIE)');
    case rgPF.Checked of
      True:  FDQry.ParamByName('TIPO').AsString := 'F';
      False: FDQry.ParamByName('TIPO').AsString := 'J';
    end;
    FDQry.ParamByName('NOME').AsString    := edtNome.Text;
    FDQry.ParamByName('CPFCNPJ').AsString := GetCPFCNPJ;
    FDQry.ParamByName('RGIE').AsString    := GetRGIE;
    FDQry.SQL.Add('SELECT @@IDENTITY');
    FDQry.Open();
    ID := FDQry.Fields[0].AsInteger;
    {$ENDREGION}
    {$REGION 'Gravar registro - TABELA TELEFONE'}
    for I := 0 to Pred(ListBoxTelefones.Items.Count) do
    begin
      Telefone := GetTelefone(ListBoxTelefones.Items[I]);
      FDQry.Close;
      FDQry.SQL.Clear;
      FDQry.SQL.Add('INSERT INTO CRUD.DBO.TELEFONE(CLIENTE, DDD, TELEFONE)VALUES(:CLIENTE, :DDD, :TELEFONE)');
      FDQry.ParamByName('CLIENTE').AsInteger := ID;
      FDQry.ParamByName('DDD').AsString      := Copy(Telefone,0,2);
      FDQry.ParamByName('TELEFONE').AsString := Copy(Telefone,3,10);
      FDQry.ExecSQL;
    end;
    {$ENDREGION}
    {$REGION 'Gravar registro - TABELA ENDERECO'}
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('INSERT INTO CRUD.DBO.ENDERECO(CLIENTE, LOGRADOURO, NUMERO, CEP, BAIRRO, CIDADE, UF, PAIS)');
    FDQry.SQL.Add('VALUES(:CLIENTE, :LOGRADOURO, :NUMERO, :CEP, :BAIRRO, :CIDADE, :UF, :PAIS)');
    FDQry.ParamByName('CLIENTE').AsInteger := ID;
    FDQry.ParamByName('LOGRADOURO').AsString := edtLogradouro.Text;
    FDQry.ParamByName('NUMERO').AsInteger    := StrToInt(edtNumero.Text);
    FDQry.ParamByName('CEP').AsString        := StringReplace(edtCEP.Text, '-', '', [rfReplaceAll]);
    FDQry.ParamByName('BAIRRO').AsString     := edtBairro.Text;
    FDQry.ParamByName('CIDADE').AsString     := edtCidade.Text;
    FDQry.ParamByName('UF').AsString         := edtUF.Text;
    FDQry.ParamByName('PAIS').AsString       := edtPais.Text;
    FDQry.ExecSQL;
    {$ENDREGION}
    FDQry.Close;
    ShowMessage('Cliente salvo com sucesso!');
  end;
end;

procedure TfrmCliente.SetMaks;
begin
  if rgPF.Checked then
  begin
    edtCPFCNPJ.EditMask := '999.999.999-99;1;_';
    lblCPFNCPJ.Caption  := 'CPF:';
    edtRGIE.EditMask    := '99.999.999-A;1;_';
    lblRGIE.Caption     := 'RG:';
  end
  else
  begin
    edtCPFCNPJ.EditMask := '99.999.999/9999-99;1;_';
    lblCPFNCPJ.Caption  := 'CNPJ:';
    edtRGIE.EditMask    := '999.999.999.999;1;_';
    lblRGIE.Caption     := 'IE:';
  end;
end;

procedure TfrmCliente.UpdateCliente;
var
  ID, I: Integer;
  Telefone: String;
begin
  with DM do
  begin
    {$REGION 'Gravar registro - TABELA CLIENTE'}
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('UPDATE CRUD.DBO.CLIENTE SET TIPO = :TIPO, NOME = :NOME, CPFCNPJ = :CPFCNPJ, RGIE = :RGIE WHERE ID = :id');
    case rgPF.Checked of
      True:  FDQry.ParamByName('TIPO').AsString := 'F';
      False: FDQry.ParamByName('TIPO').AsString := 'J';
    end;
    FDQry.ParamByName('NOME').AsString    := edtNome.Text;
    FDQry.ParamByName('CPFCNPJ').AsString := GetCPFCNPJ;
    FDQry.ParamByName('RGIE').AsString    := GetRGIE;
    FDQry.ParamByName('ID').AsInteger     := IDCliente;
    FDQry.ExecSQL;
    {$ENDREGION}
    {$REGION 'Gravar registro - TABELA TELEFONE'}
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('DELETE CRUD.DBO.TELEFONE WHERE CLIENTE = :ID ');
    FDQry.ParamByName('ID').AsInteger := IDCliente;
    FDQry.ExecSQL;
    for I := 0 to Pred(ListBoxTelefones.Items.Count) do
    begin
      Telefone := GetTelefone(ListBoxTelefones.Items[I]);
      FDQry.Close;
      FDQry.SQL.Clear;
      FDQry.SQL.Add('INSERT INTO CRUD.DBO.TELEFONE(CLIENTE, DDD, TELEFONE)VALUES(:CLIENTE, :DDD, :TELEFONE)');
      FDQry.ParamByName('CLIENTE').AsInteger := IDCliente;
      FDQry.ParamByName('DDD').AsString      := Copy(Telefone,0,2);
      FDQry.ParamByName('TELEFONE').AsString := Copy(Telefone,3,10);
      FDQry.ExecSQL;
    end;
    {$ENDREGION}
    {$REGION 'Gravar registro - TABELA ENDERECO'}
    FDQry.Close;
    FDQry.SQL.Clear;
    FDQry.SQL.Add('UPDATE CRUD.DBO.ENDERECO SET LOGRADOURO = :LOGRADOURO, NUMERO = :NUMERO, CEP = :CEP, BAIRRO = :BAIRRO, CIDADE = :CIDADE, UF = :UF, PAIS = :PAIS');
    FDQry.SQL.Add('WHERE CLIENTE = :ID');
    FDQry.ParamByName('ID').AsInteger := IDCliente;
    FDQry.ParamByName('LOGRADOURO').AsString := edtLogradouro.Text;
    FDQry.ParamByName('NUMERO').AsInteger    := StrToInt(edtNumero.Text);
    FDQry.ParamByName('CEP').AsString        := StringReplace(edtCEP.Text, '-', '', [rfReplaceAll]);
    FDQry.ParamByName('BAIRRO').AsString     := edtBairro.Text;
    FDQry.ParamByName('CIDADE').AsString     := edtCidade.Text;
    FDQry.ParamByName('UF').AsString         := edtUF.Text;
    FDQry.ParamByName('PAIS').AsString       := edtPais.Text;
    FDQry.ExecSQL;
    {$ENDREGION}
    FDQry.Close;
    ShowMessage('Cliente atualizado com sucesso!');
  end;
end;

function TfrmCliente.GetTelefone(const NUMERO: String): String;
begin
  Result := Trim(NUMERO);
  Result := StringReplace(Result,'(', '', [rfReplaceAll]);
  Result := StringReplace(Result,')', '', [rfReplaceAll]);
  Result := StringReplace(Result,'-', '', [rfReplaceAll]);
end;

function TfrmCliente.ValidaCampos(out CAMPO: String): Boolean;
begin
  Result := True;
  if Trim(edtNome.Text) = '' then
  begin
    CAMPO  := 'NOME';
    Result := False;
  end;
  if GetCPFCNPJ = '' then
  begin
    case rgPF.Checked of
      True:  CAMPO  := 'CPF';
      False: CAMPO  := 'CNPJ';
    end;
    Result := False;
  end;
  if GetRGIE = '' then
  begin
    case rgPF.Checked of
      True:  CAMPO  := 'RG';
      False: CAMPO  := 'IE';
    end;
    Result := False;
  end;
  if Trim(edtLogradouro.Text) = '' then
  begin
    CAMPO := 'ENDEREÇO';
    Result := False;
  end;
end;

procedure TfrmCliente.BtnAddClick(Sender: TObject);
begin
  if edtTelefone.Text = '(  )    -     ' then
  begin
    ShowMessage('Informe um telefone.');
    Exit;
  end;
  if Length(GetTelefone(edtTelefone.Text)) < 8 then
  begin
    ShowMessage('Informe um telefone válido.');
    Exit;
  end;
  ListBoxTelefones.Items.Add(edtTelefone.Text);
  edtTelefone.Clear;
  edtTelefone.SetFocus;
end;

procedure TfrmCliente.btnSalvarClick(Sender: TObject);
var
  Campo: String;
begin
  if not ValidaCampos(CAMPO) then
  begin
    ShowMessage('Informe um valor para o campo "' + Campo + '".');
    Exit;
  end;
  case (IDCliente > 0) of
    True:  UpdateCliente;
    False: SaveCliente;
  end;
  frmMain.LoadCliente;
  Close;
end;

procedure TfrmCliente.ConsultaCEP;
var
  CEP: String;
  JSONObject: TJSONObject;
  JSubPar: TJSONPair;
  I: Integer;
const
  VIACEP:  String = 'https://viacep.com.br/ws/%s/json/';
begin
  CEP := StringReplace(edtCEP.Text, '-', '', [rfReplaceAll]);
  RESTClient.BaseURL := Format(VIACEP, [CEP]);
  RESTRequest.Execute;
  if RESTRequest.Response.StatusCode = 200 then
  begin
    JSONObject := TJSONObject.Create;
    try
      JSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(RESTRequest.Response.JSONText),0) as TJSONObject;
      for I := 0 to JSONObject.Count - 1 do  begin
        jSubPar := JSONObject.Pairs[I];
        if AnsiUpperCase(Trim(jSubPar.JsonString.Value)) = 'LOGRADOURO' then
          edtLogradouro.Text := jSubPar.JsonValue.Value;
        if AnsiUpperCase(Trim(jSubPar.JsonString.Value)) = 'LOCALIDADE' then
          edtCidade.Text := jSubPar.JsonValue.Value;
        if AnsiUpperCase(Trim(jSubPar.JsonString.Value)) = 'UF' then
          edtUF.Text := jSubPar.JsonValue.Value;
        if AnsiUpperCase(Trim(jSubPar.JsonString.Value)) = 'BAIRRO' then
          edtBairro.Text := jSubPar.JsonValue.Value;
      end;
      edtNumero.SetFocus;
    finally
      JSONObject.Free;
    end;
  end;
end;

procedure TfrmCliente.edtCEPExit(Sender: TObject);
begin
  if edtLogradouro.Text = '' then
    ConsultaCEP;
end;

procedure TfrmCliente.edtCEPKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    ConsultaCEP;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  dtpData.DateTime := Now();
  IDCliente := 0;
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  SetMaks;
end;

function TfrmCliente.GetCPFCNPJ: String;
begin
  Result := Trim(edtCPFCNPJ.Text);
  Result := StringReplace(Result,'-','',[rfReplaceAll]);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
  Result := StringReplace(Result,'/','',[rfReplaceAll]);
end;

function TfrmCliente.GetRGIE: String;
begin
  Result := Trim(edtRGIE.Text);
  Result := StringReplace(Result,'-','',[rfReplaceAll]);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
end;

procedure TfrmCliente.ListBoxTelefonesDblClick(Sender: TObject);
begin
  ListBoxTelefones.Items.Delete(ListBoxTelefones.ItemIndex);
end;

procedure TfrmCliente.rgPFClick(Sender: TObject);
begin
  SetMaks;
end;

end.
