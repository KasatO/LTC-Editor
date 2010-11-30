unit Menu;

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
  Dialogs, StdCtrls;

type
  TMenuForm = class(TForm)
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuForm: TMenuForm;

Procedure GetSetings(Var FRussOnly,FUsePrefiks:boolean;Var Fprefiks:string);

implementation

uses PAmultilang;

{$R *.dfm}

procedure TMenuForm.CheckBox1Click(Sender: TObject);
begin
  Edit1.Enabled:=CheckBox1.Checked;
end;

procedure TMenuForm.FormCreate(Sender: TObject);
begin
  CheckBox1Click(Self);
  IniLang(TCustomForm(Self)); // инициализация языка
end;

Procedure GetSetings(Var FRussOnly,FUsePrefiks:boolean;Var Fprefiks:string);
Var
   x:TMenuForm;
Begin
  x:=TMenuForm.Create(Application);
  x.CheckBox1.Checked:=FUsePrefiks;
  x.CheckBox2.Checked:=FRussOnly;
  x.Edit1.Text:=Fprefiks;
  x.ShowModal;
  if x.ModalResult=mrOk then
    Begin
      FRussOnly:=x.CheckBox2.Checked;
      FUsePrefiks:=x.CheckBox1.Checked;
      Fprefiks:=x.Edit1.Text;
    End;
  x.Free;
End;

end.
