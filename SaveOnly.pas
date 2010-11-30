unit SaveOnly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmSaveOnly = class(TForm)
    chkChanged: TCheckBox;
    chkAdded: TCheckBox;
    chkRemoved: TCheckBox;
    chkNotTrans: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    rbtMarks: TRadioButton;
    rbtRange: TRadioButton;
    txtMin: TEdit;
    txtMax: TEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure rbtMarksClick(Sender: TObject);
    procedure chkChangedClick(Sender: TObject);
    procedure txtMinChange(Sender: TObject);
    procedure txtMinKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSaveOnly: TfrmSaveOnly;

implementation

uses
  Main;
  
{$R *.dfm}

procedure TfrmSaveOnly.btnCancelClick(Sender: TObject);
begin

  Close;

end;

procedure TfrmSaveOnly.btnOKClick(Sender: TObject);
begin

  if frmMain.dlgSave.Execute then
    ModalResult := mrOk;

end;

procedure TfrmSaveOnly.rbtMarksClick(Sender: TObject);
begin

  chkChanged.Enabled := rbtMarks.Checked;
  chkAdded.Enabled := rbtMarks.Checked;
  chkRemoved.Enabled := rbtMarks.Checked;
  chkNotTrans.Enabled := rbtMarks.Checked;

  txtMin.Enabled := rbtRange.Checked;
  txtMax.Enabled := rbtRange.Checked;

  txtMinChange(Sender);

end;

procedure TfrmSaveOnly.chkChangedClick(Sender: TObject);
begin

  btnOK.Enabled := (chkChanged.Checked or chkAdded.Checked or
     chkRemoved.Checked or chkNotTrans.Checked);
     

end;

procedure TfrmSaveOnly.txtMinChange(Sender: TObject);
var
  iMax, iMin: Integer;
begin

  if TryStrToInt(txtMin.Text, iMin) and
     TryStrToInt(txtMax.Text, iMax) then
    btnOK.Enabled := not ((iMin > iMax) or (iMax > Length(LangRecords)) or
      (iMax <=0));

end;

procedure TfrmSaveOnly.txtMinKeyPress(Sender: TObject; var Key: Char);
begin

  case Key of
    '0'..'9': ;
    #8: ;
  else
    Key := #0;
    Beep;
  end;

end;

end.
