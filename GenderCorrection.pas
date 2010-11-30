unit GenderCorrection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmGenderCorrection = class(TForm)
    lblCorrection: TLabel;
    rbtToString: TRadioButton;
    rbtFromString: TRadioButton;
    btnStart: TButton;
    btnCancel: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGenderCorrection: TfrmGenderCorrection;

implementation

{$R *.dfm}

uses
  Main;

procedure TfrmGenderCorrection.btnCancelClick(Sender: TObject);
begin

  Close;

end;

procedure TfrmGenderCorrection.btnStartClick(Sender: TObject);
var
  i: Integer;
begin

  Screen.Cursor := crHourglass;

  for i := Low(LangRecords) to High(LangRecords) - 1 do
  begin
    if LangRecords[i].ID = 244722 then
      Beep;

    if rbtToString.Checked then
      StrCopy(@LangRecords[i].Trans, PChar(ReplaceGender(LangRecords[i].Original,
      LangRecords[i].Trans, LangRecords[i].Gender)))
    else
      StrCopy(@LangRecords[i].Gender, PChar(TakeGender(LangRecords[i].Eng,
        LangRecords[i].Trans)));
  end;

  Screen.Cursor := crDefault;

  MsgBox('Коррекция проведена');

end;

end.
