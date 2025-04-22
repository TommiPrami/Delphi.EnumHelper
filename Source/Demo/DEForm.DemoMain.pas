unit DEForm.DemoMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TDEDemoMainForm = class(TForm)
    ButtonDemoThings: TButton;
    MemoLog: TMemo;
    procedure ButtonDemoThingsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DEDemoMainForm: TDEDemoMainForm;

implementation

uses
  Delphi.EnumHelper;

{$R *.dfm}

procedure TDEDemoMainForm.ButtonDemoThingsClick(Sender: TObject);
begin
  MemoLog.Lines.Add('TEnumHelper.EnumToString(Self.BorderSyle) = ' + TEnumHelper.EnumToString(BorderStyle));
  MemoLog.Lines.Add('TEnumHelper.EnumToString(Self.BorderSyle, True) = ' + TEnumHelper.EnumToString(BorderStyle, True));
  MemoLog.Lines.Add('TEnumHelper.EnumToInt(Self.BorderStyle) = ' + TEnumHelper.EnumToInt(BorderStyle).ToString);
  MemoLog.Lines.Add('TEnumHelper.EnumToInt(Self.BorderStyle) = ' + TEnumHelper.EnumToInt(BorderStyle).ToString);
  MemoLog.Lines.Add('TEnumHelper.NextValue(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.NextValue(BorderStyle)));
  MemoLog.Lines.Add('TEnumHelper.PreviousValue(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.PreviousValue(BorderStyle)));
  MemoLog.Lines.Add('TEnumHelper.Low(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.Low(BorderStyle)));
  MemoLog.Lines.Add('TEnumHelper.High(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.High(BorderStyle)));
  MemoLog.Lines.Add('TEnumHelper.HighAsInteger(Self.BorderStyle) = ' + TEnumHelper.LowAsInteger(BorderStyle).ToString);
  MemoLog.Lines.Add('TEnumHelper.LowAsInteger(Self.BorderStyle) = ' + TEnumHelper.HighAsInteger(BorderStyle).ToString);
end;

end.
