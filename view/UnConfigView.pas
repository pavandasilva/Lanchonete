unit UnConfigView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Imaging.pngimage, Vcl.ExtCtrls, UnFormControl, IniFIles, Printers,
  UnShowMessages, Vcl.Mask;

type
  TfrmConfigView = class(TForm)
    pnTopo: TPanel;
    imgFechar: TImage;
    Panel2: TPanel;
    Label1: TLabel;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    paConfigGeral: TPanel;
    Label3: TLabel;
    edtBanco: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cbImpressora1: TComboBox;
    cbImpressora2: TComboBox;
    Label7: TLabel;
    Panel1: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    edtTaxa: TEdit;
    Label2: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtFantasia: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtRazao: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    edtBairro: TEdit;
    edtPassword: TEdit;
    edtUserName: TEdit;
    meTelefone: TMaskEdit;
    meCNPJ: TMaskEdit;
    meTelefone2: TMaskEdit;
    edtEndereco: TEdit;
    ImageList1: TImageList;
    cbImprimirPorPadrao: TCheckBox;
    Label20: TLabel;
    procedure ToolButton2Click(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbImpressora1KeyPress(Sender: TObject; var Key: Char);
    procedure cbImpressora2KeyPress(Sender: TObject; var Key: Char);
  private
    procedure FormataEditsDinheiro;
    procedure PreencheEdits;
    const
      _iniPath = 'config/config.ini';
  public
    { Public declarations }
  end;

var
  frmConfigView: TfrmConfigView;

implementation

{$R *.dfm}

procedure TfrmConfigView.cbImpressora1KeyPress(Sender: TObject; var Key: Char);
begin
  key := #0;
end;

procedure TfrmConfigView.cbImpressora2KeyPress(Sender: TObject; var Key: Char);
begin
  key := #0;
end;

procedure TfrmConfigView.FormataEditsDinheiro;
var
  umFormControl : TFormControl;
begin
   umFormControl := TFormControl.Create;
   try
     umFormControl.EditFormatCurrency(edtTaxa);
   finally
     FreeAndNil(umFormControl);
   end;
end;

procedure TfrmConfigView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmConfigView.FormCreate(Sender: TObject);
begin
  FormataEditsDinheiro;
  PreencheEdits;

end;

procedure TfrmConfigView.FormDestroy(Sender: TObject);
begin
  frmConfigView := nil;
end;

procedure TfrmConfigView.imgFecharClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmConfigView.pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  umFormControl : TFormControl;
begin
  umFormControl := TFormControl.Create;
  try
    umformControl.SetCliqueAndDrag(Self, Button); //coloca o arrasta e solta no painel do topo
  finally
    FreeAndNil(umFormControl);
  end;
end;
procedure TfrmConfigView.PreencheEdits;
var
  I  : Integer;
  umPrinter : TPrinter;
  umIniFile : TIniFile;
begin
  umIniFile := TIniFile.Create(_iniPath );
  umPrinter := TPrinter.Create;
  try
    for I := 0 to Printer.Printers.Count - 1 do
    begin
      cbImpressora1.Items.Add(Printer.Printers.Strings[I]);
      cbImpressora2.Items.Add(Printer.Printers.Strings[I]);
    end;
    cbImpressora1.ItemIndex :=  cbImpressora1.Items.IndexOf(umIniFile.ReadString('printer','device',''));
    cbImpressora2.ItemIndex :=  cbImpressora2.Items.IndexOf(umIniFile.ReadString('printer','device2',''));
    edtFantasia.Text := umIniFile.ReadString('store','fantasia', '');
    edtRazao.Text := umIniFile.ReadString('store','razao', '');
    meCNPJ.Text := umIniFile.ReadString('store','cnpj', '');
    edtEndereco.Text := umIniFile.ReadString('store','endereco', '');
    edtBairro.Text := umIniFile.ReadString('store','bairro', '');
    meTelefone.Text := umIniFile.ReadString('store','telefone', '');
    meTelefone2.Text := umIniFile.ReadString('store','telefone2', '');
    edtBanco.Text := umIniFile.ReadString('database','path','');
    edtUserName.Text := umIniFile.ReadString('database','user','');
    edtPassword.Text := umIniFile.ReadString('database','pass','');
    edtTaxa.Text := umIniFile.ReadString('system','delivery','');
    if umIniFile.ReadString('printer','print','') = 'yes' then
      cbImprimirPorPadrao.Checked := true
    else if umIniFile.Readstring('printer','print','') = 'no' then
      cbImprimirPorPadrao.Checked := false
  finally
    umPrinter.Free;
    umIniFile.Free;
  end;
end;
procedure TfrmConfigView.ToolButton2Click(Sender: TObject);
var
  umIniFile : TIniFile;
begin
  umIniFile := TIniFile.Create(_iniPath);
  try
    try
      umIniFile.WriteString('database','path', edtBanco.Text);
      umIniFile.WriteString('database','user', edtUserName.Text);
      umIniFile.WriteString('database','pass', edtPassword.Text);
      umIniFile.WriteString('printer','device', cbImpressora1.items[cbImpressora1.ItemIndex]);
      umIniFile.WriteString('printer','device2', cbImpressora2.items[cbImpressora2.ItemIndex]);
      umIniFile.WriteString('system','delivery', StringReplace(edtTaxa.Text,'.', '',[rfReplaceAll]));
      umIniFile.WriteString('store','cnpj', meCNPJ.Text);
      umIniFile.WriteString('store','fantasia', edtFantasia.Text);
      umIniFile.WriteString('store','endereco', edtEndereco.Text);
      umIniFile.WriteString('store','bairro', edtbairro.Text);
      umIniFile.WriteString('store','telefone', meTelefone.Text);
      umIniFile.WriteString('store','telefone2', meTelefone2.Text);
      umIniFile.WriteString('store','razao', edtRazao.Text);
      if cbImprimirPorPadrao.Checked then
        umIniFile.WriteString('printer','print', 'yes')
      else
        umIniFile.WriteString('printer','print', 'no');
      frmShowMessages.showMessage(iOk, 'Configurações salvas.');
    except
      frmShowMessages.showMessage(iOk, 'Não foi possível salvar as configurações.');
    end;
  finally
    umIniFile.Free;
    Close;
  end;
end;

end.
