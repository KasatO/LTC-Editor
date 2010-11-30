unit Lang;

interface

uses
  IniFiles;

procedure LoadGlobalLangSetting(Const FileName:string);

Var
 {Declaration start}
  Lng_LNGSaved:string;
  Lng_Changes:string;
  Lng_DifferentLangs:string;
  Lng_WrongUpdate:string;
  Lng_ChangesFound:string;
  Lng_SearchingChanges:string;
  Lng_Saved:string;
  Lng_Saving:string;
  Lng_Loaded:string;
  Lng_Opening:string;
  Lng_UnknownStrType:string;
  Lng_Calculating:string;
  Lng_UnknownFile:string;
  Lng_WrongWork:string;
  Lng_ChangedWork:string;
  Lng_FilterLEW:string;
  Lng_FilterLTC:string;
  Lng_FilterLTF:string;  
  Lng_SelectOne:string;
  Lng_ItemHint:string;
  Lng_Yes:string;
  Lng_No:string;
  Lng_WrongExt:string;
  Lng_MultiSelected:string;
  Lng_CannotOpen:string;
  Lng_NoSpellErrors:string;
  Lng_NoSpellSuggs:string;
  Lng_NotFound:string;
  Lng_ChecksumError:string;
  Lng_StrFound:string;
  Lng_StrNotFound:string;
  Lng_StrNotApplied:string;
  Lng_ChangesReport:string;
  Lng_Gender:string;
  Lng_BaseGender:string;
  Lng_EditGenderCaption:string;
  Lng_EditGender:string;

implementation

procedure LoadGlobalLangSetting(Const FileName:string);
Var
    ini:TIniFile;
Begin
  ini:=TInifile.Create(FileName);
 {Code start}
  Lng_LNGSaved:=ini.ReadString('Global','Lng_LNGSaved','���� ��� �������� ���������� ��������� ��������!');
  Lng_Changes:=ini.ReadString('Global','Lng_Changes','��������� - %d, ��������� - %d');
  Lng_DifferentLangs:=ini.ReadString('Global','Lng_DifferentLangs','�������� ����� ������������� ����� �� ��������� � ��������� ��� ������������.\n������� ���������� � ��� �� ���������� ��� �����?');
  Lng_WrongUpdate:=ini.ReadString('Global','Lng_WrongUpdate','��������� ���� ���� �� �������� �������� (�������� ������ FM 2006-2010).');
  Lng_ChangesFound:=ini.ReadString('Global','Lng_ChangesFound','�� ��������� ��������� � �����, �� �� ��������� ��.\n������ ������ �����������?');
  Lng_SearchingChanges:=ini.ReadString('Global','Lng_SearchingChanges','����� ���������...');
  Lng_Saved:=ini.ReadString('Global','Lng_Saved','���������');
  Lng_Saving:=ini.ReadString('Global','Lng_Saving','���������� �����, %d%%');
  Lng_Loaded:=ini.ReadString('Global','Lng_Loaded','���������');
  Lng_Opening:=ini.ReadString('Global','Lng_Opening','�������� �����, %d%%');
  Lng_UnknownStrType:=ini.ReadString('Global','Lng_UnknownStrType','����������� ��� ������: %d, �������: %d\n���������� ������ �����������!');
  Lng_Calculating:=ini.ReadString('Global','Lng_Calculating','������� �����...');
  Lng_UnknownFile:=ini.ReadString('Global','Lng_UnknownFile','��������� ���� ���� �� �������� �������� ������ FM 2006-2010, ���� �� �������������� ��� ������.');
  Lng_WrongWork:=ini.ReadString('Global','Lng_WrongWork','��������� ���� ���� �� �������� ������ ����������� ������ LTC Editor, ���� �� �������������� ��� ������.');
  Lng_ChangedWork:=ini.ReadString('Global','Lng_ChangedWork','������� ������ ���� �������� (������ ��� �����). ���� �� �������� ������ ������, �� ������ �������� ��������� ����� ���������.\n��� ����� ������ ������� ������ ������?');
  Lng_FilterLEW:=ini.ReadString('Global','Lng_FilterLEW','����� ����������� ����� (*.lew)|*.lew|��� ����� (*.*)|*.*');
  Lng_FilterLTC:=ini.ReadString('Global','Lng_FilterLTC','�������� ����� FM 2006-2010 (*.ltc)|*.ltc|��� ����� (*.*)|*.*');
  Lng_FilterLTF:=ini.ReadString('Global','Lng_FilterLTF','�������� ����� FM 2005 / FM 2006 beta / FM 2009 beta (*.ltf)|*.ltf|��� ����� (*.*)|*.*');
  Lng_SelectOne:=ini.ReadString('Global','Lng_SelectOne','��� ������� �������� ���������� ������� ������ ���� ������!');
  Lng_ItemHint:=ini.ReadString('Global','Lng_ItemHint','ID: %s, ��.: %s, ���: %s, ���.: %s, ���.: %s, ��.: %s, �� �����.: %s, ����.: %s');
  Lng_Yes:=ini.ReadString('Global','Lng_Yes','��');
  Lng_No:=ini.ReadString('Global','Lng_No','���');
  Lng_WrongExt:=ini.ReadString('Global','Lng_WrongExt','��������� ������������ ������ ����� �������� LTF � LTC.\n��� �������� �� �� ��������� ������, ��� ������ ����� ���������������� ����������.');
  Lng_MultiSelected:=ini.ReadString('Global','Lng_MultiSelected','������� ��������� �����...');
  Lng_CannotOpen:=ini.ReadString('Global','Lng_CannotOpen','�� ������� ������� ��������� ����. ��������, �� ����� ������ ����������� ��� �� ����������.');
  Lng_NoSpellErrors:=ini.ReadString('Global','Lng_NoSpellErrors','������ �� �������');
  Lng_NoSpellSuggs:=ini.ReadString('Global','Lng_NoSpellSuggs','��������� ������ �� �������');
  Lng_NotFound:=ini.ReadString('Global','Lng_NotFound','����� �� ��� �����������.');
  Lng_ChecksumError:=ini.ReadString('Global','Lng_ChecksumError','������ ����������� ����� � ������ %d.');
  Lng_StrFound:=ini.ReadString('Global','Lng_StrFound','<P><B>������ ���������</B><BR><I>%s<BR>%s<BR>%s</I></P>');
  Lng_StrNotFound:=ini.ReadString('Global','Lng_StrNotFound','<P><B>������ �� �������</B><BR><I>%s<BR>%s</I></P>');
  Lng_StrNotApplied:=ini.ReadString('Global','Lng_StrNotApplied','<P><B>������ �������, �� �� ���������</B><BR><I>%s<BR>%s<BR>%s</I></P>');
  Lng_ChangesReport:=ini.ReadString('Global','Lng_ChangesReport','<P><B>����� �����: <I>%d</I>, �������: <I>%d</I>, �� ��� ���������: <I>%d</I>, ���������������: <I>%d</I></B></P>');
  Lng_Gender:=ini.ReadString('Global','Lng_Gender','���������');
  Lng_BaseGender:=ini.ReadString('Global','Lng_BaseGender','������');
  Lng_EditGenderCaption:=ini.ReadString('Global','Lng_EditGenderCaption','�������������� ���������');
  Lng_EditGender:=ini.ReadString('Global','Lng_EditGender','������� ����� ���������:');

  ini.free;
End;

end.
 