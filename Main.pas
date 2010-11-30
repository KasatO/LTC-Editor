unit Main;

// Разобраться, почему не подгружается последняя строка из файла, где нет падежей

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ExtCtrls, Registry, IniFiles,
  CM4SupportClasses, RichEdit, XPMan;

procedure HTMLSyntax(RE: TRichEdit);
function MsgBox(Text: String; iIcon: Integer = mb_IconInformation;
  iButtons: Integer = mb_OK): Integer;
procedure CompareTranslation;
function TakeGender(Eng, Trans: String): String;
function SetGender(Eng, Gender: String): String;
function ReplaceGender(Eng, Trans, Gender: String): String;

type
  TFileHeader = packed record
    ID: WORD;
    Name: Array[1..4] of AnsiChar;
    Version: WORD;
    UnknownByte: Byte;
  end;

  TLangRecord = packed record
    Counter: DWORD;
    Variant: Byte;
    ID: DWORD;
    CountID: DWORD;
    Checksum: Byte;
    Eng: Array[0..1023] of Char;
    Trans: Array[0..1023] of Char;
    Original: Array[0..1023] of Char;
    Gender: Array[0..5] of Char;
    Changed: Boolean;
    Added: Boolean;
    Removed: Boolean;
    NotTranslated: Boolean;
    Error: Boolean;
  end;

type
  TfrmMain = class(TForm)
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    mnuMain: TMainMenu;
    mnuMFile: TMenuItem;
    mnuMAbout: TMenuItem;
    mnuMFOpen: TMenuItem;
    mnuMFSave: TMenuItem;
    mnuMFSaveAs: TMenuItem;
    mnuMFExit: TMenuItem;
    mnuMFLine1: TMenuItem;
    mnuMFLine5: TMenuItem;
    mnuMHAbout: TMenuItem;
    mnuMFLoadChanges: TMenuItem;
    pnlTrans: TPanel;
    pnlControl: TPanel;
    txtLangName: TEdit;
    lblSearch: TLabel;
    txtIndex: TEdit;
    txtSearch: TEdit;
    lblCaption: TLabel;
    prgMain: TProgressBar;
    pnlList: TPanel;
    lblPrevEng: TLabel;
    lblPrevChange: TLabel;
    lblPrevAdd: TLabel;
    lblNextEng: TLabel;
    lblNextChange: TLabel;
    lblNextAdd: TLabel;
    lstFile: TListView;
    Splitter1: TSplitter;
    chkCaseSens: TCheckBox;
    chkAutoSearch: TCheckBox;
    mnuMFLine3: TMenuItem;
    mnuMFExport: TMenuItem;
    mnuMFEVer3: TMenuItem;
    lblVersion: TLabel;
    popList: TPopupMenu;
    popRemove: TMenuItem;
    popRestore: TMenuItem;
    popLine1: TMenuItem;
    popInsert: TMenuItem;
    lblPrevErr: TLabel;
    lblPrevRem: TLabel;
    lblNextErr: TLabel;
    lblNextRem: TLabel;
    mnuMFSaveOnly: TMenuItem;
    mnuMLang: TMenuItem;
    mnuMLSave: TMenuItem;
    mnuMFSaveWork: TMenuItem;
    mnuMFLine2: TMenuItem;
    mnuMFLoadWork: TMenuItem;
    dlgOpenWork: TOpenDialog;
    dlgSaveWork: TSaveDialog;
    mnuMLLine1: TMenuItem;
    popLine2: TMenuItem;
    popSave: TMenuItem;
    mnuMFELTF: TMenuItem;
    mnuMFImport: TMenuItem;
    mnuMFILTF: TMenuItem;
    mnuOptions: TMenuItem;
    mnuMORegister: TMenuItem;
    mnuMOUnRegister: TMenuItem;
    mnuMFLine4: TMenuItem;
    mnuMFRecent: TMenuItem;
    lblCounts: TLabel;
    lblStatus: TLabel;
    mnuMFLoadAdding: TMenuItem;
    mnuMFOpenEnglish: TMenuItem;
    mnuMFLoadChangesSlow: TMenuItem;
    popMemo: TPopupMenu;
    memEng: TRichEdit;
    memTrans: TRichEdit;
    mnuMFSplit: TMenuItem;
    mnuMFSplitNum: TMenuItem;
    mnuMSCheck: TMenuItem;
    mnuMSLine2: TMenuItem;
    mnuMFEVer4: TMenuItem;
    mnuMFEVer5: TMenuItem;
    mnuMFELTFVer2: TMenuItem;
    btnSearchReplace: TButton;
    btnGenders: TButton;
    mnuMFELTFVer2Full: TMenuItem;
//    WordDoc: TWordDocument;
//    WordApp: TWordApplication;
    procedure mnuMFOpenClick(Sender: TObject);
    procedure lstFileData(Sender: TObject; Item: TListItem);
    procedure FormResize(Sender: TObject);
    procedure memTransKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuMFSaveClick(Sender: TObject);
    procedure mnuMFSaveAsClick(Sender: TObject);
    procedure mnuMFExitClick(Sender: TObject);
    procedure lstFileCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtIndexKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstFileSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure txtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuMHAboutClick(Sender: TObject);
    procedure mnuMFLoadChangesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure mnuMFEVer3Click(Sender: TObject);
    procedure popRemoveClick(Sender: TObject);
    procedure popRestoreClick(Sender: TObject);
    procedure popListPopup(Sender: TObject);
    procedure popInsertClick(Sender: TObject);
    procedure SearchColor(Sender: TObject);
    procedure mnuMFSaveOnlyClick(Sender: TObject);
    procedure mnuMLSaveClick(Sender: TObject);
    procedure mnuMFLoadWorkClick(Sender: TObject);
    procedure mnuMFSaveWorkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure popSaveClick(Sender: TObject);
    procedure mnuMFELTFClick(Sender: TObject);
    procedure mnuMFILTFClick(Sender: TObject);
    procedure mnuMORegisterClick(Sender: TObject);
    procedure mnuMOUnRegisterClick(Sender: TObject);
    procedure lstFileMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mnuMFLoadAddingClick(Sender: TObject);
    procedure mnuMFOpenEnglishClick(Sender: TObject);
    procedure memTransMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure memTransKeyPress(Sender: TObject; var Key: Char);
    procedure mnuMSCheckSpellingClick(Sender: TObject);
    procedure memTransExit(Sender: TObject);
    procedure mnuMFSplitClick(Sender: TObject);
    procedure mnuMFEVer4Click(Sender: TObject);
    procedure mnuMFEVer5Click(Sender: TObject);
    procedure btnSearchReplaceClick(Sender: TObject);
    procedure lstFileClick(Sender: TObject);
    procedure btnGendersClick(Sender: TObject);
    procedure memTransKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstFileMouseLeave(Sender: TObject);
    procedure lblStatusClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadLang(Sender: TObject);
    procedure TextReplace(Sender: TObject);
    procedure LoadRecent(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

  LangRecords: Array of TLangRecord;
  OldTransArray: Array of TLangRecord;
  GendersArray: Array of String;
  GendersCount: Word;
  StringsCount: Word;

  FileVersion: Byte;

  RecentList: TStrings;

  ChCount, AddCount, RemCount, EngCount, ErrCount: Integer;

  WordExists: Boolean;

	Punct: set of Char = [' '..'/', ':'..'@', '['..'`', '{'..'~'];
  OpenPunct: set of Char = ['<', '[', '{'];
  ClosePunct: set of Char = ['>', ']', '}'];

// Расцветка
const
// Изменение
  ChFontColor = $00008200;
  ChBgColor = $00B0EBB0;
// Добавлено
  AddFontColor = $0000BFBF;
  AddBgColor = $00BFFFFF;
// Удалено
  RemFontColor = $003F3F3F;
  RemBgColor = $00BFBFBF;
// Недоперевод
  EngFontColor = $007D0000;
  EngBgColor = $00E9AEAE;
// Ошибка
  ErrFontColor = $000000BF;
  ErrBgColor = $00BFBFFF;

implementation

uses
  SaveOnly, Search, About, PAmultilang, Lang, Genders, GenderCorrection;

{$R *.dfm}

function MsgBox(Text: String; iIcon: Integer = mb_IconInformation;
  iButtons: Integer = mb_OK): Integer;
begin

  Text := StringReplace(Text, '\n', #13, [rfReplaceAll]);

  Result := Application.MessageBox(PChar(Text), 'LTC Editor', iIcon + iButtons);

end;

procedure AddRecentList;
var
  i, j: Integer;
  miItem: TMenuItem;
begin

  for i := 0 to RecentList.Count - 1 do
  begin
    j := 1;
    while i + j < RecentList.Count do
    begin
      if SameText(RecentList[i], RecentList[i + j]) then
      begin
        RecentList.Delete(i + j);
        Dec(j);
      end;
      Inc(j);
    end;
  end;

  with frmMain do
  begin
    mnuMFRecent.Clear;

    for i := 1 to 10 do
    if RecentList.Count - i >= 0 then
	    begin
  	    miItem := TMenuItem.Create(mnuMFRecent);
    	  miItem.Caption := RecentList[RecentList.Count - i];
      	miItem.OnClick := LoadRecent;

	      mnuMFRecent.Add(miItem);
  	  end;
  end;
  
end;

procedure SaveSettings();
var
  reg: TRegistry;
  i: Integer;
  sTmp: String;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_CURRENT_USER;

  if reg.OpenKey('Software\NecroSoft\LTC Editor', True) then
  begin
    if frmMain.WindowState <> wsMaximized then
    begin
      reg.WriteInteger('Left', frmMain.Left);
      reg.WriteInteger('Top', frmMain.Top);
      reg.WriteInteger('Width', frmMain.Width);
      reg.WriteInteger('Height', frmMain.Height);
    end;
    reg.WriteInteger('WindowState', Integer(frmMain.WindowState));
    reg.WriteInteger('SplitterPos', frmMain.Splitter1.Top);

    for i := 2 to frmMain.mnuMLang.Count - 1 do
    begin
      sTmp := frmMain.mnuMLang.Items[i].Caption;
      sTmp := Copy(sTmp, 1, Pos(' - ', sTmp) - 1);
      if sTmp[1] = '&' then
        Delete(sTmp, 1, 1);
      reg.WriteBool(sTmp, frmMain.mnuMLang.Items[i].Checked);
    end;

    for i := 1 to 10 do
    	if i <= RecentList.Count then
	      reg.WriteString('Recent' + IntToStr(i), RecentList[RecentList.Count - i]);

    reg.WriteBool('Spell Check', frmMain.mnuMSCheck.Checked);

    reg.CloseKey;
  end;

  reg.Free;

end;

procedure LoadSettings();
var
  reg: TRegistry;
  i: Integer;
  sTmp: String;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_CURRENT_USER;

  if reg.OpenKey('Software\NecroSoft\LTC Editor', False) then
  begin
    if reg.ValueExists('Left') then
      frmMain.Left := reg.ReadInteger('Left');
    if reg.ValueExists('Top') then
      frmMain.Top := reg.ReadInteger('Top');
    if reg.ValueExists('Width') then
      frmMain.Width := reg.ReadInteger('Width');
    if reg.ValueExists('Height') then
      frmMain.Height := reg.ReadInteger('Height');
    if reg.ValueExists('WindowState') then
      frmMain.WindowState := TWindowState(reg.ReadInteger('WindowState'));
    if reg.ValueExists('SplitterPos') then
      frmMain.Splitter1.Top := reg.ReadInteger('SplitterPos');

    for i := 2 to frmMain.mnuMLang.Count - 1 do
    begin
      sTmp := frmMain.mnuMLang.Items[i].Caption;
      sTmp := Copy(sTmp, 1, Pos(' - ', sTmp) - 1);
      if sTmp[1] = '&' then
        Delete(sTmp, 1, 1);
      if reg.ValueExists(sTmp) then
        if reg.ReadBool(sTmp) then
          frmMain.LoadLang(frmMain.mnuMLang.Items[i]);
    end;

    for i := 10 downto 1 do
    begin
      if reg.ValueExists('Recent' + IntToStr(i)) then
        RecentList.Add(reg.ReadString('Recent' + IntToStr(i)));
    end;

    AddRecentList;

    if reg.ValueExists('Spell Check') then
      frmMain.mnuMSCheck.Checked := reg.ReadBool('Spell Check');

    reg.CloseKey;
  end;

  reg.Free;

end;

procedure CountMarks;
var
  i: Integer;
begin

  ChCount := 0; AddCount := 0; RemCount := 0;
  EngCount := 0; ErrCount := 0;

  for i := 0 to High(LangRecords) do
  begin
    if LangRecords[i].Changed then
      Inc(ChCount);
    if LangRecords[i].Added then
      Inc(AddCount);
    if LangRecords[i].Removed then
      Inc(RemCount);
    if LangRecords[i].NotTranslated then
      Inc(EngCount);
    if LangRecords[i].Error then
      Inc(ErrCount);
  end;

  frmMain.lblCounts.Caption := Format('%d (%d, %d, %d, %d, %d)',
    [Length(LangRecords), ChCount, AddCount, RemCount, EngCount, ErrCount]);

end;

function IsChanged: Boolean;
var
  i: Integer;
begin

  for i := 0 to High(LangRecords) do
    if LangRecords[i].Changed or LangRecords[i].Added or
       LangRecords[i].Removed then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
  
end;

function SaveIfChanged: Boolean;
var
  iRes: Integer;
begin

  frmMain.lblCaption.Caption := Lng_SearchingChanges;
  Application.ProcessMessages;

  Result := True;

  if IsChanged then
  begin
    iRes := MsgBox(Lng_ChangesFound, mb_IconQuestion, mb_YesNoCancel);
    case iRes of
      id_Yes: frmMain.mnuMFSaveAsClick(frmMain.mnuMFSaveAs);
      id_Cancel: Result := False;
    end;
  end;

  frmMain.lblCaption.Caption := '';
  Application.ProcessMessages;

end;

function IsStringsEqual(Str1, Str2: String; CaseSensitive: Boolean = False): Boolean;
var
  tmpStr1, tmpStr2: String;
begin

  tmpStr1 := StringReplace(Str1, '[', '<', [rfReplaceAll]);
  tmpStr1 := StringReplace(tmpStr1, ']', '>', [rfReplaceAll]);
  tmpStr2 := StringReplace(Str2, '[', '<', [rfReplaceAll]);
  tmpStr2 := StringReplace(tmpStr2, ']', '>', [rfReplaceAll]);

  if not CaseSensitive then
    Result := SameText(tmpStr1, tmpStr2)
  else
    Result := CompareStr(tmpStr1, tmpStr2) = 0;

end;

procedure UpdateInfoOpen(FileName: String);
begin

  with frmMain do
  begin
    lstFile.Items.Count := Length(LangRecords);
    lstFile.Items[0].Selected := True;

    prgMain.Position := 0;
    lblCaption.Caption := Lng_Loaded;

    mnuMFLoadChanges.Enabled := True;
    mnuMFLoadChangesSlow.Enabled := True;
    mnuMFLoadAdding.Enabled := True;
    mnuMFSave.Enabled := FileExists(dlgSave.FileName);
    mnuMFSaveAs.Enabled := True;
    mnuMFSaveOnly.Enabled := True;
    mnuMFExport.Enabled := True;
    mnuMFEVer3.Enabled := not (FileVersion = 3);
    mnuMFEVer4.Enabled := not (FileVersion = 4);
    mnuMFEVer5.Enabled := not (FileVersion = 5);
    mnuMFSaveWork.Enabled := True;

    if FileName = '' then
    	FileName := dlgOpen.FileName;

    Caption := 'LTC Editor - ' + ExtractFileName(FileName);
    lblVersion.Caption := 'v.' + IntToStr(FileVersion);
    case FileVersion of
      3:
        lblVersion.Caption := lblVersion.Caption + ' (FM06/07)';
      4:
        lblVersion.Caption := lblVersion.Caption + ' (FM08)';
      5:
        lblVersion.Caption := lblVersion.Caption + ' (FM09)';
    end;
    lstFile.Columns[2].Caption := txtLangName.Text;

    lstFile.Refresh;
  end;

end;

function GetMaxPerson(Str: String; Pattern: String = 'person'): Integer;
var
  tmpStr: String;
  iInd, iMax, iInt: Integer;
begin

  Result := 0;

  iInd := Pos('%' + Pattern + '#', Str);

  while iInd > 0 do
  begin
    iInd := iInd + Length(Pattern) + 2;
    iMax := iInd;
    while (Str[iMax] >= '0') and (Str[iMax] <= '9') and (iMax <= Length(Str)) do
      Inc(iMax);

    iInt := StrToIntDef(Copy(Str, iInd, iMax - iInd), 0);
    if iInt > Result then
      Result := iInt;

    Delete(Str, 1, iMax + 1);
    iInd := Pos('%' + Pattern + '#', Str);
  end;

end;

function TakeGender(Eng, Trans: String): String;
var
  i, iMax: Integer;
  Person, Male, Female: String;
begin

  Result := '';

  iMax := GetMaxPerson(Eng);

  for i := 1 to iMax do
  begin
    Person := '%person#' + IntToStr(i);
    Male := '%male#' + IntToStr(i);
    Female := '%female#' + IntToStr(i);

    if Pos(Person, Eng) > 0 then
    begin
      if Pos(Male, Trans) > 0 then
        Result := Result + 'M'
      else
        if Pos(Female, Trans) > 0 then
          Result := Result + 'F';
    end;
  end;

end;

function SetGender(Eng, Gender: String): String;
var
  i, j, iMax: Integer;
  Person, Male, Female: String;
begin

  Result := Eng;

  if Gender = '' then
    Exit;

  iMax := GetMaxPerson(Eng); j := 1;

  for i := 1 to iMax do
  begin
    Person := '%person#' + IntToStr(i);
    Male := '%male#' + IntToStr(i);
    Female := '%female#' + IntToStr(i);

    if Pos(Person, Eng) > 0 then
    begin
      if Gender[j] = 'M' then
        Result := StringReplace(Result, Person, Male, [rfIgnoreCase, rfReplaceAll])
      else
        if (Gender[j] = 'F') and (Pos(Person, Eng) > 0) then
          Result := StringReplace(Result, Person, Female, [rfIgnoreCase, rfReplaceAll]);

      Inc(j);
    end;
  end;

end;

function ReplaceGender(Eng, Trans, Gender: String): String;
var
  i, j, iMax: Integer;
  Male, Female: String;
begin

  Result := Trans;

  if Gender = '' then
    Exit;

  iMax := GetMaxPerson(Eng); j := 1;

  for i := 1 to iMax do   
  begin
    Male := '%male#' + IntToStr(i);
    Female := '%female#' + IntToStr(i);

    if Pos(Male, Trans) > 0 then
    begin
      if Gender[j] = 'F' then
        Result := StringReplace(Result, Male, Female, [rfIgnoreCase, rfReplaceAll]);

      Inc(j);
    end
    else
      if Pos(Female, Trans) > 0 then
      begin
        if  Gender[j] = 'M' then        
          Result := StringReplace(Result, Female, Male, [rfIgnoreCase, rfReplaceAll]);

        Inc(j);
      end;
  end;

end;

procedure LoadLTC(FileName: String;
	Add: Boolean = False; EngOnly: Boolean = False);
var
  EngStr, TransStr: String;
  F: TFileStream;
  Header: TFileHeader;
  TransBuf, EngBuf: Array[0..2*1024] of Byte;
  StrType, PrevType, bVariant, Checksum: Byte;
  StrLen, TransCount, Percent,
    RecordsIndex, StartPos, i, j, k: Integer;
  ID, CountID, BaseCount: DWORD;
  sGender: String;

  procedure AddRecord;
  begin
        LangRecords[RecordsIndex].Counter := BaseCount;
        LangRecords[RecordsIndex].Variant := bVariant;
        LangRecords[RecordsIndex].ID := ID;
        LangRecords[RecordsIndex].CountID := CountID;
        LangRecords[RecordsIndex].Checksum := Checksum;
        StrCopy(@LangRecords[RecordsIndex].Eng, PChar(SetGender(EngStr, sGender)));
        StrCopy(@LangRecords[RecordsIndex].Trans, PChar(TransStr));
        StrCopy(@LangRecords[RecordsIndex].Original, PChar(EngStr));
        StrCopy(@LangRecords[RecordsIndex].Gender, PChar(sGender));
        LangRecords[RecordsIndex].Changed := False;
        LangRecords[RecordsIndex].Added := False;
        LangRecords[RecordsIndex].Removed := False;
        LangRecords[RecordsIndex].NotTranslated :=
          IsStringsEqual(LangRecords[RecordsIndex].Eng, TransStr);
        if RecordsIndex > 0 then
        begin
          if (BaseCount > LangRecords[RecordsIndex - 1].Counter + 1) or
             ((EngStr = LangRecords[RecordsIndex - 1].Eng) and
              (TransStr = LangRecords[RecordsIndex - 1].Trans)) then
          begin
            LangRecords[RecordsIndex].Error := True;
            LangRecords[RecordsIndex - 1].Error := True;
          end else
            LangRecords[RecordsIndex].Error := False;
        end;

        Inc(RecordsIndex);
  end;
begin

  if not FileExists(FileName) then
    Exit;

  try
	  F := TFileStream.Create(FileName, fmOpenRead);
  except
  	MsgBox(Lng_CannotOpen, MB_ICONERROR);
		Exit;
  end;

  Screen.Cursor := crHourGlass;

  F.Position := 0;
  F.Read(Header, SizeOf(TFileHeader));

  if (Header.ID <> $0102) or (Header.Name <> 'ctl.') or
     ((Header.Version <> 3) and (Header.Version <> 4) and
      (Header.Version <> 5)) then
  begin
    MsgBox(Lng_UnknownFile);
    F.Free;
    Screen.Cursor := crDefault;
    Exit;
  end;

  FileVersion := Header.Version;

  F.Seek(4, soFromCurrent);

  F.Read(StrLen, 4);
  FillChar(TransBuf, SizeOf(TransBuf), #00);
  F.Read(TransBuf, StrLen * 2 + 2);
  frmMain.txtLangName.Text := WideCharToString(@TransBuf);

  frmMain.lblCaption.Caption := Lng_Calculating;
  Application.ProcessMessages;

  StartPos := F.Position;
  TransCount := 0; PrevType := $00;
  while F.Position < F.Size do
  begin
    F.Read(StrType, 1);

    case StrType of
      $64: // Английский
      begin
        F.Read(StrLen, 4);
        F.Seek(StrLen * 2 + 2, soFromCurrent);
        if FileVersion = 5 then
          F.Seek(4, soFromCurrent);

        if PrevType = $64 then
          Inc(TransCount)
        else
          PrevType := $64;
      end;
      $65: // Перевод
      begin
        F.Read(StrLen, 4);
        F.Seek(StrLen * 2 + 2, soFromCurrent);
        F.Seek(4, soFromCurrent);
        if (FileVersion = 4) or (FileVersion = 5) then
          F.Seek(1, soFromCurrent);

        PrevType := $65;

        Inc(TransCount);
      end;
      $66: // Падежи (уходим в конец)
        F.Seek(F.Size - F.Position, soFromCurrent);
      else
      begin
        MsgBox(Format(Lng_UnknownStrType, [StrType, F.Position - 1]));
        F.Free;
        Screen.Cursor := crDefault;
        Exit;
      end;
    end;
  end;

  if Add then
  begin
  	RecordsIndex := Length(LangRecords);

	  SetLength(LangRecords, RecordsIndex + TransCount);
  end else begin
		RecordsIndex := 0;

  	SetLength(LangRecords, 0);
	  SetLength(LangRecords, TransCount);
  end;

  F.Seek(StartPos, soFromBeginning);

  BaseCount := 0; bVariant := 0; PrevType := $00;
  GendersCount := 0; StringsCount := 0;
  while F.Position < F.Size do
  begin
    F.Read(StrType, 1);

    case StrType of
      $64: // Оригинал (английский)
      begin
        F.Read(StrLen, 4);
        FillChar(EngBuf, SizeOf(EngBuf), #00);
        F.Read(EngBuf, StrLen * 2 + 2);
        EngStr := StringReplace(WideCharToString(@EngBuf), #10, '\n',
       	  [rfReplaceAll]);

        if FileVersion = 5 then
          F.Read(ID, 4)
        else
          ID := 0;

        Inc(BaseCount);
        bVariant := 1;

        TransStr := EngStr;
        sGender := '';
        CountID := 0;
        Checksum := 0;

        AddRecord;

        PrevType := $64;
      end;

      $65: // Перевод
      begin
        if ID = 236971 then
          Beep;

        F.Read(StrLen, 4);
        FillChar(TransBuf, SizeOf(TransBuf), #00);
        F.Read(TransBuf, StrLen * 2 + 2);

  			if EngOnly then
					TransStr := EngStr
        else
          TransStr := StringReplace(WideCharToString(@TransBuf), #10, '\n',
         	  [rfReplaceAll]);

        F.Read(CountID, 4);
        if (FileVersion = 3) or (FileVersion = 4) then
          ID := CountID;
        if (FileVersion = 4) or (FileVersion = 5) then
        begin
          F.Read(Checksum, 1);
        end;

        sGender := TakeGender(EngStr, TransStr);

        if PrevType = $64 then
          Dec(RecordsIndex);

        AddRecord;

        Inc(bVariant);

        PrevType := $65;
      end;

      $66: // Падежи
      begin
        F.Read(GendersCount, 2);
        if GendersCount > 0 then
        begin
          SetLength(GendersArray, GendersCount);

          for i := 0 to GendersCount - 1 do
          begin
            F.Read(StrType, 1);
            F.Read(StringsCount, 2);

            for j := 0 to StringsCount - 1 do
              for k := 0 to 2 do
              begin
                F.Read(StrLen, 4);
                if StrLen > 0 then
                begin
                  FillChar(EngBuf, SizeOf(EngBuf), #00);
                  F.Read(EngBuf, StrLen * 2 + 2);
                  EngStr := WideCharToString(@EngBuf);
                end
                else
                  EngStr := '';

                GendersArray[i] :=
                  GendersArray[i] + EngStr + #10;
              end;
            end;
        end
        else
          SetLength(GendersArray, 0);
      end;

      else
      begin
        MsgBox(Format(Lng_UnknownStrType, [StrType, F.Position - 1]));
        F.Free;
        Screen.Cursor := crDefault;
        Exit;
      end;
    end;

    if F.Position mod 500 = 0 then
    begin
      Percent := F.Position * 100 div F.Size;
      frmMain.lblCaption.Caption := Format(Lng_Opening, [Percent]);
      frmMain.prgMain.Position := Percent;
    end;

    Application.ProcessMessages;
  end;

  F.Free;

  frmMain.dlgSave.FileName := FileName;

  RecentList.Add(FileName);
  AddRecentList;
  UpdateInfoOpen(FileName);

  CountMarks;

  Screen.Cursor := crDefault;



end;


procedure LoadLTF(FileName: String);
var
  sTmp: String;
  EngStr, TransStr, EngStrT: String;
  F: TCM4FileStream;
  Header, wBuf: WORD;
  BufArray: Array[0..2*1024] of Byte;
  TransArray: Array[0..2*1024] of Byte;
  bVariant, Checksum: Byte;
  StrLen, TransCount, Percent, RecordsIndex, iBufPos, ID, CountID,
    Gender: Integer;
  BaseCount: DWORD;
  bVersion: Byte;
  sGender: String;
begin

  if not FileExists(FileName) then
    Exit;

  try
	  F := TCM4FileStream.Create(FileName, fmOpenRead);
  except
  	MsgBox(Lng_CannotOpen, MB_ICONERROR);
		Exit;
  end;

  Screen.Cursor := crHourGlass;

  F.Position := 0;
  F.Read(Header, 2);
  if Header <> $FEFF then
  begin
    MsgBox(Lng_UnknownFile);
    F.Free;
    Screen.Cursor := crDefault;
    Exit;
  end;

  frmMain.lblCaption.Caption := Lng_Calculating;
  Application.ProcessMessages;

  TransCount := 0;
  while F.Position <= F.Size - 9 do
  begin
    F.Read(BufArray, 8);
    if WideCharToString(@BufArray) = #10'STR' then
      Inc(TransCount)
    else
      F.Seek(-6, soFromCurrent);

    if F.Position mod 500 = 0 then
    begin
      Percent := F.Position * 100 div F.Size;
      frmMain.lblCaption.Caption := Format(Lng_Calculating, [Percent]);
      frmMain.prgMain.Position := Percent;
      Application.ProcessMessages;
    end;
  end;

  SetLength(LangRecords, TransCount);

  F.Position := 2;

  sGender := ''; bVersion := 0; CountID := 1; ID := 0;
  RecordsIndex := 0; BaseCount := 0; bVariant := 0; iBufPos := 0;
  GendersCount := 0; StringsCount := 0;
  while F.Position <= F.Size - 2 do
  begin
    F.Read(wBuf, 2);
    BufArray[iBufPos] := LOBYTE(wBuf);
    BufArray[iBufPos + 1] := HIBYTE(wBuf);
    Inc(iBufPos, 2);

    if wBuf <> $000A then
      Continue;

    sTmp := WideCharToString(@BufArray);

    if Copy(sTmp, 1, 8) = 'GENDERS:' then
    begin
      TransStr := StringReplace(sTmp, #10, '', [rfReplaceAll]);
      TransStr := StringReplace(TransStr, #13, '', [rfReplaceAll]);

      GendersCount := StrToIntDef(Copy(TransStr, 10, Length(TransStr)), 0);
      SetLength(GendersArray, GendersCount);
    end;

    if Copy(sTmp, 1, 12) = 'BASESTRINGS:' then
    begin
      TransStr := StringReplace(sTmp, #10, '', [rfReplaceAll]);
      TransStr := StringReplace(TransStr, #13, '', [rfReplaceAll]);

//      StringsCount := StrToIntDef(Copy(TransStr, 14, Length(TransStr)), 0);
      StringsCount := 0;
    end;

    if Copy(sTmp, 1, 11) = 'GENDERINFO:' then
    begin
      TransStr := StringReplace(sTmp, #10, '', [rfReplaceAll]);
      TransStr := StringReplace(TransStr, #13, '', [rfReplaceAll]);

      Gender := StrToIntDef(Copy(TransStr, 13, Pos(',', TransStr) - 13), 0);
      sGender := Copy(TransStr, Pos('",', TransStr) + 3, Length(TransStr));
      sGender := StringReplace(sGender, '", "', #10, [rfReplaceAll]);
      sGender := StringReplace(sGender, '"', '', [rfReplaceAll]);

      GendersArray[Gender] := GendersArray[Gender] + sGender + #10;

      if Gender = 0 then
        Inc(StringsCount);
    end;

    if Copy(sTmp, 1, 9) = 'LANGNAME:' then
      frmMain.txtLangName.Text := StringReplace(StringReplace(Copy(sTmp, 11,
        Length(sTmp)), #10, '', [rfReplaceAll]), #13, '', [rfReplaceAll]);

    if Copy(sTmp, 1, 3) = 'KEY' then
    begin
      EngStrT := StringReplace(sTmp, #10, '', [rfReplaceAll]);
      EngStrT := StringReplace(EngStrT, #13, '', [rfReplaceAll]);
      StrLen := Length(EngStrT);

      sGender := '';
      if EngStrT[4] = '-' then
      begin
        EngStrT := Copy(EngStrT, Pos(':', EngStrT) + 2, StrLen);

        if (sTmp[Pos(':', sTmp) - 1] <> 'M') and
          (sTmp[Pos(':', sTmp) - 1] <> 'F') then
        begin
          ID := StrToIntDef(Copy(sTmp, 5, Pos(':', sTmp) - 5), 0);
          EngStr := EngStrT;
        end
        else
        begin
          sGender := Copy(sTmp, 5, Pos(':', sTmp) - 5);
          sGender := Copy(sGender, Pos('-', sGender) + 1, Length(sGender));
        end;

        bVersion := 5;
      end
      else
      begin
        EngStr := Copy(EngStrT, 6, StrLen);
        EngStrT := EngStr;
        bVersion := 3;
      end;

      if (sTmp[Pos(':', sTmp) - 1] <> 'M') and
        (sTmp[Pos(':', sTmp) - 1] <> 'F') then
      begin
        Inc(BaseCount);
        bVariant := 0;
      end;
    end;
{
    if Copy(sTmp, 1, 4) = '*STR' then
      Delete(sTmp, 1, 1);
}
    if Copy(sTmp, 1, 3) = 'STR' then
    begin
      TransStr := StringReplace(sTmp, #10, '', [rfReplaceAll]);
      TransStr := StringReplace(TransStr, #13, '', [rfReplaceAll]);
      StrLen := Length(TransStr);

      case bVersion of
        3:
          begin
            ID := StrToIntDef(Copy(TransStr, 5, Pos(':', TransStr) - 5), 0);
            CountID := 1;
          end;
        5:
          begin
            CountID := StrToIntDef(Copy(TransStr, 5, Pos(':', TransStr) - 5), 0);
          end;
      end;

      Inc(bVariant);

      TransStr := Copy(TransStr, Pos(':', TransStr) + 2, StrLen);
      if TransStr = '' then
      begin
        TransStr := EngStrT;
        CountID := 0;
      end
      else if CountID = 0 then
        CountID := bVariant;

      LangRecords[RecordsIndex].Counter := BaseCount;
      LangRecords[RecordsIndex].Variant := bVariant;
      LangRecords[RecordsIndex].ID := ID;
      LangRecords[RecordsIndex].CountID := CountID;
      LangRecords[RecordsIndex].Checksum := 0;
      FillChar(LangRecords[RecordsIndex].Eng,
      	SizeOf(LangRecords[RecordsIndex].Eng), #00);
      StrPCopy(LangRecords[RecordsIndex].Eng, EngStrT);
      FillChar(LangRecords[RecordsIndex].Trans,
      	SizeOf(LangRecords[RecordsIndex].Trans), #00);
      StrPCopy(LangRecords[RecordsIndex].Trans, TransStr);
      FillChar(LangRecords[RecordsIndex].Gender,
      	SizeOf(LangRecords[RecordsIndex].Gender), #00);
      FillChar(LangRecords[RecordsIndex].Original,
      	SizeOf(LangRecords[RecordsIndex].Original), #00);
      StrPCopy(LangRecords[RecordsIndex].Original, EngStr);
      StrPCopy(LangRecords[RecordsIndex].Gender, sGender);
      LangRecords[RecordsIndex].Changed := False;
      LangRecords[RecordsIndex].Added := False;
      LangRecords[RecordsIndex].Removed := False;
      LangRecords[RecordsIndex].NotTranslated :=
        IsStringsEqual(EngStrT, TransStr);
      if RecordsIndex > 0 then
      begin
        if (BaseCount > LangRecords[RecordsIndex - 1].Counter + 1) or
           (((BaseCount = LangRecords[RecordsIndex - 1].Counter) or
           (EngStr = LangRecords[RecordsIndex - 1].Eng)) and
           (TransStr = LangRecords[RecordsIndex - 1].Trans)) then
        begin
          LangRecords[RecordsIndex].Error := True;
          LangRecords[RecordsIndex - 1].Error := True;
        end else
          LangRecords[RecordsIndex].Error := False;
      end;

      Inc(RecordsIndex);
    end;

    FillChar(BufArray, SizeOf(BufArray), #00);
    iBufPos := 0;

    if F.Position mod 500 = 0 then
    begin
      Percent := F.Position * 100 div F.Size;
      frmMain.lblCaption.Caption := Format(Lng_Opening, [Percent]);
      frmMain.prgMain.Position := Percent;
      Application.ProcessMessages;
    end;
  end;

  F.Free;

  FileVersion := bVersion;

  frmMain.dlgSave.FileName := '';

  RecentList.Add(FileName);
  AddRecentList;
  UpdateInfoOpen(FileName);

  CountMarks;  

  Screen.Cursor := crDefault;

end;

procedure LoadLEW(FileName: String);
var
  F: TFileStream;
  cBuf: Array[0..2] of AnsiChar;
  sStr: String[255];
  bVer, bByte: Byte;
  dwSize, iInd: DWORD;
  i, j, k, StrLen: Integer;
  EngBuf: Array[0..2*1024] of Byte;
  EngStr: String;
begin

  try
	  F := TFileStream.Create(FileName, fmOpenRead);
  except
  	MsgBox(Lng_CannotOpen, MB_ICONERROR);
		Exit;
  end;

  Screen.Cursor := crHourGlass;

  F.Read(cBuf, 3); F.Read(bVer, 1);
  if (cBuf <> 'lew') or (bVer <> 3) then
  begin
    MsgBox(Lng_WrongWork);
    F.Free;
    Screen.Cursor := crDefault;
    Exit;
  end;

  F.Read(FileVersion, 1);

  F.Read(dwSize, 4);
  SetLength(LangRecords, dwSize);
  for i := 0 to dwSize - 1 do
    F.Read(LangRecords[i], SizeOf(TLangRecord));

  frmMain.lblCaption.Caption := Format(Lng_Opening, [F.Position * 100 div F.Size]);
  Application.ProcessMessages;

  F.Read(dwSize, 4);
  SetLength(OldTransArray, dwSize);
  for i := 0 to dwSize - 1 do
    F.Read(OldTransArray[i], SizeOf(TLangRecord));

  frmMain.lblCaption.Caption := Format(Lng_Opening, [F.Position * 100 div F.Size]);
  Application.ProcessMessages;

  F.Read(GendersCount, 2);
  if GendersCount > 0 then
  begin
    SetLength(GendersArray, GendersCount);

    for i := 0 to GendersCount - 1 do
    begin
      F.Read(bByte, 1);
      F.Read(StringsCount, 2);

      for j := 0 to StringsCount - 1 do
        for k := 0 to 2 do
        begin
          F.Read(StrLen, 4);
          if StrLen > 0 then
          begin
            FillChar(EngBuf, SizeOf(EngBuf), #00);
            F.Read(EngBuf, StrLen * 2 + 2);
            EngStr := WideCharToString(@EngBuf);
          end
          else
            EngStr := '';

          GendersArray[i] :=
            GendersArray[i] + EngStr + #10;
        end;
      end;
  end
  else
    SetLength(GendersArray, 0);

  frmMain.lblCaption.Caption := Format(Lng_Opening, [F.Position * 100 div F.Size]);
  Application.ProcessMessages;

  F.Read(iInd, 4);

  FillChar(sStr, 256, #00);
  F.Read(dwSize, 4);
  F.Read(sStr, dwSize);
  frmMain.txtLangName.Text := sStr;

  FillChar(sStr, 256, #00);
  F.Read(dwSize, 4);
  F.Read(sStr, dwSize);
  frmMain.dlgOpen.FileName := sStr;

  FillChar(sStr, 256, #00);
  F.Read(dwSize, 4);
  F.Read(sStr, dwSize);
  frmMain.dlgSave.FileName := sStr;

  F.Free;

  RecentList.Add(FileName);
  AddRecentList;
  UpdateInfoOpen(FileName);

  CountMarks;

  Screen.Cursor := crDefault;

  frmMain.lstFile.Items[iInd].Selected := True;
  frmMain.lstFile.Selected.MakeVisible(False);

end;

procedure TfrmMain.LoadRecent(Sender: TObject);
var
  sName, sExt: String;
begin

  sName := (Sender as TMenuItem).Caption;

  if not FileExists(sName) then
    MsgBox(Lng_CannotOpen, mb_IconError);

  sExt := ExtractFileExt(sName);

  dlgOpen.FileName := sName;

  if sExt = '.ltc' then
    LoadLTC(sName)
  else if sExt = '.ltf' then
    LoadLTF(sName)
  else if sExt = '.lew' then
    LoadLEW(sName);

end;

procedure TfrmMain.mnuMFOpenClick(Sender: TObject);
begin

  if not SaveIfChanged or
     not dlgOpen.Execute then
    Exit;

  LoadLTC(dlgOpen.FileName);

end;

procedure TfrmMain.lstFileData(Sender: TObject; Item: TListItem);
var
  LangRecord: TLangRecord;
begin

  LangRecord := LangRecords[Item.Index];
  Item.Caption := Format('%.5d', [LangRecord.Counter]);
  Item.SubItems.Add(LangRecord.Eng);
  Item.SubItems.Add(LangRecord.Trans);

end;

procedure TfrmMain.FormResize(Sender: TObject);
begin

  lstFile.Columns[1].Width := (lstFile.Width - 70) div 2;
  lstFile.Columns[2].Width := lstFile.Columns[1].Width;

end;

procedure CompareTranslation;
var
  LstItemIndex, TransArrayIndex,
    i, j: Integer;
begin

  if (frmMain.lstFile.Selected = nil) or
     (frmMain.memTrans.Text = Lng_MultiSelected) then
    Exit;

  LstItemIndex := frmMain.lstFile.Selected.Index;
  TransArrayIndex := High(OldTransArray) + 1;

  if LangRecords[LstItemIndex].Changed then
  begin
    for i := 0 to High(OldTransArray) do
      if OldTransArray[i].Counter = LangRecords[LstItemIndex].Counter then
      begin
        if OldTransArray[i].Trans = frmMain.memTrans.Text then
        begin
          for j := i to High(OldTransArray) - 1 do
            OldTransArray[j] := OldTransArray[j + 1];

          SetLength(OldTransArray, High(OldTransArray));

          LangRecords[LstItemIndex].Changed := False;
        end;

        StrCopy(@LangRecords[LstItemIndex].Trans, PChar(frmMain.memTrans.Text));
      end;
  end else if frmMain.memTrans.Text <> LangRecords[LstItemIndex].Trans then
  begin
    SetLength(OldTransArray, TransArrayIndex + 1);
    OldTransArray[TransArrayIndex] := LangRecords[LstItemIndex];

    StrCopy(@LangRecords[LstItemIndex].Trans, PChar(frmMain.memTrans.Text));

    LangRecords[LstItemIndex].Changed := True;
  end else
    LangRecords[LstItemIndex].Changed := False;

  LangRecords[LstItemIndex].NotTranslated :=
    IsStringsEqual(LangRecords[LstItemIndex].Eng,
    LangRecords[LstItemIndex].Trans);

  if not LangRecords[LstItemIndex].NotTranslated and
    (LangRecords[LstItemIndex].CountID = 0) then
  begin
    if (LstItemIndex > 0) and
       (LangRecords[LstItemIndex].Counter = LangRecords[LstItemIndex - 1].Counter) then
      LangRecords[LstItemIndex].CountID :=
        LangRecords[LstItemIndex - 1].CountID + 1
    else
      LangRecords[LstItemIndex].CountID := 1;
  end;

  CountMarks;

end;

const
   CFU_UNDERLINETHICK = 9;
   CFU_UNDERLINEWAVE = 8;
   CFU_UNDERLINEDASHDOTDOT = 7;
   CFU_UNDERLINEDASHDOT = 6;
   CFU_UNDERLINEDASH = 5;
   CFU_UNDERLINEDOTTED = 4;
   CFU_UNDERLINE = 1;
   CFU_UNDERLINENONE = 0;

procedure RE_SetCharFormat(ARichEdit: TRichEdit; AUnderlineType: Byte; AColor: Word);
var
	// The CHARFORMAT2 structure contains information about
	// character formatting in a rich edit control.
	Format: CHARFORMAT2;
begin

  FillChar(Format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize := SizeOf(Format);
//    dwEffects := CFE_UNDERLINE;
    dwMask := CFM_UNDERLINETYPE;
    bUnderlineType := AUnderlineType or AColor;
    ARichEdit.Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@Format));
  end;

end;

procedure RE_SetSelBgColor(ARichEdit: TRichEdit; AColor: TColor);
var
  Format: CHARFORMAT2;
begin
  FillChar(Format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize := SizeOf(Format);
    dwMask := CFM_BACKCOLOR;
    crBackColor := AColor;
    ARichEdit.Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@Format));
  end;
end;

function SpellCheckWord(Word: String; EngLang: Boolean): Boolean;
//var
//	ProofErrors: ProofreadingErrors;
begin

  Result := True;

{
	frmMain.WordDoc.Range.Set_Text(Word);
  if EngLang then
		frmMain.WordDoc.Range.LanguageID := $00000809
  else
		frmMain.WordDoc.Range.LanguageID := $00000419;

	ProofErrors := frmMain.WordDoc.Range.SpellingErrors;

  Result := ProofErrors.Count > 0;
}
end;

function GetWord(Text: String; Pos: Integer;
	var WordStart: Integer; var WordLength: Integer): String;
var
  i, j: Integer;
  cSymbol: Char;
begin

	i := Pos;
  j := i;

	cSymbol := Char(Text[i]);
  while not (cSymbol in Punct) and
			  	  (i > 1) do
	begin
   	Dec(i);
	 	cSymbol := Char(Text[i]);
  end;

	cSymbol := Char(Text[j]);
  while not (cSymbol in Punct) and
	    			(j < Length(Text)) do
	begin
   	Inc(j);
   	cSymbol := Char(Text[j]);
	end;

  if i > 1 then
	  Inc(i);
  if j < Length(Text) then
  	Dec(j);
  WordStart := i;
  WordLength := j - i + 1;
  Result := Copy(Text, WordStart, WordLength);

end;

procedure SpellingCheck(RE: TRichEdit; Full: Boolean; EngLang: Boolean);
//var
//  CurPos, WordStart, WordLength: Integer;
//  sText, sWord: String;
//  ProofErrors: ProofreadingErrors;
//  i: Integer;
begin
{
	if (not WordExists) or
     (not frmMain.mnuMSCheck.Checked) then
  	Exit;

  CurPos := RE.SelStart;

  sText := RE.Text;

  if Length(sText) = 0 then
  	Exit;

  if Full then
  begin
  	frmMain.WordDoc.Range.Set_Text(RE.Text);
    if EngLang then
			frmMain.WordDoc.Range.LanguageID := $00000809
    else
			frmMain.WordDoc.Range.LanguageID := $00000419;
		ProofErrors := frmMain.WordDoc.Range.SpellingErrors;

    RE.SelectAll;

    for i := 1 to ProofErrors.Count do
    begin
    	sText := RE.Text; sWord := ProofErrors.Item(i).Get_Text;
    	WordStart := 1; WordLength := Length(sWord);
      while WordStart + WordLength <= Length(sText) do
	      if Copy(sText, WordStart, WordLength) = sWord then
  	    begin
  	      RE.SelStart := WordStart - 1;
					RE.SelLength := WordLength;
					RE_SetCharFormat(RE, CFU_UNDERLINEWAVE, $50);
          RE.SelAttributes.Style := RE.SelAttributes.Style + [fsUnderline];

        	WordStart := WordStart + WordLength;
    	  end else
        	Inc(WordStart);
    end;
  end else begin
	  sWord := GetWord(sText, RE.SelStart, WordStart, WordLength);
		RE.SelStart := WordStart - 1;
		RE.SelLength := WordLength;
	  if SpellCheckWord(sWord, EngLang) then
    begin
			RE_SetCharFormat(RE, CFU_UNDERLINEWAVE, $50);
      RE.SelAttributes.Style := RE.SelAttributes.Style + [fsUnderline];
		end else
  		RE.SelAttributes.Style := RE.SelAttributes.Style - [fsUnderline];
  end;

	RE.SelStart := CurPos;
	RE.SelLength := 0;
}
end;

procedure TfrmMain.memTransKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
	iInd: Integer;
begin

  if Key = VK_RETURN then
  begin
    CompareTranslation;

    iInd := lstFile.ItemIndex;

    if iInd < lstFile.Items.Count - 1 then
    begin
	    lstFile.Items[iInd].Selected := False;
  	  lstFile.ItemIndex := iInd + 1;
    	lstFile.Items[iInd + 1].Focused := True;
	    lstFile.Items[iInd + 1].Selected := True;
    end;

    lstFile.Selected.MakeVisible(False);

    memTrans.SetFocus;
  end;

end;

procedure SaveFile(FileName: String;
  Version: Integer; Filter: Boolean; Express: Boolean = False);
var
  BufStr: String;
  F: TFileStream;
  Header: TFileHeader;
  BufArray: Array[0..2*1024] of Byte;
  StrType: Byte;
  StrLen, Percent, i, j, k: Integer;
  bFlag: Boolean;
	MinNum, MaxNum: Cardinal;
  Checksum: Integer;
  Genders: TStrings;
begin

  if FileExists(FileName) then
    DeleteFile(FileName);
    
  F := TFileStream.Create(FileName, fmCreate);
  F.Position := 0;

  Screen.Cursor := crHourGlass;

  Header.ID := $0102;
  Header.Name := 'ctl.';
  Header.Version := Version;
  Header.UnknownByte := 0;
  F.Write(Header, SizeOf(TFileHeader));

  StrLen := 0;
  F.Write(StrLen, 4);

  BufStr := frmMain.txtLangName.Text;
  StrLen := Length(BufStr);
  StringToWideChar(BufStr, @BufArray, StrLen + 1);
  F.Write(StrLen, 4);
  F.Write(BufArray, StrLen * 2 + 2);

  i := 0;
  while i <= High(LangRecords) do
  begin
    if Filter then
    begin
	    MinNum := StrToInt(frmSaveOnly.txtMin.Text);
      MaxNum := StrToInt(frmSaveOnly.txtMax.Text);

      if frmSaveOnly.rbtMarks.Checked then
      begin
        with frmSaveOnly do
        begin
          bFlag := False;
          if chkChanged.Checked then
            bFlag := bFlag or LangRecords[i].Changed;
          if chkAdded.Checked then
            bFlag := bFlag or LangRecords[i].Added;
          if chkRemoved.Checked then
            bFlag := bFlag or LangRecords[i].Removed;
          if chkNotTrans.Checked then
            bFlag := bFlag or LangRecords[i].NotTranslated;
        end;

        if not bFlag then
        begin
          Inc(i);
          Continue;
        end;
      end else begin
        if (LangRecords[i].Counter < MinNum) or
           (LangRecords[i].Counter > MaxNum) then
        begin
          Inc(i);
          Continue;
        end;
      end;
    end else if Express then
    begin
      if not frmMain.lstFile.Items[i].Selected then
      begin
        Inc(i);
        Continue;
      end;
    end else if LangRecords[i].Removed then
    begin
      Inc(i);
      Continue;
    end;

    StrType := $64;
    F.Write(StrType, 1);

    BufStr := StringReplace(LangRecords[i].Original, '\n', #10, [rfReplaceAll]);
    StrLen := Length(BufStr);
    StringToWideChar(BufStr, @BufArray, StrLen + 1);
    F.Write(StrLen, 4);
    F.Write(BufArray, StrLen * 2 + 2);

    if Version = 5 then
      F.Write(LangRecords[i].ID, 4);

    j := 0;
    while LangRecords[i].Counter = LangRecords[i + j].Counter do
    begin
      if (Version <> 5) or
        ((Version = 5) and
         ((LangRecords[i].Original <> LangRecords[i + j].Trans) or
          (LangRecords[i + j].CountID > 0))) then
      begin
        StrType := $65;
        F.Write(StrType, 1);

        BufStr := StringReplace(LangRecords[i + j].Trans, '\n', #10,
          [rfReplaceAll]);
        StrLen := Length(BufStr);
        StringToWideChar(BufStr, @BufArray, StrLen + 1);
        F.Write(StrLen, 4);
        if StrLen > 0 then
          F.Write(BufArray, StrLen * 2 + 2);

        if Version = 5 then
          F.Write(LangRecords[i + j].CountID, 4)
        else
          F.Write(LangRecords[i + j].ID, 4);

//        LangRecords[i + j].Checksum := ((BufArray[1] * 256 + BufArray[0]) *
//          StrLen mod 256) xor $FF;
        LangRecords[i + j].Checksum := ((BufArray[1] * 256 + BufArray[0]) *
          StrLen mod 256) xor $FA;
        if (Version = 4) or (Version = 5) then
          F.Write(LangRecords[i + j].Checksum, 1);
      end;

      if not Filter then
      begin
        LangRecords[i + j].Changed := False;
        LangRecords[i + j].Added := False;
      end;

      Inc(j);
    end;
    Inc(i, j);

    if i mod 500 = 0 then
    begin
      Percent := i * 100 div High(LangRecords);
      frmMain.lblCaption.Caption := Format(Lng_Saving, [Percent]);
      frmMain.prgMain.Position := Percent;
      Application.ProcessMessages;
    end;
  end;

  StrType := $66;
  F.Write(StrType, 1);

  F.Write(GendersCount, 2);
  if GendersCount > 0 then
    for i := 0 to GendersCount - 1 do
    begin
      StrType := $01;
      F.Write(StrType, 1);
      F.Write(StringsCount, 2);

      Genders := TStringList.Create;
      Genders.Text := GendersArray[i];

      for j := 0 to StringsCount - 1 do
        for k := 0 to 2 do
        begin
          StrLen := Length(Genders[j * 3 + k]);
          F.Write(StrLen, 4);
          if StrLen > 0 then
          begin
            StringToWideChar(Genders[j * 3 + k], @BufArray, StrLen + 1);
            F.Write(BufArray, StrLen * 2 + 2);
          end;
        end;

      Genders.Free;
    end;

  StrLen := F.Size;
  F.Seek(SizeOf(TFileHeader), soFromBeginning);
  F.Write(StrLen, 4);

  F.Free;

  with frmMain do
  begin
    prgMain.Position := 0;
    lblCaption.Caption := Lng_Saved;

    if not Filter then
      Caption := 'LTC Editor - ' + ExtractFileName(frmMain.dlgSave.FileName);

    lstFile.Refresh;
  end;

  CountMarks;

  RecentList.Add(FileName);
  AddRecentList;

  Screen.Cursor := crDefault;

end;

procedure TfrmMain.mnuMFSaveClick(Sender: TObject);
begin

  SaveFile(dlgSave.FileName, FileVersion, False);

end;

procedure TfrmMain.mnuMFSaveAsClick(Sender: TObject);
begin

  if dlgSave.Execute then
    SaveFile(dlgSave.FileName, FileVersion, False);

end;

procedure TfrmMain.mnuMFExitClick(Sender: TObject);
begin

  Close;

end;

procedure TfrmMain.lstFileClick(Sender: TObject);
begin

  if lstFile.SelCount > 1 then
  begin
    memEng.Text := Lng_MultiSelected;
    memTrans.Text := Lng_MultiSelected;
  end;

end;

procedure TfrmMain.lstFileCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  FontColor, BgColor: TColor;
begin

  FontColor := clWindowText;
  BgColor := clWindow;

  if LangRecords[Item.Index].Changed then
  begin
    FontColor := ChFontColor;
    BgColor := ChBgColor;
    lstFile.Canvas.Font.Style := [fsBold, fsItalic];
  end;
  if LangRecords[Item.Index].Removed then
  begin
    FontColor := RemFontColor;
    BgColor := RemBgColor;
  end else if LangRecords[Item.Index].Added then
  begin
    FontColor := AddFontColor;
    BgColor := AddBgColor;
  end else if LangRecords[Item.Index].NotTranslated then
  begin
    FontColor := EngFontColor;
    BgColor := EngBgColor;
  end else if LangRecords[Item.Index].Error then
  begin
    FontColor := ErrFontColor;
    BgColor := ErrBgColor;
  end;

  lstFile.Canvas.Font.Color := FontColor;
	lstFile.Canvas.Brush.Color := BgColor;

end;

procedure TfrmMain.btnSearchReplaceClick(Sender: TObject);
begin

  frmSearch.Show;

end;

procedure TfrmMain.btnGendersClick(Sender: TObject);
begin

  frmGenders.ShowModal;

end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
	Save: OleVariant;
  i: Integer;
begin

  CanClose := SaveIfChanged;

  if CanClose then begin
  	if WordExists then
    begin
	  	Save := False;

      try
      {
  		  WordDoc.Close(Save);
	  		WordApp.Quit(Save);
        WordDoc.Disconnect;
        WordApp.Disconnect;
      }
      finally
      end;
    end;

    for i := popMemo.Items.Count - 1 downto 0 do
    	popMemo.Items[i].Free;
    popMemo.Items.Clear;

  	SaveSettings;

	  RecentList.Free;
  end;

end;

procedure TfrmMain.txtIndexKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Ind, i: Integer;
begin

  if not TryStrToInt(txtIndex.Text, Ind) or
    (lstFile.Items.Count = 0) then
    Exit;

  for i := 0 to High(LangRecords) do
  begin
    if LangRecords[i].Counter = Cardinal(Ind) then
    begin
      lstFile.Items[i].Selected := True;
      lstFile.Items[i].Focused := True;
      lstFile.Items[i].MakeVisible(False);

      break;
    end;
  end;

end;

procedure ColorizeMemo(Item: TListItem);
var
  BgColor: TColor;
begin

  if Item = nil then
    Exit;

  BgColor := clWindow;
  if fsItalic in frmMain.memTrans.Font.Style then
	  frmMain.memTrans.Font.Style := frmMain.memTrans.Font.Style - [fsItalic];

  if LangRecords[Item.Index].Changed then
  begin
    BgColor := ChBgColor;
    frmMain.memTrans.Font.Style := [fsBold, fsItalic];
  end;
  if LangRecords[Item.Index].Error then
  begin
    BgColor := ErrBgColor;
  end;
  if LangRecords[Item.Index].NotTranslated then
  begin
    BgColor := EngBgColor;
  end;
  if LangRecords[Item.Index].Added then
  begin
    BgColor := AddBgColor;
  end;
  if LangRecords[Item.Index].Removed then
  begin
    BgColor := RemBgColor;
  end;

  frmMain.memEng.Color := BgColor;
  frmMain.memTrans.Color := BgColor;

end;

procedure TfrmMain.lstFileSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin

	if lstFile.SelCount = 1 then
  begin
	  ColorizeMemo(Item);

	  if Item <> nil then
  	begin
    	memEng.Text := Item.SubItems[0];
	    memTrans.Text := Item.SubItems[1];
  	end else begin
    	memEng.Text := '';
	    memTrans.Text := '';
  	end;

    memTrans.SelectAll;
    memTrans.SelAttributes.Style := memTrans.SelAttributes.Style -
    	[fsUnderline];
    memTrans.SelLength := 0;

  	SpellingCheck(memTrans, True, LangRecords[Item.Index].NotTranslated);

    HTMLSyntax(memEng);
    HTMLSyntax(memTrans);
  end else begin
  	memEng.Color := clWindow;
    memTrans.Color := clWindow;
  end;

	memEng.Enabled := lstFile.SelCount = 1;
  memTrans.Enabled := lstFile.SelCount = 1;

end;

procedure TfrmMain.txtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i, Ind: Integer;
  Fnd, Str1, Str2: String;
  Found: Boolean;
begin

  if lstFile.Items.Count = 0 then
    Exit;

  if lstFile.SelCount > 1 then
  begin
    memEng.Text := Lng_MultiSelected;
    memTrans.Text := Lng_MultiSelected;
  end;

  if (Sender.ClassNameIs('TListView')) and
     (Key <> VK_F3) and
     (Key <> VK_RETURN) then
    Exit;

  if (Key < Ord(' ')) and
     (Key <> VK_F3) and
     (Key <> VK_RETURN) then
  	Exit;

  if not chkAutoSearch.Checked and
    (Key <> VK_F3) and
    (Key <> VK_RETURN) then
    Exit;

  Ind := 0;
  if lstFile.Selected <> nil then
    Ind := lstFile.Selected.Index;
  if Key = VK_F3 then
    Ind := lstFile.Selected.Index + 1;
  if Key = VK_RETURN then
    Ind := 0;

  Found := False;
  for i := Ind to High(LangRecords) do
  begin
    if chkCaseSens.Checked then
    begin
      Fnd := txtSearch.Text;
      Str1 := LangRecords[i].Eng;
      Str2 := LangRecords[i].Trans;
    end else begin
      Fnd := UpperCase(txtSearch.Text);
      Str1 := UpperCase(LangRecords[i].Eng);
      Str2 := UpperCase(LangRecords[i].Trans);
    end;

    if (Pos(Fnd, Str1) > 0) or
       (Pos(Fnd, Str2) > 0) then
    begin
    	lstFile.Items[lstFile.Selected.Index].Selected := False;

      lstFile.Items[i].Selected := True;
      lstFile.Items[i].Focused := True;
      lstFile.Items[i].MakeVisible(False);

      Found := True;
      Break;
    end;
  end;

  if not Found then
    Beep;

end;

procedure TfrmMain.mnuMHAboutClick(Sender: TObject);
begin

  frmAbout.ShowModal;

end;

procedure TfrmMain.mnuMFLoadChangesClick(Sender: TObject);
var
  EngStr, TransStr: String;
  F: TFileStream;
  Header: TFileHeader;
  BufArray: Array[0..4*1024] of Byte;
  StrType, Checksum: Byte;
  StrLen, Percent, i, iStart,
    TransTotal, ChangedCount, SkippedCount: Integer;
  ID, CountID: DWORD;
  Slow, Found: Boolean;
  SS: TStringStream;
begin

  if not dlgOpen.Execute then
    Exit;

  try
	  F := TFileStream.Create(dlgOpen.FileName, fmOpenRead);
  except
  	MsgBox(Lng_CannotOpen, MB_ICONERROR);
		Exit;
  end;

  Slow := Pos('Slow', (Sender as TMenuItem).Name) > 0;

  Screen.Cursor := crHourGlass;

  F.Position := 0;
  F.Read(Header, SizeOf(TFileHeader));

  if (Header.ID <> $0102) or (Header.Name <> 'ctl.') or
     ((Header.Version <> 3) and (Header.Version <> 4) and
      (Header.Version <> 5)) then
  begin
    MsgBox(Lng_WrongUpdate);
    F.Free;
    Screen.Cursor := crDefault;
    Exit;
  end;

  F.Seek(4, soFromCurrent);

  F.Read(StrLen, 4);
  FillChar(BufArray, SizeOf(BufArray), #00);
  F.Read(BufArray, StrLen * 2 + 2);
  if not SameText(WideCharToString(@BufArray), frmMain.txtLangName.Text) then
    if MsgBox(Lng_DifferentLangs, mb_IconQuestion, mb_YesNo) = idNo then
    begin
      F.Free;
      Screen.Cursor := crDefault;
      Exit;
    end;

  SS := TStringStream.Create;

  TransTotal := 0; ChangedCount := 0; SkippedCount := 0;
  iStart := 0;
  while F.Position < F.Size do
  begin
    F.Read(StrType, 1);

    case StrType of
      $64: // Оригинал (английский)
      begin
        F.Read(StrLen, 4);
        FillChar(BufArray, SizeOf(BufArray), #00);
        F.Read(BufArray, StrLen * 2 + 2);
        EngStr := StringReplace(WideCharToString(@BufArray),
          #10, '\n', [rfReplaceAll]);

        if Header.Version = 5 then
          F.Read(ID, 4)
        else
          ID := 0;
      end;

      $65: // Перевод
      begin
        F.Read(StrLen, 4);
        FillChar(BufArray, SizeOf(BufArray), #00);
        F.Read(BufArray, StrLen * 2 + 2);
        TransStr := StringReplace(WideCharToString(@BufArray),
          #10, '\n', [rfReplaceAll]);

        F.Read(CountID, 4);
        if (Header.Version = 3) or (Header.Version = 4) then
          ID := CountID;
        if (Header.Version = 4) or (Header.Version = 5) then
          F.Read(Checksum, 1);

        Inc(TransTotal);

	      Found := False;
        for i := iStart to High(LangRecords) do
          if IsStringsEqual(EngStr, LangRecords[i].Original) then
          begin
            Found := True;

            if not IsStringsEqual(LangRecords[i].Trans, TransStr, True) then
            begin
              SS.WriteString(Format(Lng_StrFound, [EngStr, LangRecords[i].Trans,
                TransStr]));

              SetLength(OldTransArray, Length(OldTransArray) + 1);
              OldTransArray[High(OldTransArray)] := LangRecords[i];

              StrCopy(@LangRecords[i].Trans, PChar(SetGender(TransStr,
                LangRecords[i].Gender)));
              LangRecords[i].Changed := True;
              if not IsStringsEqual(TransStr, EngStr) then
                LangRecords[i].NotTranslated := False;

              Inc(ChangedCount);
            end
            else
            begin
              SS.WriteString(Format(Lng_StrNotApplied, [EngStr,
                LangRecords[i].Trans, TransStr]));

              Inc(SkippedCount);
            end;

            if not Slow then
	            iStart := i + 1;

            Break;
          end;

        if not Found then
	        SS.WriteString(Format(Lng_StrNotFound, [EngStr, TransStr]));
      end;

      $66: // Падежи (уходим в конец)
      begin
        F.Seek(0, soFromEnd);
      end;

      else
      begin
        MsgBox(Format(Lng_UnknownStrType, [StrType, F.Position - 1]));
        F.Free;
        Screen.Cursor := crDefault;
        Exit;
      end;
    end;

    if F.Position mod 500 = 0 then
    begin
      Percent := F.Position * 100 div F.Size;
      frmMain.lblCaption.Caption := Format(Lng_Opening, [Percent]);
      frmMain.prgMain.Position := Percent;
    end;

    Application.ProcessMessages;
  end;

  SS.WriteString(Format(Lng_ChangesReport, [TransTotal, ChangedCount +
    SkippedCount, ChangedCount, SkippedCount]));
  SS.SaveToFile(ExtractFilePath(Application.ExeName) + 'log.htm');
  SS.Free;
  F.Free;

  with frmMain do
  begin
    prgMain.Position := 0;
    lblCaption.Caption := Format(Lng_Changes, [ChangedCount, SkippedCount]);

    lstFile.Refresh;
  end;

  RecentList.Add(dlgOpen.FileName);
  AddRecentList;

  CountMarks;

  Screen.Cursor := crDefault;

end;

function IDE: Boolean;
  function WindowExists(ClassName, WindowName: String): Boolean;
  { Проверяем наличие определенного окна Window, используя
  для этого паскалевские строки вместо PChars. }
  var
    PClassName, PWindowName: PChar;
    AClassName, AWindowName: array[0..63] of char;
  begin
    if ClassName = '' then
      PClassName := nil
    else
      PClassName := StrPCopy(@AClassName[0], ClassName);
    if WindowName = '' then
      PWindowName := nil
    else
      PWindowName := StrPCopy(@AWindowName[0], WindowName);
    if FindWindow(PClassName, PWindowName) <> 0 then
      WindowExists := true
    else
      WindowExists := false;
  end; {WindowExists}
begin {DelphiLoaded}
  Result := False;
  if WindowExists('TPropertyInspector', 'Object Inspector') or
     WindowExists('TMenuBuilder', 'Menu Designer') or
     WindowExists('TApplication', 'Delphi') or
     WindowExists('TAlignPalette', 'Align') or
     WindowExists('TAppBuilder', '') then
     Result := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  SR: TSearchRec;
  ifLang: TIniFile;
  sName, sVer, sAuthor: String;
  miLang: TMenuItem;
//  reg: TRegistry;
//  Index: OleVariant;
begin
{
  reg := TRegistry.Create;
  try
	  reg.RootKey := HKEY_CLASSES_ROOT;
    WordExists := reg.KeyExists('Word.Application');
  finally
     reg.Free;
  end;

  mnuMSCheck.Enabled := WordExists;

  if WordExists then
  begin
  	WordApp.Connect;
    Index := False;
    WordApp.Visible := Index;
    WordDoc.Connect;
  end;
}
	// Раскрашиваем надписи поиска маркированных строк
  lblPrevChange.Font.Color := ChFontColor;
  lblNextChange.Font.Color := ChFontColor;

  lblPrevAdd.Font.Color := AddFontColor;
  lblNextAdd.Font.Color := AddFontColor;

  lblPrevRem.Font.Color := RemFontColor;
  lblNextRem.Font.Color := RemFontColor;

  lblPrevEng.Font.Color := EngFontColor;
  lblNextEng.Font.Color := EngFontColor;

  lblPrevErr.Font.Color := ErrFontColor;
  lblNextErr.Font.Color := ErrFontColor;

  // Ищем в каталоге программы и добавляем найденные языки в меню
  if FindFirst(ExtractFilePath(Application.ExeName) + '*.lng', faAnyFile, SR) = 0 then
  begin
    repeat
      if SR.Attr <> faDirectory then
      begin
        ifLang := TIniFile.Create(ExtractFilePath(Application.ExeName) + SR.Name);
        sName := ifLang.ReadString('Info', 'LangName', '');
        sVer := ifLang.ReadString('Info', 'LangVer', '');
        sAuthor := ifLang.ReadString('Info', 'Author', '');

        if sName <> '' then
        begin
          miLang := TMenuItem.Create(mnuMLang);
          miLang.GroupIndex := 1;
          miLang.RadioItem := True;
          miLang.Caption := SR.Name + ' - ' + sName;
          if sVer <> '' then
            miLang.Caption := miLang.Caption + ' v.' + sVer;
          if sAuthor <> '' then
            miLang.Caption := miLang.Caption + ' (' + sAuthor + ')';

          miLang.OnClick := LoadLang;
          mnuMLang.Add(miLang);
        end;

        ifLang.Free;
      end;
    until FindNext(SR) <> 0;

    FindClose(SR);
  end;

  RecentList := TStringList.Create;

end;

procedure TfrmMain.SearchColor(Sender: TObject);
var
  Ind, i: Integer;
  BlockEnd: Boolean;

  function GetFlag(Item: Integer; Sender: TObject): Boolean;
  var
    Name: String;
  begin
    Name := TComponent(Sender).Name;
    Result := False;

    if Pos('Change', Name) > 0 then
      Result := LangRecords[Item].Changed;
    if Pos('Add', Name) > 0 then
      Result := LangRecords[Item].Added;
    if Pos('Rem', Name) > 0 then
      Result := LangRecords[Item].Removed;
    if Pos('Err', Name) > 0 then
      Result := LangRecords[Item].Error;
    if Pos('Eng', Name) > 0 then
      Result := LangRecords[Item].NotTranslated;
  end;
begin

  Ind := 0;
  if lstFile.Selected <> nil then
    Ind := lstFile.Selected.Index;

  Screen.Cursor := crHourGlass;

  lstFile.Selected := nil;

  BlockEnd := False;

  if Pos('Prev', TComponent(Sender).Name) > 0 then
    for i := Ind - 1 downto 0 do
    begin
      if not GetFlag(i, Sender) then
        BlockEnd := True;
      if BlockEnd and GetFlag(i, Sender) then
      begin
        lstFile.Items[i].Selected := True;
        lstFile.Items[i].Focused := True;
        lstFile.Items[i].MakeVisible(False);

        Break;
      end;
    end;
  if Pos('Next', TComponent(Sender).Name) > 0 then
    for i := Ind + 1 to High(LangRecords) do
    begin
      if not GetFlag(i, Sender) then
        BlockEnd := True;
      if BlockEnd and GetFlag(i, Sender) then
      begin
        lstFile.Items[i].Selected := True;
        lstFile.Items[i].Focused := True;
        lstFile.Items[i].MakeVisible(False);

        Break;
      end;
    end;

  Screen.Cursor := crDefault;

end;

procedure TfrmMain.Splitter1Moved(Sender: TObject);
begin

  memEng.Height := (pnlTrans.Height - 10) div 2;
  memTrans.Top := memEng.Top + memEng.Height + 2;
  memTrans.Height := memEng.Height;

end;

procedure TfrmMain.mnuMFEVer3Click(Sender: TObject);
begin

  if dlgSave.Execute then
    SaveFile(dlgSave.FileName, 3, False);

end;

procedure TfrmMain.popRemoveClick(Sender: TObject);
var
  i: Integer;
begin

  if lstFile.Selected <> nil then
  begin
    for i := lstFile.Selected.Index to (lstFile.Selected.Index +
      lstFile.SelCount) do
      if lstFile.Items[i].Selected then
        LangRecords[i].Removed := True;

    ColorizeMemo(lstFile.Selected);

    CountMarks;

    lstFile.Refresh;
  end;

end;

procedure TfrmMain.popRestoreClick(Sender: TObject);
var
  i, j: Integer;
begin

  if lstFile.Selected = nil then
    Exit;

  for j := lstFile.Selected.Index to (lstFile.Selected.Index +
    lstFile.SelCount) do
    if lstFile.Items[j].Selected then
    begin
      LangRecords[j].Removed := False;

      if LangRecords[j].Changed then
        for i := 0 to High(OldTransArray) do
          if (OldTransArray[i].Counter = LangRecords[j].Counter) and
             (OldTransArray[i].Variant = LangRecords[j].Variant) then
          begin
            LangRecords[j].Trans := OldTransArray[i].Trans;
            LangRecords[j].Changed := False;

            Break;
          end;
    end;

  ColorizeMemo(lstFile.Selected);

  CountMarks;

  lstFile.Refresh;

end;

procedure TfrmMain.popListPopup(Sender: TObject);
var
  bFlag: Boolean;
begin

  bFlag := lstFile.Selected <> nil;

  popRemove.Enabled := bFlag;
  popRestore.Enabled := bFlag;
  popInsert.Enabled := bFlag;
  popSave.Enabled := bFlag;

end;

procedure TfrmMain.popInsertClick(Sender: TObject);
var
  i, Sel: Integer;
begin

  if lstFile.SelCount > 1 then
  begin
    Application.MessageBox(PChar(Lng_SelectOne), 'LTC Editor');
    Exit;
  end;

  SetLength(LangRecords, Length(LangRecords) + 1);

  Sel := 0;
  if lstFile.Selected <> nil then
    Sel := lstFile.Selected.Index;

  for i := High(LangRecords) - 1 downto Sel do
    LangRecords[i + 1] := LangRecords[i];

  LangRecords[Sel + 1].Added := True;

  CountMarks;

  lstFile.Items.Count := Length(LangRecords);
  lstFile.Refresh;

end;

procedure TfrmMain.mnuMFSaveOnlyClick(Sender: TObject);
var
  OldFile: String;
begin

  OldFile := dlgSave.FileName;

  if frmSaveOnly.ShowModal = mrOk then
    SaveFile(dlgSave.FileName, FileVersion, True);

  dlgSave.FileName := OldFile;

end;

procedure TfrmMain.mnuMLSaveClick(Sender: TObject);
begin

  Desigin := True;
  IniPath := ExtractFilePath(Application.ExeName) + 'Saved.lng';
  IniLang(frmMain);
  IniLang(frmAbout);
  IniLang(frmSaveOnly);
  IniLang(frmSearch);
  IniLang(frmGenders);

  MsgBox(Lng_LNGSaved);

end;

procedure TfrmMain.LoadLang(Sender: TObject);
var
  sTmp: String;
begin

  if Sender = nil then
    Exit;

  if not (Sender as TMenuItem).Checked then
  begin
    (Sender as TMenuItem).Checked := True;

    Desigin := False;

    sTmp := (Sender as TMenuItem).Caption;
    if sTmp[1] = '&' then
      Delete(sTmp, 1, 1);
    IniPath := ExtractFilePath(Application.ExeName) +
      Copy(sTmp, 1, Pos(' - ', sTmp) - 1);

    IniLang(frmMain);
    IniLang(frmAbout);
    IniLang(frmSaveOnly);
    IniLang(frmSearch);
    IniLang(frmGenders);

    LoadGlobalLangSetting(IniPath);    
  end;

end;

procedure TfrmMain.mnuMFLoadWorkClick(Sender: TObject);
begin

  if IsChanged then
    if MsgBox(Lng_ChangedWork, mb_IconQuestion, mb_YesNo) = idNo then
      Exit;

  if dlgOpenWork.Execute then
    LoadLEW(dlgOpenWork.FileName);

end;

procedure TfrmMain.mnuMFSaveWorkClick(Sender: TObject);
var
  F: TFileStream;
  cBuf: Array[0..2] of AnsiChar;
  sStr: String[255];
  bVer, StrType: Byte;
  dwSize: DWORD;
  i, j, k, iInd, StrLen: Integer;
  BufArray: Array[0..2*1024] of Byte;
  Genders: TStrings;
begin

  if not dlgSaveWork.Execute then
    Exit;

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  F := TFileStream.Create(dlgSaveWork.FileName, fmCreate);

  cBuf := 'lew'; bVer := 3;
  F.Write(cBuf, 3); F.Write(bVer, 1);

  F.Write(FileVersion, 1);

  dwSize := Length(LangRecords);
  F.Write(dwSize, 4);
  for i := 0 to dwSize - 1 do
    F.Write(LangRecords[i], SizeOf(TLangRecord));

  lblCaption.Caption := Format(Lng_Saving, [F.Position * 100 div F.Size]);
  Application.ProcessMessages;

  dwSize := Length(OldTransArray);
  F.Write(dwSize, 4);
  for i := 0 to dwSize - 1 do
    F.Write(OldTransArray[i], SizeOf(TLangRecord));

  lblCaption.Caption := Format(Lng_Saving, [F.Position * 100 div F.Size]);
  Application.ProcessMessages;

  F.Write(GendersCount, 2);
  if GendersCount > 0 then
    for i := 0 to GendersCount - 1 do
    begin
      StrType := $01;
      F.Write(StrType, 1);
      F.Write(StringsCount, 2);

      Genders := TStringList.Create;
      Genders.Text := GendersArray[i];

      for j := 0 to StringsCount - 1 do
        for k := 0 to 2 do
        begin
          StrLen := Length(Genders[j * 3 + k]);
          F.Write(StrLen, 4);
          if StrLen > 0 then
          begin
            StringToWideChar(Genders[j * 3 + k], @BufArray, StrLen + 1);
            F.Write(BufArray, StrLen * 2 + 2);
          end;
        end;

      Genders.Free;
    end;

  lblCaption.Caption := Format(Lng_Saving, [F.Position * 100 div F.Size]);
  Application.ProcessMessages;

  iInd := 0;
  if lstFile.Selected <> nil then
    iInd := lstFile.Selected.Index;
  F.Write(iInd, 4);

  sStr := txtLangName.Text;
  dwSize := Length(sStr) + 1;
  F.Write(dwSize, 4);
  F.Write(sStr, dwSize);

  sStr := dlgOpen.FileName;
  dwSize := Length(sStr) + 1;
  F.Write(dwSize, 4);
  F.Write(sStr, dwSize);

  sStr := dlgSave.FileName;
  dwSize := Length(sStr) + 1;
  F.Write(dwSize, 4);
  F.Write(sStr, dwSize);

  F.Free;

  prgMain.Position := 0;
  lblCaption.Caption := Lng_Saved;
  Screen.Cursor := crDefault;

  RecentList.Add(dlgSaveWork.FileName);
  AddRecentList;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

  if IDE then
  begin
    mnuMLSave.Visible := True;
    mnuMFSplit.Visible := True;
    mnuMFSplitNum.Visible := True;
  end;

  LoadSettings;

  if mnuMLang.Count = 2 then
    LoadGlobalLangSetting(IniPath);

  dlgOpen.Filter := Lng_FilterLTC;
  dlgSave.Filter := Lng_FilterLTC;
  dlgOpenWork.Filter := Lng_FilterLEW;
  dlgSaveWork.Filter := Lng_FilterLEW;

  if ParamCount > 0 then
    if ExtractFileExt(ParamStr(1)) = '.ltf' then
      LoadLTF(ParamStr(1))
    else if ExtractFileExt(ParamStr(1)) = '.ltc' then
      LoadLTC(ParamStr(1))
    else if ExtractFileExt(ParamStr(1)) = '.lew' then
      LoadLEW(ParamStr(1))
		else
      Application.MessageBox(PChar(Lng_WrongExt), 'LTC Editor', MB_IconError);

end;

procedure TfrmMain.lblStatusClick(Sender: TObject);
begin

  frmGenderCorrection.ShowModal;

end;

procedure TfrmMain.popSaveClick(Sender: TObject);
var
  OldFile: String;
begin

  OldFile := dlgSave.FileName;

  if dlgSave.Execute then
    SaveFile(dlgSave.FileName, FileVersion, False, True);

  dlgSave.FileName := OldFile;

  ColorizeMemo(lstFile.Selected);

end;

procedure TfrmMain.mnuMFELTFClick(Sender: TObject);
var
  OldFile, LangPrefix: String;
  Genders: TStrings;
  F: TFileStream;
  BufArray: Array[0..4*1024] of Byte;
  Percent, i, j, k: Integer;
  Header: Word;
  bVersion: Byte;
  Full: Boolean;

  procedure WriteANSI2Unicode(Str: String; FS: TFileStream; Eng: Boolean);
  var
    StrLen: Integer;
  begin
    StrLen := Length(Str);
    StringToWideChar(Str, @BufArray, StrLen + 1);
    F.Write(BufArray, StrLen * 2);
  end;

  const
    PostFixes: Array[0..4] of String =
      ('_SINGULAR_1', '_SINGULAR_2', '_PLURAL_1', '_PLURAL_2', '_PLURAL_3');

begin

  bVersion := (Sender as TMenuItem).Tag;
  Full := Pos('Full', (Sender as TMenuItem).Name) > 0;

  OldFile := dlgSave.FileName;
  if OldFile <> '' then
    dlgSave.FileName := ChangeFileExt(OldFile, '.ltf');

  dlgSave.Filter := Lng_FilterLTF;
  if not dlgSave.Execute then
  begin
    dlgSave.Filter := Lng_FilterLTC;
    Exit;
  end;

  if FileExists(dlgSave.FileName) then
    DeleteFile(dlgSave.FileName);

  F := TFileStream.Create(dlgSave.FileName, fmCreate);
  F.Position := 0;

  Screen.Cursor := crHourGlass;

  Header := $FEFF;
  F.Write(Header, 2);

  WriteANSI2Unicode('LANGNAME: ' + frmMain.txtLangName.Text + #13#10, F, False);
  WriteANSI2Unicode('GENDERS: ' + IntToStr(GendersCount) + #13#10, F, True);
  WriteANSI2Unicode('BASESTRINGS: ' + IntToStr(StringsCount) + #13#10, F, True);
  WriteANSI2Unicode(#13#10, F, True);

  if GendersCount > 0 then
  begin
    LangPrefix := UpperCase(Copy(ExtractFileName(dlgSave.FileName), 1, 2));
    Genders := TStringList.Create;

    for i := 0 to StringsCount - 1 do
      for j := 0 to GendersCount - 1 do
      begin
        Genders.Text := GendersArray[j];

        WriteANSI2Unicode('GENDERINFO: ' + IntToStr(j) + ', "' +
          LangPrefix + PostFixes[j] + '", "' + Genders[i * 3] +
          '", "' + Genders[i * 3 + 1] + '", "' + Genders[i * 3 + 2] + '"' +
          #13#10, F, False);
      end;

    Genders.Free;
  end;
  WriteANSI2Unicode(#13#10, F, True);

  i := 0;
  while i <= High(LangRecords) do
  begin
    case bVersion of
      3:
        WriteANSI2Unicode('KEY: ' + LangRecords[i].Eng + #13#10, F, True);
      5:
        WriteANSI2Unicode('KEY-' + IntToStr(LangRecords[i].ID) + ': ' +
          LangRecords[i].Original + #13#10, F, True);
    end;

    j := 0;
    while LangRecords[i].Counter = LangRecords[i + j].Counter do
    begin
      case bVersion of
        3:
          WriteANSI2Unicode('STR-' + IntToStr(LangRecords[i + j].ID) + ': ' +
            LangRecords[i + j].Trans + #13#10, F, False);
        5:
          begin
            if (LangRecords[i + j].Gender <> '') and
              ((LangRecords[i + j - 1].Gender <> LangRecords[i + j].Gender) or
              (j = 0)) then
              WriteANSI2Unicode('KEY-' + IntToStr(LangRecords[i + j].ID) + '-' +
                LangRecords[i + j].Gender + ': ' +
                LangRecords[i + j].Eng + #13#10, F, False);

            if (LangRecords[i + j].CountID = 0) and
              not Full then
              WriteANSI2Unicode('STR-0: '#13#10, F, False)
            else
              WriteANSI2Unicode('STR-' + IntToStr(LangRecords[i + j].CountID) +
                ': ' + LangRecords[i + j].Trans + #13#10, F, False);
          end;
      end;

      Inc(j);
    end;
    Inc(i, j);

    WriteANSI2Unicode(#13#10, F, True);

    if i mod 500 = 0 then
    begin
      Percent := i * 100 div High(LangRecords);
      frmMain.lblCaption.Caption := Format(Lng_Saving, [Percent]);
      frmMain.prgMain.Position := Percent;
      Application.ProcessMessages;
    end;
  end;

  F.Free;

  RecentList.Add(dlgSave.FileName);
  AddRecentList;

  with frmMain do
  begin
    prgMain.Position := 0;
    lblCaption.Caption := Lng_Saved;
    dlgSave.Filter := Lng_FilterLTC;
    dlgSave.FileName := OldFile;
  end;

  Screen.Cursor := crDefault;
end;

procedure TfrmMain.mnuMFILTFClick(Sender: TObject);
var
  OldFile: String;
begin

  if not SaveIfChanged then
    Exit;

  OldFile := dlgOpen.FileName;
  if OldFile <> '' then
    dlgOpen.FileName := ChangeFileExt(OldFile, '.ltf');

  dlgOpen.Filter := Lng_FilterLTF;
  if not dlgOpen.Execute then
  begin
    Exit;
  end;

  LoadLTF(dlgOpen.FileName);

  dlgOpen.FileName := OldFile;
  dlgOpen.Filter := Lng_FilterLTC;

end;

procedure TfrmMain.mnuMORegisterClick(Sender: TObject);
var
  reg: TRegistry;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;

  if reg.OpenKey('.ltc', True) then
  begin
    reg.WriteString('', 'fmLanguageFile');
    reg.CloseKey;
  end;
  if reg.OpenKey('.ltf', True) then
  begin
    reg.WriteString('', 'fmLanguageFile');
    reg.CloseKey;
  end;
  if reg.OpenKey('.lew', True) then
  begin
    reg.WriteString('', 'ltcEditor');
    reg.CloseKey;
  end;

  if reg.OpenKey('fmLanguageFile', True) then
  begin
    reg.WriteString('', 'FM Language File (Translation)');
    reg.CloseKey;
  end;
  if reg.OpenKey('fmLanguageFile\shell', True) then
  begin
    reg.WriteString('', 'open');
    reg.CloseKey;
  end;
  if reg.OpenKey('fmLanguageFile\shell\open', True) then
  begin
    reg.WriteString('', 'Open and Edit');
    reg.CloseKey;
  end;
  if reg.OpenKey('fmLanguageFile\shell\open\command', True) then
  begin
    reg.WriteString('', '"' + Application.ExeName + '" "%1"');
    reg.CloseKey;
  end;
  if reg.OpenKey('fmLanguageFile\DefaultIcon', True) then
  begin
    reg.WriteString('', '"' + Application.ExeName + '",0');
    reg.CloseKey;
  end;

  if reg.OpenKey('ltcEditor', True) then
  begin
    reg.WriteString('', 'LTC Editor Workspace File');
    reg.CloseKey;
  end;
  if reg.OpenKey('ltcEditor\shell', True) then
  begin
    reg.WriteString('', 'open');
    reg.CloseKey;
  end;
  if reg.OpenKey('ltcEditor\shell\open', True) then
  begin
    reg.WriteString('', 'Open and Edit');
    reg.CloseKey;
  end;
  if reg.OpenKey('ltcEditor\shell\open\command', True) then
  begin
    reg.WriteString('', '"' + Application.ExeName + '" "%1"');
    reg.CloseKey;
  end;
  if reg.OpenKey('ltcEditor\DefaultIcon', True) then
  begin
    reg.WriteString('', '"' + Application.ExeName + '",0');
    reg.CloseKey;
  end;

  reg.Free;

end;

procedure TfrmMain.mnuMOUnRegisterClick(Sender: TObject);
var
  reg: TRegistry;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;

  reg.DeleteKey('.ltc');
  reg.DeleteKey('.ltf');
  reg.DeleteKey('.lew');
  reg.DeleteKey('fmLanguageFile');
  reg.DeleteKey('ltcEditor');  

  reg.Free;


end;

procedure WriteStatus(Item: TListItem; Grayed: Boolean);
var
  sFlags: Array[0..7] of String;
begin

  if Item <> nil then
  begin
	  sFlags[0] := IntToStr(LangRecords[Item.Index].ID);
	  if (FileVersion = 4) or (FileVersion = 5) then
  	  sFlags[1] := IntToStr(LangRecords[Item.Index].CountID)
	  else
  	  sFlags[1] := '-';
    if (FileVersion = 5) and
      (LangRecords[Item.Index].Gender <> '') then
      sFlags[2] := LangRecords[Item.Index].Gender
    else
      sFlags[2] := '-';
	  if LangRecords[Item.Index].Changed then
  	  sFlags[3] := Lng_Yes
	  else
  	  sFlags[3] := Lng_No;
	  if LangRecords[Item.Index].Added then
  	  sFlags[4] := Lng_Yes
	  else
  	  sFlags[4] := Lng_No;
	  if LangRecords[Item.Index].Removed then
  	  sFlags[5] := Lng_Yes
	  else
  	  sFlags[5] := Lng_No;
	  if LangRecords[Item.Index].NotTranslated then
  	  sFlags[6] := Lng_Yes
	  else
  	  sFlags[6] := Lng_No;
	  if LangRecords[Item.Index].Error then
  	  sFlags[7] := Lng_Yes
	  else
  	  sFlags[7] := Lng_No;

	  frmMain.lblStatus.Caption := Format(Lng_ItemHint, [sFlags[0], sFlags[1], sFlags[2],
  	  sFlags[3], sFlags[4], sFlags[5], sFlags[6], sFlags[7]]);

    if Grayed then
      frmMain.lblStatus.Font.Color := clGray
    else
      frmMain.lblStatus.Font.Color := clWindowText;
  end else
  	frmMain.lblStatus.Caption := '';

end;

procedure TfrmMain.lstFileMouseLeave(Sender: TObject);
begin

  WriteStatus(lstFile.Selected, False);

end;

procedure TfrmMain.lstFileMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

  WriteStatus(lstFile.GetItemAt(X, Y), True);

end;

procedure TfrmMain.mnuMFLoadAddingClick(Sender: TObject);
begin

  if not SaveIfChanged or
     not dlgOpen.Execute then
    Exit;

  LoadLTC(dlgOpen.FileName, True);

end;

procedure TfrmMain.mnuMFOpenEnglishClick(Sender: TObject);
begin

  if not SaveIfChanged or
     not dlgOpen.Execute then
    Exit;

  LoadLTC(dlgOpen.FileName, False, True);

end;

procedure TfrmMain.TextReplace(Sender: TObject);
begin

	if frmMain.memTrans.SelLength > 0 then
  	frmMain.memTrans.SelText := (Sender as TMenuItem).Caption;
  memTrans.SelAttributes.Style := memTrans.SelAttributes.Style - [fsUnderline];

  CompareTranslation;
  ColorizeMemo(lstFile.Selected);

end;


procedure TfrmMain.memTransMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
//var
//  colSpellErrors: ProofReadingErrors;
//  colSuggestions: SpellingSuggestions;
//  i, j, iChar: Integer;
//  miSuggest: TMenuItem;
//  P: TPoint;
begin
{
	if (Button = mbRight) and
     (WordExists) then
  begin
  	P := Point(X, Y);
		iChar := (Sender as TRichEdit).Perform(EM_CHARFROMPOS, 0, Integer(@P));

    for i := popMemo.Items.Count - 1 downto 0 do
    	popMemo.Items[i].Free;
    popMemo.Items.Clear;

  	WordDoc.Range.Set_Text(GetWord((Sender as TRichEdit).Text, iChar, i, j));
	  colSpellErrors := frmMain.WordDoc.SpellingErrors;

    (Sender as TRichEdit).SelStart := i - 1;
	  (Sender as TRichEdit).SelLength := j;

  	if colSpellErrors.Count > 0 then
	  begin
			RE_SetCharFormat((Sender as TRichEdit), CFU_UNDERLINEWAVE, $50);
      (Sender as TRichEdit).SelAttributes.Style :=
      	(Sender as TRichEdit).SelAttributes.Style + [fsUnderline];

	 	  colSuggestions := frmMain.WordApp.GetSpellingSuggestions
				(colSpellErrors.Item(1).Get_Text);
      if colSuggestions.Count = 0 then
      begin
	    	miSuggest := TMenuItem.Create(popMemo);
  	    miSuggest.Caption := Lng_NoSpellSuggs;
    	  miSuggest.Enabled := False;
      	popMemo.Items.Add(miSuggest);
      end else
		    for j := 1 to colSuggestions.Count do
  	    begin
	  	    miSuggest := TMenuItem.Create(popMemo);
      	  miSuggest.Caption := VarToStr(colSuggestions.Item(j));
          miSuggest.OnClick := TextReplace;
      		popMemo.Items.Add(miSuggest);
	      end;
	 	end else begin
      (Sender as TRichEdit).SelAttributes.Style :=
      	(Sender as TRichEdit).SelAttributes.Style - [fsUnderline];

    	miSuggest := TMenuItem.Create(popMemo);
      miSuggest.Caption := Lng_NoSpellErrors;
      miSuggest.Enabled := False;
      popMemo.Items.Add(miSuggest);
    end;

		GetCursorPos(P);
		popMemo.Popup(P.X, P.Y);
  end;
}
end;

procedure HTMLSyntax(RE: TRichEdit);
var
  i, j, CurPos: Integer;
  sText: string;
  Col, TagCol, ComCol, ServCol: TColor;
  SOp: TSearchTypes;
begin

	// Задаем цвета раскраски
	TagCol := clRed; // Таги
  ComCol := clBlue; // Комментарии
  ServCol := clGreen; // Служебные строки

	CurPos := RE.SelStart;

  RE.SelectAll;
  RE.SelAttributes.Color := clWindowText;

	sText := RE.Text;

  if frmMain.txtSearch.Text <> '' then
  begin
	  i := 0;
  	if frmMain.chkCaseSens.Checked then
  		SOp := [stMatchCase]
	  else
  		SOP := [];

	  j := RE.FindText(frmMain.txtSearch.Text, i, Length(sText), SOp);
  	while j > -1 do
	  begin
		  j := RE.FindText(frmMain.txtSearch.Text, i, Length(sText), SOp);
  	  RE.SelStart := j;
    	RE.SelLength := Length(frmMain.txtSearch.Text);

			RE_SetSelBgColor(RE, clYellow);

      i := j + 1;
  	end;
  end;

  i := 1;
	while i <= Length(sText) do
  begin
    if sText[i] in OpenPunct then
    begin
		  j := i + 1;

      if sText[j] = '%' then
      	Col := TagCol
      else if sText[i] = '{' then
      	Col := ServCol
      else
      	Col := ComCol;

  	  while j <= Length(sText) do
      begin
    		if sText[j] in ClosePunct then
        begin
        	RE.SelStart := i - 1;
          RE.SelLength := j - i + 1;
          RE.SelAttributes.Color := Col;

        	i := j;
          break;
        end;

        Inc(j);
      end;
    end else if (sText[i] = '\') and
				        (sText[i + 1] = 'n') then
    begin
	    Col := ServCol;

	   	RE.SelStart := i - 1;
      RE.SelLength := 2;
      RE.SelAttributes.Color := Col;
		end else if sText[i] in Punct then
    begin
	    Col := ServCol;

	   	RE.SelStart := i - 1;
      RE.SelLength := 1;
      RE.SelAttributes.Color := Col;
		end;

    Inc(i);
  end;

  RE.SelStart := CurPos;
  RE.SelLength := 0;

end;

procedure TfrmMain.memTransKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_RETURN then
    Key := 0;

end;

procedure TfrmMain.memTransKeyPress(Sender: TObject; var Key: Char);
begin

  if ((Sender as TRichEdit).SelLength > 0) or
		 not (Key in Punct) then
    Exit;

  SpellingCheck((Sender as TRichEdit), False,
  	LangRecords[lstFile.Selected.Index].NotTranslated);
	HTMLSyntax((Sender as TRichEdit));

end;

procedure TfrmMain.mnuMSCheckSpellingClick(Sender: TObject);
//var
//  Cancel: Boolean;
//  i, Ind: Integer;
begin
{
  Ind := 0;
  if lstFile.Selected <> nil then
    Ind := lstFile.Selected.Index;

	WordDoc.TrackRevisions := True; // note if changes are made

  for i := Ind to High(LangRecords) do
  begin
	  WordDoc.Range.Set_Text(memTrans.Text);

  	WordDoc.CheckSpelling;

	  Cancel := not WordDoc.Range.SpellingChecked;
  	WordApp.Visible := False; // need to stop ActiveDocument appearing

  	if WordDoc.Range.Revisions.Count > 0 then
	  begin
  		WordDoc.Range.Revisions.AcceptAll; // accept all changes
    	memTrans.Text := WordDoc.Range.Get_Text;

//      CompareTranslation;
	  end;

    if Cancel then
    	Break;

    lstFile.Items[i].Selected := False;
    lstFile.ItemIndex := i + 1;
    lstFile.Items[i + 1].Focused := True;
    lstFile.Items[i + 1].Selected := True;

    lstFile.Selected.MakeVisible(False);

    Application.ProcessMessages;
  end;

	WordDoc.TrackRevisions := False; // don't track future changes
}
end;

procedure TfrmMain.memTransExit(Sender: TObject);
begin

  CompareTranslation;
  ColorizeMemo(lstFile.Selected);

end;

procedure TfrmMain.mnuMFSplitClick(Sender: TObject);
var
  OldFile, Num: String;
  F1, F2, F3: TFileStream;
  BufArray: Array[0..4*1024] of Byte;
  Percent, i, j: Integer;
  Header: Word;
  DoNum: Boolean;

  procedure WriteANSI2Unicode(Str: String; FS: TFileStream; Eng: Boolean);
  var
    StrLen: Integer;
  begin
    StrLen := Length(Str);
    StringToWideChar(Str, @BufArray, StrLen + 1);
    FS.Write(BufArray, StrLen * 2);
  end;

begin

  DoNum := Pos('Num', (Sender as TMenuItem).Name) > 0;

  F1 := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'ENG.txt', fmCreate);
  F1.Position := 0;
  F2 := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'TRN.txt', fmCreate);
  F2.Position := 0;
  F3 := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'ORG.txt', fmCreate);
  F3.Position := 0;

  Screen.Cursor := crHourGlass;

  Header := $FEFF;
  F1.Write(Header, 2);
  F2.Write(Header, 2);
  F3.Write(Header, 2);

  Num := '';

  i := 0;
  while i <= High(LangRecords) do
  begin
    if DoNum then
      Num := Format('%.5d - ', [i]);

    WriteANSI2Unicode(Num + LangRecords[i].Original + #13#10, F3, True);
    WriteANSI2Unicode(Num + LangRecords[i].Eng + #13#10, F1, True);

    j := 0;
    while LangRecords[i].Counter = LangRecords[i + j].Counter do
    begin
      WriteANSI2Unicode(Num + LangRecords[i + j].Trans + #13#10, F2, False);

      Inc(j);
    end;

    if i mod 500 = 0 then
    begin
      Percent := i * 100 div High(LangRecords);
      frmMain.lblCaption.Caption := Format(Lng_Saving, [Percent]);
      frmMain.prgMain.Position := Percent;
      Application.ProcessMessages;
    end;

    Inc(i);
  end;

  F1.Free;
  F2.Free;  

  RecentList.Add(dlgSave.FileName);
  AddRecentList;

  with frmMain do
  begin
    prgMain.Position := 0;
    lblCaption.Caption := Lng_Saved;
    dlgSave.Filter := Lng_FilterLTC;
    dlgSave.FileName := OldFile;
  end;

  Screen.Cursor := crDefault;
end;


procedure TfrmMain.mnuMFEVer4Click(Sender: TObject);
begin

  if dlgSave.Execute then
    SaveFile(dlgSave.FileName, 4, False);

end;

procedure TfrmMain.mnuMFEVer5Click(Sender: TObject);
begin

  if dlgSave.Execute then
    SaveFile(dlgSave.FileName, 5, False);

end;

end.
