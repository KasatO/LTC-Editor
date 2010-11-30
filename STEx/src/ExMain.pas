unit ExMain;

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
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus, ImgList, ComCtrls, ToolWin;

type
  TExMainForm = class(TForm)
    Panel1: TPanel;
    StaticText1: TStaticText;
    Splitter1: TSplitter;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    MainMenu1: TMainMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    ComboBox1: TComboBox;
    SpeedButton2: TSpeedButton;
    langMenuItem: TMenuItem;
    FontDialog1: TFontDialog;
    N7: TMenuItem;
    N8: TMenuItem;
    StaticText3: TStaticText;
    GroupBox1: TGroupBox;
    StaticText4: TStaticText;
    Edit2: TEdit;
    StaticText5: TStaticText;
    Edit3: TEdit;
    SpeedButton3: TSpeedButton;
    N9: TMenuItem;
    N10: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ImageList1: TImageList;
    N11: TMenuItem;
    N12: TMenuItem;
    Panel7: TPanel;
    Splitter3: TSplitter;
    Panel8: TPanel;
    Panel6: TPanel;
    Panel9: TPanel;
    ListBox1: TListBox;
    Panel10: TPanel;
    N13: TMenuItem;
    N15: TMenuItem;
    Memo1: TMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    Memo3: TMemo;
    Panel5: TPanel;
    Panel4: TPanel;
    Memo2: TMemo;
    Panel11: TPanel;
    Splitter2: TSplitter;
    N6: TMenuItem;
    Label1: TLabel;
    ComboBox2: TComboBox;
    procedure Save(Sender: TObject);
    procedure SaveAs(Sender: TObject);
    procedure Panel6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Find(Sender: TObject);
    procedure Open(Sender: TObject);
    procedure Replace(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure AddNew(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SaveAll(Sender: TObject);
    procedure Panel6DblClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Panel10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel10MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel10Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N15Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenFile(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Lang:TStrings;
    FileList:TStrings;
    iniName,
    pasName,
    varName:string;
    ActivPanel:integer;
    FindStart:integer;
    Declar:integer;
    Code:integer;
    pasChange:boolean;
    iniChange:boolean;
    varChange:boolean;
    RussOnly:boolean;
    UsePrefiks:boolean;
    prefiks:string;
    procedure pasSave;
    procedure iniSave;
    procedure varSave;
    function NameCheck(Const s:string):string;
    procedure BuldMenu;
    procedure BuildCode(Const ADeclar,DefValue:string);
    procedure ChangeLang(Sender: TObject);
    function SaveCheck(Const x:integer):boolean;
    function CloseCheck(Const tag:integer):boolean;
    procedure FillList(Const Path:String);
    procedure LoadIni;
    procedure SaveIni;

    procedure OpenIniFile;
    procedure OpenVarFile;
    procedure GetWorkPositions;
    function CanInsert:boolean;
  end;

var
  ExMainForm: TExMainForm;
  HelpKeyFileName:string;
implementation

uses PAmultilang, IniFiles, Menu, Tools, ShlObj, AboutUnit;

{$R *.dfm}
Var
  {Declaretion start}
  ZeroLenError:string;
  FileNameError:string;
  Lng_SaveDialogFilterIni:string;
  Lng_SaveDialogTitleIni:string;
  Lng_SaveDialogFilterPas:string;
  Lng_SaveDialogTitlePas:string;
  Lng_SaveDialogTitleNewPas:string;
  Lng_FindClose:string;
  Lng_SaveQ:string;
  Lng_SelFolder:string;
  Lng_OutFileError:string;

procedure LoadGlobalLangSetting(Const FileName:string);
Var
    ini:TIniFile;
Begin
  ini:=TInifile.Create(FileName);
  {Code start}
  ZeroLenError:=ini.ReadString('Global','ZeroLenError','Имя не может быть, пустой строкой');
  FileNameError:=ini.ReadString('Global','FileNameError','Неверное имя');
  Lng_SaveDialogFilterIni:=ini.ReadString('Global','Lng_SaveDialogFilterIni','ini файл|*.ini');
  Lng_SaveDialogTitleIni:=ini.ReadString('Global','Lng_SaveDialogTitleIni','Сохранение файла настроек');
  Lng_SaveDialogFilterPas:=ini.ReadString('Global','Lng_SaveDialogFilterPas','pas файл|*.pas');
  Lng_SaveDialogTitlePas:=ini.ReadString('Global','Lng_SaveDialogTitlePas','Сохранение исходного кода');
  Lng_SaveDialogTitleNewPas:=ini.ReadString('Global','Lng_SaveDialogTitleNewPas','Сохранение полученного кода');
  Lng_FindClose:=ini.ReadString('Global','Lng_FindClose','Поиск закончен');
  Lng_SaveQ:=ini.ReadString('Global','Lng_SaveQ','Сохранить "%s" перед закрытием?');
  Lng_SelFolder:=ini.ReadString('Global','Lng_SelFolder','Выберите папку');
  HelpKeyFileName:=ExtractFilePath(Application.ExeName)+ini.ReadString('Global','HelpKeyFileName','');
  Lng_OutFileError:=ini.ReadString('Global','Lng_OutFileError','Неверный формат файла результирующего кода');
  ini.free;
End;

procedure TExMainForm.iniSave;
begin
  SaveDialog1.Filter:=Lng_SaveDialogFilterIni;
  SaveDialog1.Title:=Lng_SaveDialogTitleIni;
  if iniName='' then
    if SaveDialog1.Execute then iniName:=SaveDialog1.FileName;
  if iniName<>'' then Memo3.Lines.SaveToFile(iniName)
                 else exit;
  iniChange:=false;
  Panel5.Caption:=ExtractFileName(iniName);
  Panel5.Font.Color:=clWindowText;
end;

procedure TExMainForm.Save(Sender: TObject);
begin
 Case ActivPanel of
      1:pasSave;
      2:varSave;
      3:iniSave;
 End;
end;

procedure TExMainForm.pasSave;
begin
  SaveDialog1.Filter:=Lng_SaveDialogFilterPas;
  SaveDialog1.Title:=Lng_SaveDialogTitlePas;
  if pasName='' then
    if SaveDialog1.Execute then pasName:=SaveDialog1.FileName;
  if pasName<>'' then Memo1.Lines.SaveToFile(pasName)
                 else exit;
  pasChange:=false;
  Panel6.Caption:=ExtractFileName(pasName);
  Panel6.Font.Color:=clWindowText;
end;

procedure TExMainForm.varSave;
begin
  SaveDialog1.Filter:=Lng_SaveDialogFilterPas;
  SaveDialog1.Title:=Lng_SaveDialogTitleNewPas;
  SaveDialog1.FilterIndex:=1;
  if varName='' then
    if SaveDialog1.Execute then varName:=SaveDialog1.FileName;
  if varName<>'' then Memo2.Lines.SaveToFile(varName)
                 else exit;
  varChange:=false;
  Panel11.Caption:=ExtractFileName(varName);
  Panel11.Font.Color:=clWindowText;
end;

procedure TExMainForm.SaveAs(Sender: TObject);
begin
   Case ActivPanel  of
        1:pasName:='';
        2:varName:='';
        3:iniName:='';
   End;
  Save(Sender);
end;

procedure TExMainForm.Panel6MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 ActivPanel:=(Sender as TPanel).Tag;
end;

procedure TExMainForm.Find(Sender: TObject);
var
   x,i:integer;
   text:string;
   flag,Start:boolean;
begin
 text:=Memo1.Text;
 Start:=false;
 x:=Memo1.SelStart+Memo1.SelLength+1;
 While x<=length(Text)-3 do
  Begin
  if Text[x]=#$27 then
    Begin
      Start:=not Start;
      i:=x+1;
      flag:=false;
      While (Text[i]<>#$27)and(i<>length(Text)-1)and Start do
        Begin
          
          if Text[i] in ['а'..'я','А'..'Я'] then
             flag:=true;
          if Text[i]=#$27 then Start:=not Start;
          inc(i);
        End;
      if flag then
        Begin
          Memo1.SelStart:=x-1;
          Memo1.SelLength:=i-x+1;
          SendMessage(Memo1.Handle,EM_SCROLLCARET,0,0);
          ActiveControl:=ComboBox1;
          exit;
        End;
      x:=i-1;
    End;
  inc(x);
  End;
 ShowMessage(Lng_FindClose);
 ActiveControl:=Memo1;
end;

procedure TExMainForm.Open(Sender: TObject);
var
   Name:string;
begin
 Name:=Panel6.Caption;
 if pasChange then
   if SaveCheck(1) then
     if Name<>'' then pasSave
                    else
                    else exit;
 if OpenDialog1.Execute then
   Begin
     Memo1.OnChange:=nil;
     Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
     pasName:=OpenDialog1.FileName;
     Panel6.Caption:=ExtractFileName(pasName);
     Memo1.OnChange:=Memo1Change;
   End;
end;

procedure TExMainForm.Replace(Sender: TObject);
Var
   Buf:string;
begin
  if not CanInsert then
    Begin
      ShowMessage(Lng_OutFileError);
      exit
    End;
  if Memo1.SelText='' then exit;
  if ComboBox1.ItemIndex<0 then
    if UsePrefiks then
      if pos(prefiks,ComboBox1.Text)<>1 then
        ComboBox1.Text:=prefiks+ComboBox1.Text;
  buf:=NameCheck(ComboBox1.Text);
  if buf<>'' then
    Begin
      ShowMessage(Buf);
      exit;
    End;
  Buf:=Copy(Memo1.SelText,1,length(Memo1.SelText));
  Memo1.SelText:=ComboBox1.Text;
  if ComboBox1.Items.IndexOf(ComboBox1.Text)>=0 then exit;
  ComboBox2.Items.Add(Buf);
  ComboBox1.Items.Add(ComboBox1.Text);
  ComboBox1.SelectAll;
  BuildCode(ComboBox1.Text,Buf);
end;

procedure TExMainForm.FormCreate(Sender: TObject);
begin
 Lang:=TStringList.Create;
 FileList:=TStringList.Create;
 LoadIni; // Загрузка настроек программы
 LoadGlobalLangSetting(IniPath); // Инициализация глобальных языковых параметров
 IniLang(TCustomForm(Self)); // Прменяем текущий язык для формы.
 FillList(LastFOPath);
 BuldMenu;
 Declar:=1;
 Code:=9;
end;

function TExMainForm.NameCheck(Const s:string): string;
Var
   x:integer;
begin
  if s='' then
    Begin
      result:=ZeroLenError;
      exit;
    End;
  if not(s[1] in ['a'..'z','A'..'Z']) then
    Begin
      result:=FileNameError;
      exit;
    End;
  for x:=2 to length(s)-1 do
    if not(s[1] in ['a'..'z','A'..'Z','0'..'9']) then
      Begin
        result:=FileNameError;
        exit;
      End;
end;

procedure TExMainForm.BuldMenu;
// Заполнение языкового меню доступными файлами языков.
Var
   sr:TSearchRec;
   Item:TMenuItem;
   s:string;
begin
  // Ишщем в каталоге с программой файлы с расширением lng.
  if FindFirst(ExtractFilePath(Application.ExeName)+'*.lng',faAnyFile,sr)=0 then
    Begin
      Repeat
        s:=ExtractFilePath(Application.ExeName)+sr.Name;
        Lang.Add(s);
        Item:=TMenuItem.Create(Application);
        if s=IniPath then Item.Checked:=true;
        Item.Caption:=ChangeFileExt(ExtractFileName(sr.Name),'');
        Item.Tag:=Lang.Count-1;
        Item.OnClick:=ChangeLang;
        langMenuItem.Add(Item);
      Until FindNext(sr)<>0;
      FindClose(sr);
    End;
End;

procedure TExMainForm.ChangeLang(Sender: TObject);
var
   x:integer;
begin
  for x:=0 to langMenuItem.Count-1 do
    langMenuItem[x].Checked:=false;
  (Sender as TMenuItem).Checked:=true;
  IniPath:=lang[(Sender as TMenuItem).tag]; // Меняем текущий язык.
  LoadGlobalLangSetting(IniPath); // Перегружаем глобальные строковые переменные.
  IniLang(TCustomForm(Self)); // Применяем установленый язык.
end;

procedure TExMainForm.N8Click(Sender: TObject);
begin
  Case ActivPanel of
       1:FontDialog1.Font:=Memo1.Font;
       2:FontDialog1.Font:=Memo2.Font;
       3:FontDialog1.Font:=Memo3.Font;
  End;
  if FontDialog1.Execute then
    Case ActivPanel of
         1:Memo1.Font:=FontDialog1.Font;
         2:Memo2.Font:=FontDialog1.Font;
         3:Memo3.Font:=FontDialog1.Font;
    End;
end;


procedure TExMainForm.BuildCode(const ADeclar, DefValue: string);
begin
  Memo2.Lines.Insert(Declar,'  '+ADeclar+':string;');
  Memo2.Lines.Insert(Code,'  '+ADeclar+':=ini.ReadString(''Global'''+','''+
          ADeclar+''','+DefValue+');');
  Memo3.Lines.Add(ADeclar+'='+Copy(DefValue,2,length(DefValue)-2));
  inc(Declar);
  inc(Code,2);
end;

procedure TExMainForm.AddNew(Sender: TObject);
Var
   Buf:string;
begin
  if not CanInsert then
    Begin
      ShowMessage(Lng_OutFileError);
      exit;
    End;
  buf:=NameCheck(Edit2.Text);
  if buf<>'' then
    Begin
      ShowMessage(Buf);
      exit;
    End;
  if ComboBox1.Items.IndexOf(Edit2.Text)>=0 then exit;

  ComboBox2.Items.Add(''''+Edit3.Text+'''');
  ComboBox1.Items.Add(Edit2.Text);

  BuildCode(Edit2.Text,''''+Edit3.Text+'''');
end;

procedure TExMainForm.Edit2Enter(Sender: TObject);
begin
  if (Sender as TEdit).SelLength<>length((Sender as TEdit).Text) then
    (Sender as TEdit).SelectAll;
end;

function TExMainForm.SaveCheck(Const x:integer): boolean;
Var
   s:string;
begin
  Case x of
       1:s:=Panel6.Caption;
       2:s:=Panel4.Caption;
       3:s:=Panel5.Caption;
  End;
  result:=true;
  Case MessageBox(Application.Handle,PChar(Format(Lng_SaveQ,[s])),'',MB_YESNOCANCEL) of
       IDYES:result:=true;
       IDCANCEL:result:=false;
       IDNO:Begin
              Name:='';
              result:=true;
            End;
  End;
end;

procedure TExMainForm.Memo1Change(Sender: TObject);
begin
 Case (Sender as TMemo).Tag of
       1:Begin
          Panel6.Font.Color:=clRed;
          pasChange:=true;
         End;
       2:Begin
           Panel4.Font.Color:=clRed;
           varChange:=true;
         End;
       3:Begin
           Panel5.Font.Color:=clRed;
           iniChange:=true;
         End;
 End;
end;


procedure TExMainForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   x:integer;
begin
 for x:=1 to 3 do
   Begin
     CanClose:=CloseCheck(x);
     if not CanClose then exit;
   End;
end;

function TExMainForm.CloseCheck(const tag: integer): boolean;
var
  Name:string;
  x:boolean;
begin
 Case Tag of
      1:x:=pasChange;
      2:x:=varChange;
      3:x:=iniChange;
 End;
 result:=true;
 if x then
   Begin
      result:=SaveCheck(tag);
      if result then
        if Name<>'' then
          Case Tag of
               1:pasSave;
               2:varSave;
               3:iniSave;
          End;
    End;
end;

procedure TExMainForm.SaveAll(Sender: TObject);
var
   x:integer;
begin
  for x:=1 to 3 do
    Begin
      ActivPanel:=x;
      Save(Sender);
    End;
end;

procedure TExMainForm.Panel6DblClick(Sender: TObject);
begin
  Save(Sender);
end;

procedure TExMainForm.N11Click(Sender: TObject);
begin
  GetSetings(RussOnly,Useprefiks,prefiks); 
end;

procedure TExMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
       112:Open(Self);
       113:SaveAll(Self);
       114:find(Self);
  End;
  if Shift=[ssAlt] then
    Case key of
         40:if ListBox1.ItemIndex<ListBox1.Items.Count-1 then ListBox1.ItemIndex:=ListBox1.ItemIndex+1;
         38:if ListBox1.ItemIndex>0 then ListBox1.ItemIndex:=ListBox1.ItemIndex-1;
         13:ListBox1DblClick(Self);
    End;
end;

procedure TExMainForm.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=13 then Replace(Self);
end;

procedure TExMainForm.Panel10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TPanel).BevelOuter:=bvLowered;
end;

procedure TExMainForm.Panel10MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (sender as TPanel).BevelOuter:=bvRaised;
end;

procedure TExMainForm.Panel10Click(Sender: TObject);
Var
   s:string;
begin
  s:=BrowseDialog(Lng_SelFolder,BIF_RETURNONLYFSDIRS);
  if s<>'' then FillList(s);
end;

procedure TExMainForm.FillList(const Path: String);
Var
   sr:TSearchRec;
   s:string;
begin
  if Path='' then exit;
  ListBox1.Items.Clear;
  FileList.Clear;
  s:=Path;
  if s[length(s)]<>'\' then s:=s+'\';
  if FindFirst(s+'*.pas',faAnyFile,sr)=0 then
    Begin
      Repeat
        ListBox1.Items.Add(ChangeFileExt(sr.Name,''));
        FileList.Add(s+sr.Name);
      Until FindNext(sr)<>0;
      FindClose(sr);
    End;
End;

procedure TExMainForm.ListBox1DblClick(Sender: TObject);
Var
   Name:string;
begin
  if Listbox1.ItemIndex<0 then exit;
  Name:=pasName;
  if pasChange then
    if SaveCheck(1) then
      if Name<>'' then pasSave
                  else
                  else exit;
  Memo1.OnChange:=nil;
  Memo1.Lines.LoadFromFile(FileList[ListBox1.ItemIndex]);
  pasName:=FileList[ListBox1.ItemIndex];
  Panel6.Caption:=ExtractFileName(pasName);
  Memo1.OnChange:=Memo1Change;
end;

procedure TExMainForm.LoadIni;
var
   ini:TIniFile;
begin
  ini:=TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  RussOnly:=ini.ReadBool('Main','RussOnly',false);
  UsePrefiks:=ini.ReadBool('Main','UsePrefiks',true);
  prefiks:=ini.ReadString('Main','prefiks','Lng_');
  LastFOPath:=ini.ReadString('Main','LastFOPath','');
  IniPath:=ExtractFilePath(Application.ExeName)+ini.ReadString('Main','IniPath','');
  ini.Free;
end;

procedure TExMainForm.SaveIni;
var
   ini:TIniFile;
begin
  try
    ini:=TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    ini.WriteBool('Main','RussOnly',RussOnly);
    ini.WriteBool('Main','UsePrefiks',UsePrefiks);
    ini.WriteString('Main','prefiks',prefiks);
    ini.WriteString('Main','LastFOPath',LastFOPath);
    ini.WriteString('Main','IniPath',ExtractFileName(IniPath));
  finally
    ini.Free;
  End;
end;

procedure TExMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveIni;
end;

procedure TExMainForm.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then key:=#0;
end;

procedure TExMainForm.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then AddNew(Self);  
end;

procedure TExMainForm.N15Click(Sender: TObject);
begin
 About;
end;

procedure TExMainForm.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in [13,32] then ListBox1DblClick(Sender);
end;

procedure TExMainForm.OpenFile(Sender: TObject);
begin
  Case ActivPanel of
       1:Open(Self);
       2:OpenVarFile;
       3:OpenIniFile;
  End;
end;

procedure TExMainForm.OpenIniFile;
begin
 Memo3.OnChange:=nil;
 if not CloseCheck(3) then exit;
 if OpenDialog1.Execute then
   Begin
     Memo3.Lines.LoadFromFile(OpenDialog1.FileName);
     iniName:=OpenDialog1.FileName;
   End;
 Memo3.OnChange:=Memo1Change;
end;


procedure TExMainForm.OpenVarFile;
begin
 Memo2.OnChange:=nil;
 if not CloseCheck(2) then exit;
 if OpenDialog1.Execute then
   Begin
     Memo2.Lines.LoadFromFile(OpenDialog1.FileName);
     Panel11.Font.Color:=clWindowText;
     varChange:=false;
   End;
 Memo2.OnChange:=Memo1Change;
end;

procedure TExMainForm.GetWorkPositions;
Var
  x:integer;
begin
  Code:=-1;
  Declar:=-1;
  for x:=0 to Memo2.Lines.Count-1 do
    if CompareText('{Code start}',Trim(Memo2.Lines[x]))=0 then
      Begin
        Code:=x+2;
        break;
      End;
  for x:=0 to Memo2.Lines.Count-1 do
    if CompareText('{Declaration start}',Trim(Memo2.Lines[x]))=0 then
      Begin
        Declar:=x+1;
        break;
      End;
end;

function TExMainForm.CanInsert: boolean;
begin
  GetWorkPositions;
  result:=(Code>0)and(Declar>0);
end;

procedure TExMainForm.ComboBox1Select(Sender: TObject);
begin
  ComboBox1.ItemIndex:=(Sender as TComboBox).ItemIndex;
  ComboBox2.ItemIndex:=(Sender as TComboBox).ItemIndex;
end;

end.
