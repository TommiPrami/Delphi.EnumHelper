unit DEForm.DemoMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TDEDemoMainForm = class(TForm)
    ButtonAssignedValues: TButton;
    ButtonCycleAlignment: TButton;
    ButtonDemoThings: TButton;
    ButtonIntegerInRange: TButton;
    ButtonInvalidString: TButton;
    ButtonListValues: TButton;
    ButtonSaveAndLoadAsText: TButton;
    ComboBoxAlignment: TComboBox;
    LabelAlignment: TLabel;
    MemoLog: TMemo;
    procedure ButtonAssignedValuesClick(Sender: TObject);
    procedure ButtonCycleAlignmentClick(Sender: TObject);
    procedure ButtonDemoThingsClick(Sender: TObject);
    procedure ButtonIntegerInRangeClick(Sender: TObject);
    procedure ButtonInvalidStringClick(Sender: TObject);
    procedure ButtonListValuesClick(Sender: TObject);
    procedure ButtonSaveAndLoadAsTextClick(Sender: TObject);
    procedure ComboBoxAlignmentChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure LogEnumValues<T>(const AEnumValue: T; const ACaption: string);
    procedure SelectAlignmentInComboBox;
  public
    { Public declarations }
  end;

var
  DEDemoMainForm: TDEDemoMainForm;

implementation

uses
  Delphi.EnumHelper, System.UITypes;

{$R *.dfm}

type
  // Assigned values, and the first one negative: the compiler generates no RTTI for this type
  TEnumWithAssignedValues = (ewavFirst = -1, ewavSecond = 0, ewavThird = 1);

// Ord() works for an enumeration without RTTI, TEnumHelper needs RTTI and raises ENotSupportedException
procedure TDEDemoMainForm.ButtonAssignedValuesClick(Sender: TObject);
var
  LValue: TEnumWithAssignedValues;
begin
  for LValue := System.Low(TEnumWithAssignedValues) to System.High(TEnumWithAssignedValues) do
    MemoLog.Lines.Add('Ord(TEnumWithAssignedValues) = ' + IntToStr(Ord(LValue)));

  LValue := ewavFirst;

  try
    MemoLog.Lines.Add('TEnumHelper.EnumToInt(ewavFirst) = ' + TEnumHelper.EnumToInt(LValue).ToString);
  except
    on E: ENotSupportedException do
      MemoLog.Lines.Add('TEnumHelper.EnumToInt(ewavFirst) raised ' + E.ClassName + ': ' + E.Message);
  end;
end;

// NextValueWrap continues from Low after High, NextValue would stop at High
procedure TDEDemoMainForm.ButtonCycleAlignmentClick(Sender: TObject);
begin
  MemoLog.Alignment := TEnumHelper.NextValueWrap(MemoLog.Alignment);

  SelectAlignmentInComboBox;

  MemoLog.Lines.Add('MemoLog.Alignment = ' + TEnumHelper.EnumToString(MemoLog.Alignment));
end;

procedure TDEDemoMainForm.ButtonDemoThingsClick(Sender: TObject);
var
  LBorderstyleVariable: TFormBorderStyle;
begin
  MemoLog.Lines.Add('TEnumHelper.EnumToInt(Self.BorderStyle) = ' + TEnumHelper.EnumToInt(BorderStyle).ToString);
  MemoLog.Lines.Add('TEnumHelper.EnumToString(Self.BorderStyle) = ' + TEnumHelper.EnumToString(BorderStyle));
  MemoLog.Lines.Add('TEnumHelper.EnumToString(Self.BorderStyle, True) = ' + TEnumHelper.EnumToString(BorderStyle, True));
  MemoLog.Lines.Add('TEnumHelper.High(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.High(BorderStyle)));
  MemoLog.Lines.Add('TEnumHelper.HighAsInteger(Self.BorderStyle) = ' + TEnumHelper.HighAsInteger(BorderStyle).ToString);
  MemoLog.Lines.Add('TEnumHelper.IntegerInRange(Self.BorderStyle, 3) = ' + BoolToStr(TEnumHelper.IntegerInRange(BorderStyle, 3), True));
  MemoLog.Lines.Add('TEnumHelper.Low(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.Low(BorderStyle)));
  MemoLog.Lines.Add('TEnumHelper.LowAsInteger(Self.BorderStyle) = ' + TEnumHelper.LowAsInteger(BorderStyle).ToString);
  MemoLog.Lines.Add('TEnumHelper.NextValue(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.NextValue(BorderStyle)));
  MemoLog.Lines.Add('TEnumHelper.PreviousValue(Self.BorderStyle) = ' + TEnumHelper.EnumToString(TEnumHelper.PreviousValue(BorderStyle)));

  LBorderstyleVariable := bsNone;
  TEnumHelper.StringToEnum('bsSingle', LBorderstyleVariable);

  MemoLog.Lines.Add('TEnumHelper.StringToEnum(''bsSingle'', LBorderstyleVariable) = ' + TEnumHelper.EnumToString(LBorderstyleVariable));

  TEnumHelper.StringToEnum('ToolWindow', LBorderstyleVariable, True);

  MemoLog.Lines.Add('TEnumHelper.StringToEnum(''ToolWindow'', LBorderstyleVariable, True) = ' + TEnumHelper.EnumToString(LBorderstyleVariable));

  // Type level, no value of the type needed
  MemoLog.Lines.Add('TEnumHelper.Count<TFormBorderStyle> = ' + TEnumHelper.Count<TFormBorderStyle>.ToString);
  MemoLog.Lines.Add('TEnumHelper.High<TFormBorderStyle> = ' + TEnumHelper.EnumToString(TEnumHelper.High<TFormBorderStyle>));
  MemoLog.Lines.Add('TEnumHelper.Names<TFormBorderStyle>(True) = ' + string.Join(', ', TEnumHelper.Names<TFormBorderStyle>(True)));
  MemoLog.Lines.Add('TEnumHelper.IntegerToEnum<TFormBorderStyle>(3) = ' + TEnumHelper.EnumToString(TEnumHelper.IntegerToEnum<TFormBorderStyle>(3)));

  MemoLog.Lines.Add('TEnumHelper.IsValid(Self.BorderStyle) = ' + BoolToStr(TEnumHelper.IsValid(BorderStyle), True));
  MemoLog.Lines.Add('TEnumHelper.NextValueWrap(bsSizeToolWin) = ' + TEnumHelper.EnumToString(TEnumHelper.NextValueWrap(bsSizeToolWin)));
  MemoLog.Lines.Add('TEnumHelper.PreviousValueWrap(bsNone) = ' + TEnumHelper.EnumToString(TEnumHelper.PreviousValueWrap(bsNone)));

  MemoLog.Lines.Add('TEnumHelper.SetToString(MemoLog.Font.Style, True) = ' + TEnumHelper.SetToString(MemoLog.Font.Style, True));
end;

// Check an integer (from a database, ini file etc.) before casting it to the enumeration
procedure TDEDemoMainForm.ButtonIntegerInRangeClick(Sender: TObject);
var
  LStoredValue: Integer;
begin
  for LStoredValue := -1 to 7 do
    if TEnumHelper.IntegerInRange(BorderStyle, LStoredValue) then
      MemoLog.Lines.Add(Format('%d is valid TFormBorderStyle: %s', [LStoredValue,
        TEnumHelper.EnumToString(TFormBorderStyle(LStoredValue))]))
    else
      MemoLog.Lines.Add(Format('%d is not valid TFormBorderStyle', [LStoredValue]));
end;

// StringToEnum raises EArgumentException for a name that is not a value of the type, and leaves the variable as is
procedure TDEDemoMainForm.ButtonInvalidStringClick(Sender: TObject);
var
  LBorderStyle: TFormBorderStyle;
begin
  LBorderStyle := bsDialog;

  try
    TEnumHelper.StringToEnum('bsHuge', LBorderStyle);
  except
    on E: EArgumentException do
      MemoLog.Lines.Add(E.ClassName + ': ' + E.Message);
  end;

  MemoLog.Lines.Add('LBorderStyle is still ' + TEnumHelper.EnumToString(LBorderStyle));
end;

procedure TDEDemoMainForm.ButtonListValuesClick(Sender: TObject);
begin
  LogEnumValues(BorderStyle, 'TFormBorderStyle');
  LogEnumValues(MemoLog.Alignment, 'TAlignment');
  LogEnumValues(Position, 'TPosition');
end;

// Store enumerations and sets by name, not by ordinal, so reordering the type does not break saved settings.
// StringToEnumDef gives the default for a missing or broken setting, instead of an exception.
procedure TDEDemoMainForm.ButtonSaveAndLoadAsTextClick(Sender: TObject);
var
  LSettings: TStringList;
  LAlignment: TAlignment;
  LBorderStyle: TFormBorderStyle;
  LFontStyle: TFontStyles;
begin
  LSettings := TStringList.Create;
  try
    LSettings.Values['BorderStyle'] := TEnumHelper.EnumToString(BorderStyle);
    LSettings.Values['Alignment'] := TEnumHelper.EnumToString(MemoLog.Alignment);
    LSettings.Values['FontStyle'] := TEnumHelper.SetToString([fsBold, fsItalic]);
    LSettings.Values['Position'] := 'poNotAValue';

    MemoLog.Lines.Add('Saved settings:');
    MemoLog.Lines.AddStrings(LSettings);

    LBorderStyle := TEnumHelper.StringToEnumDef(LSettings.Values['BorderStyle'], bsNone);
    LAlignment := TEnumHelper.StringToEnumDef(LSettings.Values['Alignment'], taLeftJustify);
    LFontStyle := TEnumHelper.StringToSet<TFontStyles>(LSettings.Values['FontStyle']);

    MemoLog.Lines.Add('Loaded: BorderStyle = ' + TEnumHelper.EnumToString(LBorderStyle) + ', Alignment = '
      + TEnumHelper.EnumToString(LAlignment) + ', FontStyle = ' + TEnumHelper.SetToString(LFontStyle, True)
      + ', Position = ' + TEnumHelper.EnumToString(TEnumHelper.StringToEnumDef(LSettings.Values['Position'], poDefault))
      + ' (default, the saved value was broken)');
  finally
    LSettings.Free;
  end;
end;

// StringToEnumDef is a function, so unlike StringToEnum it can assign a property directly
procedure TDEDemoMainForm.ComboBoxAlignmentChange(Sender: TObject);
begin
  MemoLog.Alignment := TEnumHelper.StringToEnumDef(ComboBoxAlignment.Text, MemoLog.Alignment);
end;

// Fill the combo box from the enumeration itself, so it follows if values are added
procedure TDEDemoMainForm.FormCreate(Sender: TObject);
begin
  ComboBoxAlignment.Items.AddStrings(TEnumHelper.Names<TAlignment>);

  SelectAlignmentInComboBox;
end;

procedure TDEDemoMainForm.LogEnumValues<T>(const AEnumValue: T; const ACaption: string);
var
  LValue: T;
begin
  MemoLog.Lines.Add(Format('%s: %d values, current value %s', [ACaption, TEnumHelper.Count<T>,
    TEnumHelper.EnumToString(AEnumValue)]));

  for LValue in TEnumHelper.Values<T> do
    MemoLog.Lines.Add(Format('  %d = %s (%s)', [TEnumHelper.EnumToInt(LValue), TEnumHelper.EnumToString(LValue),
      TEnumHelper.EnumToString(LValue, True)]));
end;

procedure TDEDemoMainForm.SelectAlignmentInComboBox;
begin
  ComboBoxAlignment.ItemIndex := ComboBoxAlignment.Items.IndexOf(TEnumHelper.EnumToString(MemoLog.Alignment));
end;

end.
