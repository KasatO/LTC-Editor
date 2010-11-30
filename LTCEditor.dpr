program LTCEditor;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  About in 'About.pas' {frmAbout},
  SaveOnly in 'SaveOnly.pas' {frmSaveOnly},
  Lang in 'Lang.pas',
  PAmultilang in 'STEx\PAmultilang.pas',
  Search in 'Search.pas' {frmSearch},
  Genders in 'Genders.pas' {frmGenders},
  GenderCorrection in 'GenderCorrection.pas' {frmGenderCorrection};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'LTC Editor';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmSaveOnly, frmSaveOnly);
  Application.CreateForm(TfrmSearch, frmSearch);
  Application.CreateForm(TfrmGenders, frmGenders);
  Application.CreateForm(TfrmGenderCorrection, frmGenderCorrection);
  Application.Run;
end.
