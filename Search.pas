unit Search;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmSearch = class(TForm)
    grpSearch: TGroupBox;
    lblEng: TLabel;
    txtEng: TEdit;
    lblTrans: TLabel;
    txtTrans: TEdit;
    chkTransAsEng: TCheckBox;
    chkFAll: TCheckBox;
    chkFNotTranslated: TCheckBox;
    chkFChanged: TCheckBox;
    chkFAdded: TCheckBox;
    chkFRemoved: TCheckBox;
    chkFErroneous: TCheckBox;
    grpReplace: TGroupBox;
    txtReplace: TEdit;
    chkReplace: TCheckBox;
    btnSearch: TButton;
    btnReplace: TButton;
    btnReplaceAll: TButton;
    btnSearchNext: TButton;
    chkCaseSens: TCheckBox;
    procedure chkTransAsEngClick(Sender: TObject);
    procedure chkReplaceClick(Sender: TObject);
    procedure chkFAllClick(Sender: TObject);
    procedure txtEngChange(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnSearchNextClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnReplaceAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearch: TfrmSearch;

implementation

uses
  Main, Lang;

{$R *.dfm}

procedure SearchText(BaseIndex: Integer; Replace: Boolean; ReplaceAll: Boolean);
var
  i: Integer;
  bFound, bNotFoundAtAll: Boolean;
  sSearchEng, sSearchTrans, sReplace, sEng, sTrans: String;
  rfReplFlag: TReplaceFlags;
begin

  if BaseIndex = frmMain.lstFile.Items.Count then
    Exit;

  Screen.Cursor := crHourglass;

  sReplace := frmSearch.txtReplace.Text;
  if not frmSearch.chkCaseSens.Checked then
  begin
    sSearchEng := UpperCase(frmSearch.txtEng.Text);
    sSearchTrans := UpperCase(frmSearch.txtTrans.Text);

    rfReplFlag := [rfReplaceAll, rfIgnoreCase];
  end
  else
  begin
    sSearchEng := frmSearch.txtEng.Text;
    sSearchTrans := frmSearch.txtTrans.Text;

    rfReplFlag := [rfReplaceAll]
  end;

  bNotFoundAtAll := True;
  for i := BaseIndex + 1 to frmMain.lstFile.Items.Count - 1 do
  begin
    bFound := False;

    if not frmSearch.chkFAll.Checked then
    begin
      if frmSearch.chkFNotTranslated.Checked and
        not LangRecords[i].NotTranslated then
        Continue;
      if frmSearch.chkFChanged.Checked and
        not LangRecords[i].Changed then
        Continue;
      if frmSearch.chkFAdded.Checked and
        not LangRecords[i].Added then
        Continue;
      if frmSearch.chkFRemoved.Checked and
        LangRecords[i].Removed then
        Continue;
      if frmSearch.chkFErroneous.Checked and
        LangRecords[i].Error then
        Continue;
    end;

    if not frmSearch.chkCaseSens.Checked then
    begin
      sEng := UpperCase(frmMain.lstFile.Items[i].SubItems[0]);
      sTrans := UpperCase(frmMain.lstFile.Items[i].SubItems[1]);
    end
    else
    begin
      sEng := frmMain.lstFile.Items[i].SubItems[0];
      sTrans := frmMain.lstFile.Items[i].SubItems[1];
    end;

    if not Replace and
      (sSearchEng <> '') and
      (Pos(sSearchEng, sEng) > 0) then
      bFound := True;

    if not bFound and
      frmSearch.chkTransAsEng.Checked and
      (Pos(sSearchEng, sTrans) > 0) then
      bFound := True;

    if not bFound and
      not frmSearch.chkTransAsEng.Checked and
      (Pos(sSearchTrans, sTrans) > 0) then
      bFound := True;

    if not bFound then
      Continue;

  	frmMain.lstFile.Items[frmMain.lstFile.Selected.Index].Selected := False;

    frmMain.lstFile.Items[i].Selected := True;
    frmMain.lstFile.Items[i].Focused := True;
    frmMain.lstFile.Items[i].MakeVisible(False);

    if Replace then
    begin
      if frmSearch.chkTransAsEng.Checked then
        frmMain.memTrans.Text := StringReplace(frmMain.memTrans.Text,
          sSearchEng, sReplace, rfReplFlag)
      else
        frmMain.memTrans.Text := StringReplace(frmMain.memTrans.Text,
          sSearchTrans, sReplace, rfReplFlag);

      CompareTranslation;
    end;

    bNotFoundAtAll := False;

    if not Replace or not ReplaceAll then
      Break;
  end;

  if bNotFoundAtAll then
    MsgBox(PChar(Lng_NotFound));

  Screen.Cursor := crDefault;

end;

procedure TfrmSearch.btnReplaceAllClick(Sender: TObject);
begin

  SearchText(-1, True, True);

end;

procedure TfrmSearch.btnReplaceClick(Sender: TObject);
begin

  if frmMain.lstFile.Selected <> nil then
    SearchText(frmMain.lstFile.Selected.Index - 1, True, False)
  else
    SearchText(-1, True, False);

end;

procedure TfrmSearch.btnSearchClick(Sender: TObject);
begin

  SearchText(-1, False, False);

end;

procedure TfrmSearch.btnSearchNextClick(Sender: TObject);
begin

  if frmMain.lstFile.Selected <> nil then
    SearchText(frmMain.lstFile.Selected.Index, False, False)
  else
    SearchText(-1, False, False);

end;

procedure TfrmSearch.chkFAllClick(Sender: TObject);
begin

  if (Sender as TCheckBox).Checked then
  begin
    chkFNotTranslated.Checked := True;
    chkFNotTranslated.Enabled := False;
    chkFChanged.Checked := True;
    chkFChanged.Enabled := False;
    chkFAdded.Checked := True;
    chkFAdded.Enabled := False;
    chkFRemoved.Checked := True;
    chkFRemoved.Enabled := False;
    chkFErroneous.Checked := True;
    chkFErroneous.Enabled := False;
  end
  else
  begin
    chkFNotTranslated.Enabled := True;
    chkFChanged.Enabled := True;
    chkFAdded.Enabled := True;
    chkFRemoved.Enabled := True;
    chkFErroneous.Enabled := True;
  end;

end;

procedure TfrmSearch.chkReplaceClick(Sender: TObject);
begin

  txtReplace.Enabled := (Sender as TCheckBox).Checked;
  txtEngChange(txtEng);

end;

procedure TfrmSearch.chkTransAsEngClick(Sender: TObject);
begin

  txtTrans.Enabled := not (Sender as TCheckBox).Checked;
  txtEngChange(txtEng);

end;

procedure TfrmSearch.txtEngChange(Sender: TObject);
var
  CanSearch: Boolean;
begin

  CanSearch := txtEng.Text <> '';
  if not CanSearch then
    CanSearch := not chkTransAsEng.Checked and (txtTrans.Text <> '')
  else
    if not chkTransAsEng.Checked then
      CanSearch := txtTrans.Text <> '';

  btnSearch.Enabled := CanSearch;
  btnSearchNext.Enabled := CanSearch;

  btnReplace.Enabled := CanSearch and chkReplace.Checked;
  btnReplaceAll.Enabled := CanSearch and chkReplace.Checked;

end;

end.
