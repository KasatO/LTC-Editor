unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI;

function GetAppVersion(NameApp: String): String;

type
  TfrmAbout = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    ProgramIcon: TImage;
    Link: TLabel;
    Mail: TLabel;
    Copyright2: TLabel;
    Version: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure LinkClick(Sender: TObject);
    procedure MailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

uses
  Main;

function GetAppVersion(NameApp: String): String;
var
  Dump: DWORD;
  Size: Integer;
  Buffer: PChar;
  VersionPointer, TransBuffer: PChar;
  Temp: Integer;
  CalcLangCharSet: String;
begin

  Size := GetFileVersionInfoSize(PChar(NameApp), Dump);
  Buffer := StrAlloc(Size * 2 + 2);

  try
    GetFileVersionInfo(PChar(NameApp), 0, Size * 2, Buffer);
    VerQueryValue(Buffer, '\VarFileInfo\Translation', Pointer(TransBuffer), Dump);
    if Dump >= 4 then begin
      Temp := 0;
      StrLCopy(@Temp, TransBuffer, 1);
      CalcLangCharSet := IntToHex(Temp, 4);
      StrLCopy(@Temp, TransBuffer + 1, 1);
      CalcLangCharSet := CalcLangCharSet + IntToHex(Temp, 4);
    end;
    VerQueryValue(Buffer, PChar('\StringFileInfo\' + CalcLangCharSet +
      '\FileVersion'), Pointer(VersionPointer), Dump);
    if (Dump > 1) then
    begin
      SetLength(Result, Dump);
      StrLCopy(PChar(Result), VersionPointer, Dump);
    end
    else
      Result := '0.0.0.0';
  finally
    StrDispose(Buffer);
  end;

end;

procedure TfrmAbout.OKButtonClick(Sender: TObject);
begin

  Close;

end;

procedure TfrmAbout.LinkClick(Sender: TObject);
begin

  ShellExecute(0, 'open', 'http://www.fmfan.ru', '', '', sw_ShowDefault);

end;

procedure TfrmAbout.MailClick(Sender: TObject);
begin

  ShellExecute(0, 'open', PChar('mailto:necrosoft@nm.ru?subject=LTC Editor ' +
    Version.Caption), '', '', sw_ShowDefault);

end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin

  Version.Caption := GetAppVersion(Application.ExeName);
  ProgramIcon.Picture.Icon := Application.Icon;

end;

end.

