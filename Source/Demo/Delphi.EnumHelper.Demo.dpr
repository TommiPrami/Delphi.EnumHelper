program Delphi.EnumHelper.Demo;

uses
  Vcl.Forms,
  Delphi.EnumHelper in '..\Delphi.EnumHelper.pas',
  DEForm.DemoMain in 'Source\DEForm.DemoMain.pas' {DEDemoMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDEDemoMainForm, DEDemoMainForm);
  Application.Run;
end.
