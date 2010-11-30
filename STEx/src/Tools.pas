unit Tools;
// 2003 PA
// Обёртка для SHBrowseForFolder
interface
Const
  BIF_NEWDIALOGSTYLE=$40;
  {Неописаная в Delphi константа - параметр отображения диалога выбора папок (новый стиль)}

Var
   LastFOPath:string;

function BrowseDialog(Const Title:string;Const Flag: integer;Const StartDir:string = ''): string;

implementation
Uses
   ShellApi, Windows, ShlObj;

function BrowseCallbackProc(hwnd:HWND;uMsg:UINT;lParam:LPARAM;lpData:LPARAM):integer; stdcall;
Begin
  if uMsg=BFFM_INITIALIZED then SendMessage(hwnd,BFFM_SETSELECTION,integer(true),integer(PChar(LastFOPath)));
End;

function BrowseDialog(Const Title:string;Const Flag: integer;Const StartDir:string = ''): string;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  TempPath : array[0..MAX_PATH] of char;
begin
  if StartDir<>'' then LastFOPath:=StartDir;
  Result:='';
  FillChar(BrowseInfo, sizeof(TBrowseInfo),#0);
  BrowseInfo.lpfn:=BrowseCallbackProc;
  BrowseInfo.lpszTitle:=PChar(Title);
  BrowseInfo.ulFlags:=Flag;
  lpItemID:=SHBrowseForFolder(BrowseInfo);
  if lpItemId<>nil then begin
    SHGetPathFromIDList(lpItemID,TempPath);
    Result:=TempPath;
    GlobalFreePtr(lpItemID);
    LastFOPath:=TempPath;
  end;
end;

end.
