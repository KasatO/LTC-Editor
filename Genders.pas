unit Genders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TfrmGenders = class(TForm)
    lstGenders: TListView;
    btnEdit: TButton;
    procedure FormShow(Sender: TObject);
    procedure lstGendersData(Sender: TObject; Item: TListItem);
    procedure lstGendersMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure txtEditBoxExit(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGenders: TfrmGenders;
  Line, Column: Integer;

implementation

uses
  Main, Lang;

{$R *.dfm}

procedure TfrmGenders.btnEditClick(Sender: TObject);
var
  EditStr: String;
  Genders: TStrings;
  iInd: Integer;
begin

  EditStr := lstGenders.Items[Line].SubItems[Column - 1];

  if InputQuery(Lng_EditGenderCaption, Lng_EditGender, EditStr) then
  begin
    iInd := (Column - 2) div 2;

    Genders := TStringList.Create;
    Genders.Text := GendersArray[iInd];
    Genders[Line * 3 + (Column - 2) mod 2 + 1] := EditStr;
    GendersArray[iInd] := Genders.Text;
    Genders.Free;
  end;

  (Sender as TButton).Visible := False;
  lstGenders.Refresh;

end;

procedure TfrmGenders.FormShow(Sender: TObject);
var
  i: Integer;
begin

  if GendersCount > 0 then
  begin
    if lstGenders.Columns.Count <> GendersCount * 2 + 2 then
    begin
      lstGenders.Columns.Clear;

      for i := 0 to GendersCount * 2 + 1 do
        with lstGenders.Columns.Add do
        begin
          if i = 0 then
            Caption := 'ID'
          else
            Caption := Lng_Gender;
          Width := 100;
        end;
    end;

    lstGenders.Items.Count := StringsCount;
  end
  else
  begin
    lstGenders.Columns.Clear;
    lstGenders.Items.Count := 0;
  end;

end;

procedure TfrmGenders.lstGendersData(Sender: TObject; Item: TListItem);
var
  i, iInd: Integer;
  Genders: TStrings;
begin

  if GendersCount = 0 then
    Exit;

  iInd := Item.Index * 3;

  Item.Caption := Format('%.6d', [Item.Index + 1]);

  Genders := TStringList.Create;

  Genders.Text := GendersArray[0];
  Item.SubItems.Add(Genders[iInd + 0]);
  Item.SubItems.Add(Genders[iInd + 1]);
  Item.SubItems.Add(Genders[iInd + 2]);

  for i := 1 to GendersCount - 1 do
  begin
    Genders.Text := GendersArray[i];
    Item.SubItems.Add(Genders[iInd + 1]);
    Item.SubItems.Add(Genders[iInd + 2]);
  end;

  Genders.Free;

end;

procedure TfrmGenders.lstGendersMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  i, Col, XX: Integer;
  ListItem: TlistItem;
begin

  if (Button = mbLeft) then
  begin
    Col := 0;

    ListItem := (Sender as TListView).GetItemAt(X, Y);
    P := ListItem.Position;

    XX := X - P.X;
    for i := 0 to (Sender as TListView).Columns.Count - 1 do
    begin
      XX := XX - (Sender as TListView).Columns[i].Width;

      if XX < 0 then
      begin
        Col := i;
        Break;
      end;
    end;

    Line := ListItem.Index;
    Column := Col;

    XX := 0;
    for i := 0 to Col do
      XX := XX + (Sender as TListView).Columns[i].Width;

    btnEdit.Left := (Sender as TListView).Left + XX + P.X - btnEdit.Width;
    btnEdit.Top := (Sender as TListView).Top + P.Y;
    btnEdit.Visible := True;
  end;

end;

procedure TfrmGenders.txtEditBoxExit(Sender: TObject);
begin

  (Sender as TEdit).Visible := False;

end;

end.
