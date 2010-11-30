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
  Lng_LNGSaved:=ini.ReadString('Global','Lng_LNGSaved','Файл для перевода интерфейса программы сохранен!');
  Lng_Changes:=ini.ReadString('Global','Lng_Changes','Применено - %d, пропущено - %d');
  Lng_DifferentLangs:=ini.ReadString('Global','Lng_DifferentLangs','Название языка подгружаемого файла не совпадает с названием уже загруженного.\nЖелаете продолжить и все же объединить эти файлы?');
  Lng_WrongUpdate:=ini.ReadString('Global','Lng_WrongUpdate','Выбранный Вами файл не является апдейтом (языковым файлом FM 2006-2010).');
  Lng_ChangesFound:=ini.ReadString('Global','Lng_ChangesFound','Вы проделали изменения в файле, но не сохранили их.\nЖелате сперва сохраниться?');
  Lng_SearchingChanges:=ini.ReadString('Global','Lng_SearchingChanges','Поиск изменений...');
  Lng_Saved:=ini.ReadString('Global','Lng_Saved','Сохранено');
  Lng_Saving:=ini.ReadString('Global','Lng_Saving','Сохранение файла, %d%%');
  Lng_Loaded:=ini.ReadString('Global','Lng_Loaded','Загружено');
  Lng_Opening:=ini.ReadString('Global','Lng_Opening','Открытие файла, %d%%');
  Lng_UnknownStrType:=ini.ReadString('Global','Lng_UnknownStrType','Неизвестный тип строки: %d, позиция: %d\nДальнейшая работа прерывается!');
  Lng_Calculating:=ini.ReadString('Global','Lng_Calculating','Подсчет строк...');
  Lng_UnknownFile:=ini.ReadString('Global','Lng_UnknownFile','Выбранный Вами файл не является языковым файлом FM 2006-2010, либо не поддерживается его версия.');
  Lng_WrongWork:=ini.ReadString('Global','Lng_WrongWork','Выбранный Вами файл не является файлом сохраненной работы LTC Editor, либо не поддерживается его версия.');
  Lng_ChangedWork:=ini.ReadString('Global','Lng_ChangedWork','Текущая работа была изменена (сейчас или ранее). Если Вы откроете другую работу, то можете потерять некоторые новые изменения.\nВсе равно хотите открыть другую работу?');
  Lng_FilterLEW:=ini.ReadString('Global','Lng_FilterLEW','Файлы сохраненных работ (*.lew)|*.lew|Все файлы (*.*)|*.*');
  Lng_FilterLTC:=ini.ReadString('Global','Lng_FilterLTC','Языковые файлы FM 2006-2010 (*.ltc)|*.ltc|Все файлы (*.*)|*.*');
  Lng_FilterLTF:=ini.ReadString('Global','Lng_FilterLTF','Языковые файлы FM 2005 / FM 2006 beta / FM 2009 beta (*.ltf)|*.ltf|Все файлы (*.*)|*.*');
  Lng_SelectOne:=ini.ReadString('Global','Lng_SelectOne','Для данного действия необходимо выбрать только одну запись!');
  Lng_ItemHint:=ini.ReadString('Global','Lng_ItemHint','ID: %s, сч.: %s, пол: %s, изм.: %s, доб.: %s, уд.: %s, не перев.: %s, ошиб.: %s');
  Lng_Yes:=ini.ReadString('Global','Lng_Yes','Да');
  Lng_No:=ini.ReadString('Global','Lng_No','Нет');
  Lng_WrongExt:=ini.ReadString('Global','Lng_WrongExt','Программа поддерживает только файлы форматов LTF и LTC.\nДля загрузки их из командной строки, они должны иметь соответстсвующие расширения.');
  Lng_MultiSelected:=ini.ReadString('Global','Lng_MultiSelected','Выбрано несколько строк...');
  Lng_CannotOpen:=ini.ReadString('Global','Lng_CannotOpen','Не удается открыть указанный файл. Возможно, он занят другим приложением или не существует.');
  Lng_NoSpellErrors:=ini.ReadString('Global','Lng_NoSpellErrors','Ошибок не найдено');
  Lng_NoSpellSuggs:=ini.ReadString('Global','Lng_NoSpellSuggs','Вариантов замены не найдено');
  Lng_NotFound:=ini.ReadString('Global','Lng_NotFound','Поиск не дал результатов.');
  Lng_ChecksumError:=ini.ReadString('Global','Lng_ChecksumError','Ошибка контрольной суммы в строке %d.');
  Lng_StrFound:=ini.ReadString('Global','Lng_StrFound','<P><B>Строка применена</B><BR><I>%s<BR>%s<BR>%s</I></P>');
  Lng_StrNotFound:=ini.ReadString('Global','Lng_StrNotFound','<P><B>Строка НЕ найдена</B><BR><I>%s<BR>%s</I></P>');
  Lng_StrNotApplied:=ini.ReadString('Global','Lng_StrNotApplied','<P><B>Строка найдена, но НЕ применена</B><BR><I>%s<BR>%s<BR>%s</I></P>');
  Lng_ChangesReport:=ini.ReadString('Global','Lng_ChangesReport','<P><B>Строк всего: <I>%d</I>, найдено: <I>%d</I>, из них применено: <I>%d</I>, проигнорировано: <I>%d</I></B></P>');
  Lng_Gender:=ini.ReadString('Global','Lng_Gender','Склонение');
  Lng_BaseGender:=ini.ReadString('Global','Lng_BaseGender','Основа');
  Lng_EditGenderCaption:=ini.ReadString('Global','Lng_EditGenderCaption','Редактирование склонения');
  Lng_EditGender:=ini.ReadString('Global','Lng_EditGender','Введите новое склонение:');

  ini.free;
End;

end.
 