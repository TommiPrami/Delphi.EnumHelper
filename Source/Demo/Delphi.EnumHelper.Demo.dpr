program Delphi.EnumHelper.Demo;

uses
  Vcl.Forms,
  DEForm.DemoMain in 'DEForm.DemoMain.pas' {DEDemoMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDEDemoMainForm, DEDemoMainForm);
  Application.Run;
end.
