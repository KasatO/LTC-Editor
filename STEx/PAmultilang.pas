unit PAmultilang;

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

Uses
    Forms, SysUtils, Classes, Controls, Menus, IniFiles, StdCtrls;
Var
   Desigin:boolean = false;
   ////////////////////////////////////////////////////////////////////
   //  Эта переменная задаёт режим работы модуля                     //
   //  true - режим разработки - языковой файл будет создан          //
   //  false - рабочий режим - применение языкового файла к формам   //
   ////////////////////////////////////////////////////////////////////

   IniPath:string = 'D:\mlEx.lng';
   ////////////////////////////////////////////////////////////////////
   //  Имя языкового файла (выходной файл при Desigin=true),         //
   //  может изменятся и в Run time для смены языка                  //
   ////////////////////////////////////////////////////////////////////

   intLang:boolean = false;
   ////////////////////////////////////////////////////////////////////
   //  Активность модуля                                             //
   //  False - Языковые настройки не применяются                     //
   //  True - Модуль работает                                        //
   ////////////////////////////////////////////////////////////////////

procedure IniLang(Const Form:TCustomForm;Const FileName:string = '');
////////////////////////////////////////////////////////////////////
//  При Desigin=False -                                           //
//  применяет языковые параметры к форме Form из файла FileName   //
//                                                                //
//  При Desigin=True -                                            //
//  Выписывает языковые параметры формы Form в файл FileName      //
//                                                                //
//  Если параметр FileName опущен, или FileName='', то            //
//  FileName присваевается значение IniPath                       //
//                                                                //
//  Пример вызова:                                                //
//  IniLang(TCustomForm(Self));                                   //
//  Плместите подобный вызов этой проседуры в обработчик OnCreate //
//  форм в которых вы хотите сделать поддержку нескольких языков  //
////////////////////////////////////////////////////////////////////

implementation

procedure SetLang(Const Form:TCustomForm;Const FileName:string = '');
Var
   ini:TIniFile;
   y:integer;
   Name,Buf:string;
Begin
  if intLang then exit;
  if FileName='' then Name:=IniPath
                 else Name:=FileName;
  ini:=TIniFile.Create(Name);
  Name:=Form.ClassName;
  Buf:=ini.ReadString(Form.ClassName,Name+'Caption','');
  if buf<>'' then Form.Caption:=buf;
  for y:=0 to Form.ComponentCount-1 do
    Begin
      if Form.Components[y] is TControl then
        Begin
          Name:=TControl(Form.Components[y]).Name;
          Buf:=ini.ReadString(Form.ClassName,Name+'Text','');
          if buf<>'' then TControl(Form.Components[y]).SetTextBuf(PChar(Buf));
          Buf:=ini.ReadString(Form.ClassName,Name+'Hint','');
          if buf<>'' then TControl(Form.Components[y]).Hint:=buf;
        End;
      if Form.Components[y] is TMenuItem then
        Begin
          Name:=TMenuItem(Form.Components[y]).Name;
          Buf:=ini.ReadString(Form.ClassName,Name+'Text','');
          if buf<>'' then TMenuItem(Form.Components[y]).Caption:=Buf;
        End
    End;
  ini.Free;
End;

procedure GetIni(Const Form:TCustomForm;Const FileName:string = '');
Var
   x:integer;
   CText:PChar;
   k:integer;
   ini:TIniFile;
   CName,CHint,FormName:string;
Begin
 if FileName='' then FormName:=IniPath
                else FormName:=FileName;
 ini:=TIniFile.Create(FormName);
 FormName:=Form.ClassName;
 ini.WriteString(FormName,FormName+'Caption',Form.Caption);
 k:=64535;
 for x:=0 to Form.ComponentCount-1 do
   Begin
     GetMem(CText,k);
     if Form.Components[x] is TControl then
       if not (TControl(Form.Components[x]) is TMemo) then
         Begin
           TControl(Form.Components[x]).GetTextBuf(CText,k);
           CName:=TControl(Form.Components[x]).Name;
           CHint:=TControl(Form.Components[x]).Hint;
           if Trim(CText)<>'' then
             ini.WriteString(FormName,CName+'Text',CText);
           if (TControl(Form.Components[x]).ShowHint)and(CHint<>'') then
             ini.WriteString(FormName,CName+'Hint',CHint);
           FreeMem(CText);
         End;
     if Form.Components[x] is TMenuItem then
       Begin
         CName:=TMenuItem(Form.Components[x]).Name;
         CHint:=TMenuItem(Form.Components[x]).Caption;
         if CHint<>'-' then
           ini.WriteString(FormName,CName+'Text',CHint);
       End;
   End;
 ini.Free;
End;

procedure IniLang(Const Form:TCustomForm;Const FileName:string = '');
Begin
 if Desigin then GetIni(Form,FileName)
            else SetLang(Form,FileName);
End;
end.
