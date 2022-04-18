unit unConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, IniFiles;

type
  TfrmConfig = class(TForm)
    edtServer: TLabeledEdit;
    edtLogin: TLabeledEdit;
    edtSenha: TLabeledEdit;
    btnSalvar: TButton;
    Button1: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmConfig.btnSalvarClick(Sender: TObject);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(ExtractFileDir(GetCurrentDir) + 'Config.ini');
  Arq.WriteString('CONFIG', 'SERVER', edtServer.Text);
  Arq.WriteString('CONFIG', 'USER', edtLogin.Text);
  Arq.WriteString('CONFIG', 'PASSWORD', edtSenha.Text);
  Arq.Free;
  ShowMessage('Configuração salva!');
  Close;
end;

procedure TfrmConfig.Button1Click(Sender: TObject);
begin
  try
    DM.FDConn.Params.Values['Server']   := edtServer.Text;
    DM.FDConn.Params.Values['UserName'] := edtLogin.Text;
    DM.FDConn.Params.Values['Password'] := edtSenha.Text;
    DM.FDConn.Connected := True;
    if DM.FDConn.Connected then
      ShowMessage('Conexão realizada com sucesso!');
    DM.FDConn.Connected := False;
  except
  on E: Exception do
    ShowMessage('Erro ao conectado ao banco de dados!');
  end;
end;

end.
