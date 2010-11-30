unit AboutUnit;

     ///////////////////////////////////////////
     //                                       //
     //   (C) 2003 PA                         //
     //                                       //
     //   сайт       www.zldo.narod.ru        //
     //   почта      zldo@mail15.com          //
     //              pa@mw.narzan.com         //
     //                                       //
     ///////////////////////////////////////////

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, ExtCtrls;

type
  TAbout = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Image1: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Label2: TLabel;
    Label3: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    procedure Label11Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label11MouseEnter(Sender: TObject);
    procedure Label11MouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure About;

implementation

uses PAmultilang, ExMain;

{$R *.dfm}

Procedure About;
Begin
  TAbout.Create(Application).ShowModal;
End;

procedure TAbout.Label11Click(Sender: TObject);
begin
 ShellExecute(Application.Handle,'open','http://www.zldo.narod.ru',nil,nil,0);
end;

procedure TAbout.Label12Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,'open','mailto:pa@mv.narzan.com',nil,nil,0);
end;

procedure TAbout.Label13Click(Sender: TObject);
begin
  ShellExecute(Application.Handle,'open','mailto:pa@stav.ru',nil,nil,0);
end;

procedure TAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TAbout.Label11MouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color:=clBlue;
  (Sender as TLabel).Font.Style:=[fsUnderline];
end;

procedure TAbout.Label11MouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color:=clWindowText;
  (Sender as TLabel).Font.Style:=[];
end;

procedure TAbout.FormCreate(Sender: TObject);
begin
  IniLang(TCustomForm(Self)); // инициализация языка
  if FileExists(HelpKeyFileName)then
    Memo1.Lines.LoadFromFile(HelpKeyFileName);
  Label11.Left:=label2.Left+label2.Width+10;
  Label12.Left:=label3.Left+label3.Width+10;
  Label13.Left:=label12.Left+label12.Width+10;
end;

end.
