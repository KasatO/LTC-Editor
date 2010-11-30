program Explorer;

uses
  Forms,
  ExMain in 'ExMain.pas' {ExMainForm},
  PAmultilang in 'PAmultilang.pas',
  Menu in 'Menu.pas' {MenuForm},
  AboutUnit in 'AboutUnit.pas' {About},
  Tools in 'Tools.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TExMainForm, ExMainForm);
  Application.Run;
end.
