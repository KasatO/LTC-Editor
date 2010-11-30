unit PAmultilang;

     ///////////////////////////////////////////
     //                                       //
     //   (C) 2003 PA                         //
     //                                       //
     //   ����       www.zldo.narod.ru        //
     //   �����      zldo@mail15.com          //
     //              pa@mw.narzan.com         //
     //                                       //
     ///////////////////////////////////////////

interface

Uses
    Forms, SysUtils, Classes, Controls, Menus, IniFiles, StdCtrls;
Var
   Desigin:boolean = false;
   ////////////////////////////////////////////////////////////////////
   //  ��� ���������� ����� ����� ������ ������                     //
   //  true - ����� ���������� - �������� ���� ����� ������          //
   //  false - ������� ����� - ���������� ��������� ����� � ������   //
   ////////////////////////////////////////////////////////////////////

   IniPath:string = 'D:\mlEx.lng';
   ////////////////////////////////////////////////////////////////////
   //  ��� ��������� ����� (�������� ���� ��� Desigin=true),         //
   //  ����� ��������� � � Run time ��� ����� �����                  //
   ////////////////////////////////////////////////////////////////////

   intLang:boolean = false;
   ////////////////////////////////////////////////////////////////////
   //  ���������� ������                                             //
   //  False - �������� ��������� �� �����������                     //
   //  True - ������ ��������                                        //
   ////////////////////////////////////////////////////////////////////

procedure IniLang(Const Form:TCustomForm;Const FileName:string = '');
////////////////////////////////////////////////////////////////////
//  ��� Desigin=False -                                           //
//  ��������� �������� ��������� � ����� Form �� ����� FileName   //
//                                                                //
//  ��� Desigin=True -                                            //
//  ���������� �������� ��������� ����� Form � ���� FileName      //
//                                                                //
//  ���� �������� FileName ������, ��� FileName='', ��            //
//  FileName ������������� �������� IniPath                       //
//                                                                //
//  ������ ������:                                                //
//  IniLang(TCustomForm(Self));                                   //
//  ��������� �������� ����� ���� ��������� � ���������� OnCreate //
//  ���� � ������� �� ������ ������� ��������� ���������� ������  //
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
