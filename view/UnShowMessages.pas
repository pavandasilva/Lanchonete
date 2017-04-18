unit UnShowMessages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ImgList, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TIcon = (iError, iOk);
  TfrmShowMessages = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    imIcon: TImage;
    btnOk: TPanel;
    imlIcons: TImageList;
    procedure FormShow(Sender: TObject);
    procedure btnOKMouseEnter(Sender: TObject);
    procedure btnOKMouseLeave(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private


    { Private declarations }
  public
    Icon : TIcon;
    procedure showMessage(Aicon : TIcon ; Amessage: String);

  end;

var
  frmShowMessages: TfrmShowMessages;

implementation

{$R *.dfm}

procedure TfrmShowMessages.btnOKMouseLeave(Sender: TObject);
begin
  btnOK.Color := $003B3B3B;
end;

procedure TfrmShowMessages.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmShowMessages.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  imIcon.Picture:= nil;
  Memo1.Text := '';
end;

procedure TfrmShowMessages.FormShow(Sender: TObject);
begin
   Panel1.Left := trunc ((Self.Width / 2) - (Panel1.Width / 2));
   Panel1.Top := trunc ((Self.Height / 2) - (Panel1.Height / 2));
end;




procedure TfrmShowMessages.showMessage(Aicon : TIcon ; Amessage: String);
begin
  if Aicon = iError then
    imlIcons.GetBitmap(1,imIcon.Picture.Bitmap)
  else if Aicon = iOk then
    imlIcons.GetBitmap(0,imIcon.Picture.Bitmap);
  Memo1.Clear;
  Memo1.Text:= Amessage;
  Self.ShowModal;
end;

procedure TfrmShowMessages.btnOKClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmShowMessages.btnOKMouseEnter(Sender: TObject);
begin
  btnOK.Color :=  $00666666;;
end;

end.
