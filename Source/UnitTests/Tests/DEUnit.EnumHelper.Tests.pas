unit DEUnit.EnumHelper.Tests;

interface

uses
  DUnitX.TestFramework, DEUnit.TestTypes;

type
  // Same calls the demo app makes, against the default TForm.BorderStyle (bsSizeable) held in a local variable
  [TestFixture]
  TEnumHelperDemoTests = class
  public
    [Test]
    procedure DemoEnumToInt;
    [Test]
    procedure DemoEnumToString;
    [Test]
    procedure DemoEnumToStringStripLowercasePrefix;
    [Test]
    procedure DemoHigh;
    [Test]
    procedure DemoHighAsInteger;
    [Test]
    procedure DemoIntegerInRange;
    [Test]
    procedure DemoLow;
    [Test]
    procedure DemoLowAsInteger;
    [Test]
    procedure DemoNextValue;
    [Test]
    procedure DemoPreviousValue;
    [Test]
    procedure DemoStringToEnum;
  end;

  [TestFixture]
  TEnumHelperEnumToIntTests = class
  public
    [Test]
    procedure AllValuesMatchOrd;
    [Test]
    procedure BooleanType;
    [Test]
    procedure ByteFullLastValue;
    [Test]
    procedure FourByteEnum;
    [Test]
    procedure ScopedEnum;
    [Test]
    procedure SubRange;
    [Test]
    procedure TestEnumSizes;
    [Test]
    procedure TwoByteEnum;
    [Test]
    procedure WordEnumAboveByteRange;
  end;

  [TestFixture]
  TEnumHelperEnumToStringTests = class
  public
    [Test]
    procedure AllValuesMatchGetEnumName;
    [Test]
    procedure BooleanType;
    [Test]
    procedure ByteFullLastValue;
    [Test]
    procedure DefaultDoesNotStripPrefix;
    [Test]
    procedure FourByteEnum;
    [Test]
    procedure ScopedEnum;
    [Test]
    procedure StripAllLowercaseName;
    [Test]
    procedure StripBoolean;
    [Test]
    procedure StripBorderStyles;
    [Test]
    procedure StripDigitsAfterPrefix;
    [Test]
    procedure StripNoPrefix;
    [Test]
    procedure StripScopedEnum;
    [Test]
    procedure StripSingleCharacterPrefix;
    [Test]
    procedure StripTypicalPrefix;
    [Test]
    procedure StripUnicodePrefix;
    [Test]
    procedure StripWordEnum;
    [Test]
    procedure SubRange;
    [Test]
    procedure UnicodeNames;
    [Test]
    procedure WordEnum;
  end;

  [TestFixture]
  TEnumHelperStringToEnumTests = class
  public
    [Test]
    procedure BaseTypeNameOutsideSubRangeRaises;
    [Test]
    procedure BooleanType;
    [Test]
    procedure ByteFullLastValue;
    [Test]
    procedure CaseInsensitive;
    [Test]
    procedure EmptyStringRaises;
    [Test]
    procedure FourByteEnum;
    [Test]
    procedure InvalidNameKeepsValue;
    [Test]
    [TestCase('Unknown name', 'NotAValue')]
    [TestCase('Name of another enum', 'bsSingle')]
    [TestCase('Wrong type qualifier', 'TTestScoped.tcRed')]
    [TestCase('Ordinal as text', '1')]
    [TestCase('Leading space', ' tcBlue')]
    [TestCase('Trailing space', 'tcBlue ')]
    procedure InvalidNameRaises(const AEnumString: string);
    [Test]
    procedure OverwritesPreviousValue;
    [Test]
    procedure QualifiedName;
    [Test]
    procedure RoundTripAllValues;
    [Test]
    procedure ScopedEnum;
    [Test]
    procedure StrippedNameRaises;
    [Test]
    procedure SubRange;
    [Test]
    procedure TwoByteEnum;
    [Test]
    procedure UnicodeNames;
    [Test]
    procedure WordEnumAboveByteRange;
  end;

  [TestFixture]
  TEnumHelperHighLowTests = class
  public
    [Test]
    procedure BooleanType;
    [Test]
    procedure BorderStyle;
    [Test]
    procedure BorderStyleSubRange;
    [Test]
    procedure ByteFull;
    [Test]
    procedure FourByteEnum;
    [Test]
    procedure IndependentOfArgumentValue;
    [Test]
    procedure MatchesSystemHighLow;
    [Test]
    procedure ScopedEnum;
    [Test]
    procedure SingleValue;
    [Test]
    procedure SubRange;
    [Test]
    procedure WordEnum;
  end;

  [TestFixture]
  TEnumHelperNextPreviousTests = class
  public
    [Test]
    procedure BooleanType;
    [Test]
    procedure ByteFullUpperBound;
    [Test]
    procedure FourByteEnum;
    [Test]
    procedure NextAtHighStays;
    [Test]
    procedure NextBelowSubRangeClampsToLow;
    [Test]
    procedure NextInMiddle;
    [Test]
    procedure NextOutOfRangeClampsToHigh;
    [Test]
    procedure PreviousAtLowStays;
    [Test]
    procedure PreviousBelowSubRangeClampsToLow;
    [Test]
    procedure PreviousInMiddle;
    [Test]
    procedure PreviousOutOfRangeClampsToHigh;
    [Test]
    procedure ScopedEnum;
    [Test]
    procedure SingleValue;
    [Test]
    procedure SubRangeStaysInsideSubRange;
    [Test]
    procedure WalkBackwardVisitsAllValues;
    [Test]
    procedure WalkForwardVisitsAllValues;
    [Test]
    procedure WordEnumCrossesByteBoundary;
  end;

  [TestFixture]
  TEnumHelperIntegerInRangeTests = class
  public
    [Test]
    procedure BooleanType;
    [Test]
    [TestCase('Below low', '-1,False')]
    [TestCase('Low', '0,True')]
    [TestCase('Middle', '2,True')]
    [TestCase('High', '4,True')]
    [TestCase('Above high', '5,False')]
    [TestCase('Byte max', '255,False')]
    [TestCase('MaxInt', '2147483647,False')]
    [TestCase('MinInt', '-2147483648,False')]
    procedure Color(const AValue: Integer; const AExpected: Boolean);
    [Test]
    procedure IndependentOfArgumentValue;
    [Test]
    procedure SingleValue;
    [Test]
    [TestCase('Below subrange', '0,False')]
    [TestCase('Subrange low', '1,True')]
    [TestCase('Subrange high', '3,True')]
    [TestCase('Above subrange', '4,False')]
    procedure SubRange(const AValue: Integer; const AExpected: Boolean);
    [Test]
    procedure WordEnum;
  end;

  // TEnumHelper used with enumeration properties of an object, as example code
  [TestFixture]
  TEnumHelperPropertyTests = class
  strict private
    FWindow: TTestWindow;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CycleAroundAllValues;
    [Test]
    procedure DefaultValues;
    [Test]
    procedure EnumToStringMatchesPublishedPropertyRtti;
    [Test]
    procedure HighAndLowAssignedToProperty;
    [Test]
    procedure IntegerInRangeGuardsCastToProperty;
    [Test]
    procedure NextValueAssignedToProperty;
    [Test]
    procedure PreviousValueAssignedToProperty;
    [Test]
    procedure PropertiesAreIndependent;
    [Test]
    procedure StringToEnumInvalidKeepsProperty;
    [Test]
    procedure StringToEnumThroughLocalVariable;
  end;

{$IF DEFINED(DEBUG)}
  {$IFOPT C+}
  // TEnumHelper asserts that T is an enumeration only in DEBUG builds with assertions on
  [TestFixture]
  TEnumHelperSanityCheckTests = class
  public
    [Test]
    procedure EnumToIntRejectsInteger;
    [Test]
    procedure EnumToStringRejectsInteger;
    [Test]
    procedure EnumToStringRejectsString;
    [Test]
    procedure HighAsIntegerRejectsInteger;
    [Test]
    procedure HighRejectsInteger;
    [Test]
    procedure IntegerInRangeRejectsInteger;
    [Test]
    procedure LowAsIntegerRejectsInteger;
    [Test]
    procedure LowRejectsInteger;
    [Test]
    procedure NextValueRejectsInteger;
    [Test]
    procedure PreviousValueRejectsInteger;
    [Test]
    procedure StringToEnumRejectsInteger;
  end;
  {$ENDIF}
{$ENDIF}

implementation

uses
  System.Rtti, System.SysUtils, System.TypInfo, Delphi.EnumHelper;

type
  // Generic checks run against every test enumeration
  TEnumChecks = class
  public
    class function FromOrdinal<T>(const AOrdinal: Integer): T;
    class procedure CheckAllValuesMatchGetEnumName<T>;
    class procedure CheckAllValuesMatchOrd<T>;
    class procedure CheckHighLowMatchTypeData<T>;
    class procedure CheckRoundTripAllValues<T>;
    class procedure CheckWalkBackward<T>;
    class procedure CheckWalkForward<T>;
  end;

class function TEnumChecks.FromOrdinal<T>(const AOrdinal: Integer): T;
begin
  Result := TValue.FromOrdinal(TypeInfo(T), AOrdinal).AsType<T>;
end;

class procedure TEnumChecks.CheckAllValuesMatchGetEnumName<T>;
var
  LLow: Integer;
  LHigh: Integer;
  LOrdinal: Integer;
begin
  LLow := GetTypeData(TypeInfo(T)).MinValue;
  LHigh := GetTypeData(TypeInfo(T)).MaxValue;

  for LOrdinal := LLow to LHigh do
    Assert.AreEqual(GetEnumName(TypeInfo(T), LOrdinal), TEnumHelper.EnumToString<T>(FromOrdinal<T>(LOrdinal)));
end;

class procedure TEnumChecks.CheckAllValuesMatchOrd<T>;
var
  LLow: Integer;
  LHigh: Integer;
  LOrdinal: Integer;
begin
  LLow := GetTypeData(TypeInfo(T)).MinValue;
  LHigh := GetTypeData(TypeInfo(T)).MaxValue;

  for LOrdinal := LLow to LHigh do
    Assert.AreEqual(LOrdinal, TEnumHelper.EnumToInt<T>(FromOrdinal<T>(LOrdinal)));
end;

class procedure TEnumChecks.CheckHighLowMatchTypeData<T>;
var
  LLow: Integer;
  LHigh: Integer;
  LValue: T;
begin
  LLow := GetTypeData(TypeInfo(T)).MinValue;
  LHigh := GetTypeData(TypeInfo(T)).MaxValue;
  LValue := FromOrdinal<T>(LLow);

  Assert.AreEqual(LHigh, TEnumHelper.HighAsInteger<T>(LValue));
  Assert.AreEqual(LLow, TEnumHelper.LowAsInteger<T>(LValue));
  Assert.AreEqual(LHigh, TEnumHelper.EnumToInt<T>(TEnumHelper.High<T>(LValue)));
  Assert.AreEqual(LLow, TEnumHelper.EnumToInt<T>(TEnumHelper.Low<T>(LValue)));
end;

class procedure TEnumChecks.CheckRoundTripAllValues<T>;
var
  LLow: Integer;
  LHigh: Integer;
  LOrdinal: Integer;
  LValue: T;
begin
  LLow := GetTypeData(TypeInfo(T)).MinValue;
  LHigh := GetTypeData(TypeInfo(T)).MaxValue;

  for LOrdinal := LLow to LHigh do
  begin
    LValue := Default(T);

    TEnumHelper.StringToEnum<T>(TEnumHelper.EnumToString<T>(FromOrdinal<T>(LOrdinal)), LValue);

    Assert.AreEqual(LOrdinal, TEnumHelper.EnumToInt<T>(LValue));
  end;
end;

class procedure TEnumChecks.CheckWalkBackward<T>;
var
  LLow: Integer;
  LHigh: Integer;
  LOrdinal: Integer;
  LValue: T;
begin
  LLow := GetTypeData(TypeInfo(T)).MinValue;
  LHigh := GetTypeData(TypeInfo(T)).MaxValue;
  LValue := FromOrdinal<T>(LHigh);

  for LOrdinal := LHigh downto LLow do
  begin
    Assert.AreEqual(LOrdinal, TEnumHelper.EnumToInt<T>(LValue));

    LValue := TEnumHelper.PreviousValue<T>(LValue);
  end;

  Assert.AreEqual(LLow, TEnumHelper.EnumToInt<T>(LValue));
end;

class procedure TEnumChecks.CheckWalkForward<T>;
var
  LLow: Integer;
  LHigh: Integer;
  LOrdinal: Integer;
  LValue: T;
begin
  LLow := GetTypeData(TypeInfo(T)).MinValue;
  LHigh := GetTypeData(TypeInfo(T)).MaxValue;
  LValue := FromOrdinal<T>(LLow);

  for LOrdinal := LLow to LHigh do
  begin
    Assert.AreEqual(LOrdinal, TEnumHelper.EnumToInt<T>(LValue));

    LValue := TEnumHelper.NextValue<T>(LValue);
  end;

  Assert.AreEqual(LHigh, TEnumHelper.EnumToInt<T>(LValue));
end;

{ TEnumHelperDemoTests }

procedure TEnumHelperDemoTests.DemoEnumToInt;
var
  LBorderStyle: TTestBorderStyle;
begin
  LBorderStyle := bsSizeable;

  Assert.AreEqual(Integer(Ord(bsSizeable)), TEnumHelper.EnumToInt(LBorderStyle));
  Assert.AreEqual(2, TEnumHelper.EnumToInt(LBorderStyle));
end;

procedure TEnumHelperDemoTests.DemoEnumToString;
begin
  Assert.AreEqual('bsSizeable', TEnumHelper.EnumToString(bsSizeable));
end;

procedure TEnumHelperDemoTests.DemoEnumToStringStripLowercasePrefix;
begin
  Assert.AreEqual('Sizeable', TEnumHelper.EnumToString(bsSizeable, True));
end;

procedure TEnumHelperDemoTests.DemoHigh;
begin
  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, TEnumHelper.High(bsSizeable));
  Assert.AreEqual('bsSizeToolWin', TEnumHelper.EnumToString(TEnumHelper.High(bsSizeable)));
end;

procedure TEnumHelperDemoTests.DemoHighAsInteger;
begin
  Assert.AreEqual(Integer(Ord(System.High(TTestBorderStyle))), TEnumHelper.HighAsInteger(bsSizeable));
  Assert.AreEqual(5, TEnumHelper.HighAsInteger(bsSizeable));
end;

procedure TEnumHelperDemoTests.DemoIntegerInRange;
begin
  Assert.IsTrue(TEnumHelper.IntegerInRange(bsSizeable, 3));
end;

procedure TEnumHelperDemoTests.DemoLow;
begin
  Assert.AreEqual<TTestBorderStyle>(bsNone, TEnumHelper.Low(bsSizeable));
  Assert.AreEqual('bsNone', TEnumHelper.EnumToString(TEnumHelper.Low(bsSizeable)));
end;

procedure TEnumHelperDemoTests.DemoLowAsInteger;
begin
  Assert.AreEqual(Integer(Ord(System.Low(TTestBorderStyle))), TEnumHelper.LowAsInteger(bsSizeable));
  Assert.AreEqual(0, TEnumHelper.LowAsInteger(bsSizeable));
end;

procedure TEnumHelperDemoTests.DemoNextValue;
begin
  Assert.AreEqual<TTestBorderStyle>(bsDialog, TEnumHelper.NextValue(bsSizeable));
end;

procedure TEnumHelperDemoTests.DemoPreviousValue;
begin
  Assert.AreEqual<TTestBorderStyle>(bsSingle, TEnumHelper.PreviousValue(bsSizeable));
end;

procedure TEnumHelperDemoTests.DemoStringToEnum;
var
  LBorderstyleVariable: TTestBorderStyle;
begin
  LBorderstyleVariable := bsNone;

  TEnumHelper.StringToEnum('bsSingle', LBorderstyleVariable);

  Assert.AreEqual<TTestBorderStyle>(bsSingle, LBorderstyleVariable);
end;

{ TEnumHelperEnumToIntTests }

procedure TEnumHelperEnumToIntTests.AllValuesMatchOrd;
begin
  TEnumChecks.CheckAllValuesMatchOrd<TTestColor>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestColorSubRange>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestSingle>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestNoPrefix>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestScoped>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestTwoBytes>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestFourBytes>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestByteFull>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestWord>;
  TEnumChecks.CheckAllValuesMatchOrd<TTestBorderStyle>;
  TEnumChecks.CheckAllValuesMatchOrd<Boolean>;
end;

procedure TEnumHelperEnumToIntTests.BooleanType;
begin
  Assert.AreEqual(0, TEnumHelper.EnumToInt(False));
  Assert.AreEqual(1, TEnumHelper.EnumToInt(True));
end;

procedure TEnumHelperEnumToIntTests.ByteFullLastValue;
begin
  Assert.AreEqual(254, TEnumHelper.EnumToInt(e254));
  Assert.AreEqual(255, TEnumHelper.EnumToInt(e255));
end;

procedure TEnumHelperEnumToIntTests.FourByteEnum;
begin
  Assert.AreEqual(0, TEnumHelper.EnumToInt(fbZero));
  Assert.AreEqual(3, TEnumHelper.EnumToInt(fbThree));
end;

procedure TEnumHelperEnumToIntTests.ScopedEnum;
begin
  Assert.AreEqual(0, TEnumHelper.EnumToInt(TTestScoped.First));
  Assert.AreEqual(2, TEnumHelper.EnumToInt(TTestScoped.Third));
end;

procedure TEnumHelperEnumToIntTests.SubRange;
var
  LValue: TTestColorSubRange;
begin
  LValue := tcGreen;
  Assert.AreEqual(1, TEnumHelper.EnumToInt<TTestColorSubRange>(LValue));

  LValue := tcYellow;
  Assert.AreEqual(3, TEnumHelper.EnumToInt<TTestColorSubRange>(LValue));
end;

// Guards the premises of the size related tests
procedure TEnumHelperEnumToIntTests.TestEnumSizes;
begin
  Assert.AreEqual(1, Integer(SizeOf(TTestColor)));
  Assert.AreEqual(1, Integer(SizeOf(TTestByteFull)));
  Assert.AreEqual(2, Integer(SizeOf(TTestTwoBytes)));
  Assert.AreEqual(2, Integer(SizeOf(TTestWord)));
  Assert.AreEqual(4, Integer(SizeOf(TTestFourBytes)));
end;

procedure TEnumHelperEnumToIntTests.TwoByteEnum;
begin
  Assert.AreEqual(0, TEnumHelper.EnumToInt(tbZero));
  Assert.AreEqual(2, TEnumHelper.EnumToInt(tbTwo));
end;

procedure TEnumHelperEnumToIntTests.WordEnumAboveByteRange;
begin
  Assert.AreEqual(255, TEnumHelper.EnumToInt(w255));
  Assert.AreEqual(256, TEnumHelper.EnumToInt(w256));
  Assert.AreEqual(299, TEnumHelper.EnumToInt(w299));
end;

{ TEnumHelperEnumToStringTests }

procedure TEnumHelperEnumToStringTests.AllValuesMatchGetEnumName;
begin
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestColor>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestColorSubRange>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestSingle>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestNoPrefix>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestAllLowercase>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestDigits>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestUnicode>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestScoped>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestTwoBytes>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestFourBytes>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestByteFull>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestWord>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<TTestBorderStyle>;
  TEnumChecks.CheckAllValuesMatchGetEnumName<Boolean>;
end;

procedure TEnumHelperEnumToStringTests.BooleanType;
begin
  Assert.AreEqual('False', TEnumHelper.EnumToString(False));
  Assert.AreEqual('True', TEnumHelper.EnumToString(True));
end;

procedure TEnumHelperEnumToStringTests.ByteFullLastValue;
begin
  Assert.AreEqual('e255', TEnumHelper.EnumToString(e255));
end;

procedure TEnumHelperEnumToStringTests.DefaultDoesNotStripPrefix;
begin
  Assert.AreEqual('tcRed', TEnumHelper.EnumToString(tcRed));
  Assert.AreEqual('tcRed', TEnumHelper.EnumToString(tcRed, False));
end;

procedure TEnumHelperEnumToStringTests.FourByteEnum;
begin
  Assert.AreEqual('fbThree', TEnumHelper.EnumToString(fbThree));
  Assert.AreEqual('Three', TEnumHelper.EnumToString(fbThree, True));
end;

procedure TEnumHelperEnumToStringTests.ScopedEnum;
begin
  Assert.AreEqual('Second', TEnumHelper.EnumToString(TTestScoped.Second));
end;

// Nothing uppercase to stop at: there is no prefix, so the name is returned as is
procedure TEnumHelperEnumToStringTests.StripAllLowercaseName;
begin
  Assert.AreEqual('lowerone', TEnumHelper.EnumToString(lowerone, True));
  Assert.AreEqual('lowertwo', TEnumHelper.EnumToString(lowertwo, True));
end;

procedure TEnumHelperEnumToStringTests.StripBoolean;
begin
  Assert.AreEqual('False', TEnumHelper.EnumToString(False, True));
  Assert.AreEqual('True', TEnumHelper.EnumToString(True, True));
end;

procedure TEnumHelperEnumToStringTests.StripBorderStyles;
begin
  Assert.AreEqual('None', TEnumHelper.EnumToString(bsNone, True));
  Assert.AreEqual('Single', TEnumHelper.EnumToString(bsSingle, True));
  Assert.AreEqual('Sizeable', TEnumHelper.EnumToString(bsSizeable, True));
  Assert.AreEqual('Dialog', TEnumHelper.EnumToString(bsDialog, True));
  Assert.AreEqual('ToolWindow', TEnumHelper.EnumToString(bsToolWindow, True));
  Assert.AreEqual('SizeToolWin', TEnumHelper.EnumToString(bsSizeToolWin, True));
end;

procedure TEnumHelperEnumToStringTests.StripDigitsAfterPrefix;
begin
  Assert.AreEqual('1Value', TEnumHelper.EnumToString(x1Value, True));
  Assert.AreEqual('123', TEnumHelper.EnumToString(abc123, True));
  Assert.AreEqual('9', TEnumHelper.EnumToString(n9, True));
end;

procedure TEnumHelperEnumToStringTests.StripNoPrefix;
begin
  Assert.AreEqual('Alpha', TEnumHelper.EnumToString(Alpha, True));
  Assert.AreEqual('Beta', TEnumHelper.EnumToString(Beta, True));
  Assert.AreEqual('Gamma', TEnumHelper.EnumToString(Gamma, True));
end;

procedure TEnumHelperEnumToStringTests.StripScopedEnum;
begin
  Assert.AreEqual('Third', TEnumHelper.EnumToString(TTestScoped.Third, True));
end;

procedure TEnumHelperEnumToStringTests.StripSingleCharacterPrefix;
begin
  Assert.AreEqual('Only', TEnumHelper.EnumToString(tsOnly, True));
end;

procedure TEnumHelperEnumToStringTests.StripTypicalPrefix;
begin
  Assert.AreEqual('Red', TEnumHelper.EnumToString(tcRed, True));
  Assert.AreEqual('Green', TEnumHelper.EnumToString(tcGreen, True));
  Assert.AreEqual('Blue', TEnumHelper.EnumToString(tcBlue, True));
  Assert.AreEqual('Yellow', TEnumHelper.EnumToString(tcYellow, True));
  Assert.AreEqual('Black', TEnumHelper.EnumToString(tcBlack, True));
end;

procedure TEnumHelperEnumToStringTests.StripUnicodePrefix;
begin
  Assert.AreEqual('Äiti', TEnumHelper.EnumToString(äÄiti, True));
  Assert.AreEqual('Öljy', TEnumHelper.EnumToString(öÖljy, True));
  Assert.AreEqual('Å', TEnumHelper.EnumToString(ålandÅ, True));
end;

procedure TEnumHelperEnumToStringTests.StripWordEnum;
begin
  Assert.AreEqual('000', TEnumHelper.EnumToString(w000, True));
  Assert.AreEqual('299', TEnumHelper.EnumToString(w299, True));
end;

procedure TEnumHelperEnumToStringTests.SubRange;
var
  LValue: TTestColorSubRange;
begin
  LValue := tcBlue;

  Assert.AreEqual('tcBlue', TEnumHelper.EnumToString<TTestColorSubRange>(LValue));
  Assert.AreEqual('Blue', TEnumHelper.EnumToString<TTestColorSubRange>(LValue, True));
end;

procedure TEnumHelperEnumToStringTests.UnicodeNames;
begin
  Assert.AreEqual('äÄiti', TEnumHelper.EnumToString(äÄiti));
  Assert.AreEqual('öÖljy', TEnumHelper.EnumToString(öÖljy));
  Assert.AreEqual('ålandÅ', TEnumHelper.EnumToString(ålandÅ));
end;

procedure TEnumHelperEnumToStringTests.WordEnum;
begin
  Assert.AreEqual('w256', TEnumHelper.EnumToString(w256));
  Assert.AreEqual('w299', TEnumHelper.EnumToString(w299));
end;

{ TEnumHelperStringToEnumTests }

// GetEnumValue finds tcRed from the base type, but it is not a value of the subrange
procedure TEnumHelperStringToEnumTests.BaseTypeNameOutsideSubRangeRaises;
var
  LValue: TTestColorSubRange;
begin
  LValue := tcGreen;

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.StringToEnum<TTestColorSubRange>('tcRed', LValue);
    end,
    EArgumentException);

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.StringToEnum<TTestColorSubRange>('tcBlack', LValue);
    end,
    EArgumentException);

  Assert.AreEqual<TTestColorSubRange>(tcGreen, LValue);
end;

procedure TEnumHelperStringToEnumTests.BooleanType;
var
  LValue: Boolean;
begin
  LValue := False;
  TEnumHelper.StringToEnum('True', LValue);
  Assert.IsTrue(LValue);

  TEnumHelper.StringToEnum('False', LValue);
  Assert.IsFalse(LValue);
end;

procedure TEnumHelperStringToEnumTests.ByteFullLastValue;
var
  LValue: TTestByteFull;
begin
  LValue := e000;

  TEnumHelper.StringToEnum('e255', LValue);

  Assert.AreEqual<TTestByteFull>(e255, LValue);
end;

procedure TEnumHelperStringToEnumTests.CaseInsensitive;
var
  LValue: TTestColor;
begin
  LValue := tcRed;
  TEnumHelper.StringToEnum('TCBLUE', LValue);
  Assert.AreEqual<TTestColor>(tcBlue, LValue);

  TEnumHelper.StringToEnum('tcyellow', LValue);
  Assert.AreEqual<TTestColor>(tcYellow, LValue);
end;

procedure TEnumHelperStringToEnumTests.EmptyStringRaises;
var
  LValue: TTestColor;
begin
  LValue := tcRed;

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.StringToEnum('', LValue);
    end,
    EArgumentException);
end;

procedure TEnumHelperStringToEnumTests.FourByteEnum;
var
  LValue: TTestFourBytes;
begin
  LValue := fbZero;

  TEnumHelper.StringToEnum('fbThree', LValue);

  Assert.AreEqual<TTestFourBytes>(fbThree, LValue);
end;

procedure TEnumHelperStringToEnumTests.InvalidNameKeepsValue;
var
  LByteValue: TTestColor;
  LFourByteValue: TTestFourBytes;
  LWordValue: TTestWord;
begin
  LByteValue := tcYellow;
  LFourByteValue := fbTwo;
  LWordValue := w257;

  try
    TEnumHelper.StringToEnum('NotAValue', LByteValue);
  except
    on EArgumentException do;
  end;

  try
    TEnumHelper.StringToEnum('NotAValue', LFourByteValue);
  except
    on EArgumentException do;
  end;

  try
    TEnumHelper.StringToEnum('NotAValue', LWordValue);
  except
    on EArgumentException do;
  end;

  Assert.AreEqual<TTestColor>(tcYellow, LByteValue);
  Assert.AreEqual<TTestFourBytes>(fbTwo, LFourByteValue);
  Assert.AreEqual<TTestWord>(w257, LWordValue);
end;

procedure TEnumHelperStringToEnumTests.InvalidNameRaises(const AEnumString: string);
var
  LValue: TTestColor;
begin
  LValue := tcRed;

  Assert.WillRaiseWithMessage(
    procedure
    begin
      TEnumHelper.StringToEnum(AEnumString, LValue);
    end,
    EArgumentException,
    '"' + AEnumString + '" is not a valid value of TTestColor');
end;

procedure TEnumHelperStringToEnumTests.OverwritesPreviousValue;
var
  LValue: TTestColor;
begin
  LValue := tcBlack;

  TEnumHelper.StringToEnum('tcRed', LValue);

  Assert.AreEqual<TTestColor>(tcRed, LValue);
end;

procedure TEnumHelperStringToEnumTests.QualifiedName;
var
  LValue: TTestScoped;
begin
  LValue := TTestScoped.First;

  TEnumHelper.StringToEnum('TTestScoped.Third', LValue);

  Assert.AreEqual<TTestScoped>(TTestScoped.Third, LValue);
end;

procedure TEnumHelperStringToEnumTests.RoundTripAllValues;
begin
  TEnumChecks.CheckRoundTripAllValues<TTestColor>;
  TEnumChecks.CheckRoundTripAllValues<TTestColorSubRange>;
  TEnumChecks.CheckRoundTripAllValues<TTestSingle>;
  TEnumChecks.CheckRoundTripAllValues<TTestNoPrefix>;
  TEnumChecks.CheckRoundTripAllValues<TTestAllLowercase>;
  TEnumChecks.CheckRoundTripAllValues<TTestDigits>;
  TEnumChecks.CheckRoundTripAllValues<TTestUnicode>;
  TEnumChecks.CheckRoundTripAllValues<TTestScoped>;
  TEnumChecks.CheckRoundTripAllValues<TTestTwoBytes>;
  TEnumChecks.CheckRoundTripAllValues<TTestFourBytes>;
  TEnumChecks.CheckRoundTripAllValues<TTestByteFull>;
  TEnumChecks.CheckRoundTripAllValues<TTestWord>;
  TEnumChecks.CheckRoundTripAllValues<TTestBorderStyle>;
  TEnumChecks.CheckRoundTripAllValues<Boolean>;
end;

procedure TEnumHelperStringToEnumTests.ScopedEnum;
var
  LValue: TTestScoped;
begin
  LValue := TTestScoped.First;

  TEnumHelper.StringToEnum('Second', LValue);

  Assert.AreEqual<TTestScoped>(TTestScoped.Second, LValue);
end;

// EnumToString(..., True) output is for display only, it does not convert back
procedure TEnumHelperStringToEnumTests.StrippedNameRaises;
var
  LValue: TTestColor;
begin
  LValue := tcRed;

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.StringToEnum(TEnumHelper.EnumToString(tcBlue, True), LValue);
    end,
    EArgumentException);
end;

procedure TEnumHelperStringToEnumTests.SubRange;
var
  LValue: TTestColorSubRange;
begin
  LValue := tcGreen;

  TEnumHelper.StringToEnum<TTestColorSubRange>('tcYellow', LValue);

  Assert.AreEqual<TTestColorSubRange>(tcYellow, LValue);
end;

procedure TEnumHelperStringToEnumTests.TwoByteEnum;
var
  LValue: TTestTwoBytes;
begin
  LValue := tbZero;

  TEnumHelper.StringToEnum('tbTwo', LValue);

  Assert.AreEqual<TTestTwoBytes>(tbTwo, LValue);
end;

procedure TEnumHelperStringToEnumTests.UnicodeNames;
var
  LValue: TTestUnicode;
begin
  LValue := äÄiti;

  TEnumHelper.StringToEnum('öÖljy', LValue);

  Assert.AreEqual<TTestUnicode>(öÖljy, LValue);
end;

procedure TEnumHelperStringToEnumTests.WordEnumAboveByteRange;
var
  LValue: TTestWord;
begin
  LValue := w000;
  TEnumHelper.StringToEnum('w256', LValue);
  Assert.AreEqual<TTestWord>(w256, LValue);

  TEnumHelper.StringToEnum('w299', LValue);
  Assert.AreEqual<TTestWord>(w299, LValue);
end;

{ TEnumHelperHighLowTests }

procedure TEnumHelperHighLowTests.BooleanType;
begin
  Assert.AreEqual<Boolean>(True, TEnumHelper.High(False));
  Assert.AreEqual<Boolean>(False, TEnumHelper.Low(True));
  Assert.AreEqual(1, TEnumHelper.HighAsInteger(False));
  Assert.AreEqual(0, TEnumHelper.LowAsInteger(True));
end;

procedure TEnumHelperHighLowTests.BorderStyle;
begin
  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, TEnumHelper.High(bsDialog));
  Assert.AreEqual<TTestBorderStyle>(bsNone, TEnumHelper.Low(bsDialog));
end;

// Same subrange as TBorderStyle = bsNone..bsSingle in Vcl.Forms
procedure TEnumHelperHighLowTests.BorderStyleSubRange;
var
  LValue: TTestBorderStyleSubRange;
begin
  LValue := bsNone;

  Assert.AreEqual<TTestBorderStyleSubRange>(bsSingle, TEnumHelper.High<TTestBorderStyleSubRange>(LValue));
  Assert.AreEqual<TTestBorderStyleSubRange>(bsNone, TEnumHelper.Low<TTestBorderStyleSubRange>(LValue));
  Assert.AreEqual(1, TEnumHelper.HighAsInteger<TTestBorderStyleSubRange>(LValue));
end;

procedure TEnumHelperHighLowTests.ByteFull;
begin
  Assert.AreEqual<TTestByteFull>(e255, TEnumHelper.High(e100));
  Assert.AreEqual<TTestByteFull>(e000, TEnumHelper.Low(e100));
  Assert.AreEqual(255, TEnumHelper.HighAsInteger(e100));
  Assert.AreEqual(0, TEnumHelper.LowAsInteger(e100));
end;

procedure TEnumHelperHighLowTests.FourByteEnum;
begin
  Assert.AreEqual<TTestFourBytes>(fbThree, TEnumHelper.High(fbOne));
  Assert.AreEqual<TTestFourBytes>(fbZero, TEnumHelper.Low(fbOne));
  Assert.AreEqual(3, TEnumHelper.HighAsInteger(fbOne));
  Assert.AreEqual(0, TEnumHelper.LowAsInteger(fbOne));
end;

procedure TEnumHelperHighLowTests.IndependentOfArgumentValue;
var
  LValue: TTestColor;
begin
  for LValue := System.Low(TTestColor) to System.High(TTestColor) do
  begin
    Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.High(LValue));
    Assert.AreEqual<TTestColor>(tcRed, TEnumHelper.Low(LValue));
    Assert.AreEqual(4, TEnumHelper.HighAsInteger(LValue));
    Assert.AreEqual(0, TEnumHelper.LowAsInteger(LValue));
  end;
end;

procedure TEnumHelperHighLowTests.MatchesSystemHighLow;
begin
  TEnumChecks.CheckHighLowMatchTypeData<TTestColor>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestColorSubRange>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestSingle>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestNoPrefix>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestScoped>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestTwoBytes>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestFourBytes>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestByteFull>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestWord>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestBorderStyle>;
  TEnumChecks.CheckHighLowMatchTypeData<TTestBorderStyleSubRange>;
  TEnumChecks.CheckHighLowMatchTypeData<Boolean>;

  Assert.AreEqual(Integer(Ord(System.High(TTestWord))), TEnumHelper.HighAsInteger(w000));
  Assert.AreEqual(Integer(Ord(System.Low(TTestWord))), TEnumHelper.LowAsInteger(w000));
end;

procedure TEnumHelperHighLowTests.ScopedEnum;
begin
  Assert.AreEqual<TTestScoped>(TTestScoped.Third, TEnumHelper.High(TTestScoped.Second));
  Assert.AreEqual<TTestScoped>(TTestScoped.First, TEnumHelper.Low(TTestScoped.Second));
end;

procedure TEnumHelperHighLowTests.SingleValue;
begin
  Assert.AreEqual<TTestSingle>(tsOnly, TEnumHelper.High(tsOnly));
  Assert.AreEqual<TTestSingle>(tsOnly, TEnumHelper.Low(tsOnly));
  Assert.AreEqual(0, TEnumHelper.HighAsInteger(tsOnly));
  Assert.AreEqual(0, TEnumHelper.LowAsInteger(tsOnly));
end;

procedure TEnumHelperHighLowTests.SubRange;
var
  LValue: TTestColorSubRange;
begin
  LValue := tcBlue;

  Assert.AreEqual<TTestColorSubRange>(tcYellow, TEnumHelper.High<TTestColorSubRange>(LValue));
  Assert.AreEqual<TTestColorSubRange>(tcGreen, TEnumHelper.Low<TTestColorSubRange>(LValue));
  Assert.AreEqual(3, TEnumHelper.HighAsInteger<TTestColorSubRange>(LValue));
  Assert.AreEqual(1, TEnumHelper.LowAsInteger<TTestColorSubRange>(LValue));
end;

procedure TEnumHelperHighLowTests.WordEnum;
begin
  Assert.AreEqual<TTestWord>(w299, TEnumHelper.High(w000));
  Assert.AreEqual<TTestWord>(w000, TEnumHelper.Low(w299));
  Assert.AreEqual(299, TEnumHelper.HighAsInteger(w000));
  Assert.AreEqual(0, TEnumHelper.LowAsInteger(w299));
end;

{ TEnumHelperNextPreviousTests }

procedure TEnumHelperNextPreviousTests.BooleanType;
begin
  Assert.AreEqual<Boolean>(True, TEnumHelper.NextValue(False));
  Assert.AreEqual<Boolean>(True, TEnumHelper.NextValue(True));
  Assert.AreEqual<Boolean>(False, TEnumHelper.PreviousValue(True));
  Assert.AreEqual<Boolean>(False, TEnumHelper.PreviousValue(False));
end;

procedure TEnumHelperNextPreviousTests.ByteFullUpperBound;
begin
  Assert.AreEqual<TTestByteFull>(e255, TEnumHelper.NextValue(e254));
  Assert.AreEqual<TTestByteFull>(e255, TEnumHelper.NextValue(e255));
  Assert.AreEqual<TTestByteFull>(e254, TEnumHelper.PreviousValue(e255));
end;

procedure TEnumHelperNextPreviousTests.FourByteEnum;
begin
  Assert.AreEqual<TTestFourBytes>(fbTwo, TEnumHelper.NextValue(fbOne));
  Assert.AreEqual<TTestFourBytes>(fbThree, TEnumHelper.NextValue(fbThree));
  Assert.AreEqual<TTestFourBytes>(fbZero, TEnumHelper.PreviousValue(fbOne));
  Assert.AreEqual<TTestFourBytes>(fbZero, TEnumHelper.PreviousValue(fbZero));
end;

procedure TEnumHelperNextPreviousTests.NextAtHighStays;
begin
  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.NextValue(tcBlack));
  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, TEnumHelper.NextValue(bsSizeToolWin));
end;

// tcRed is below the TTestColorSubRange bounds
procedure TEnumHelperNextPreviousTests.NextBelowSubRangeClampsToLow;
var
  LOrdinal: Integer;
  LValue: TTestColorSubRange;
begin
  LOrdinal := Ord(tcRed);
  LValue := TTestColorSubRange(LOrdinal);

  Assert.AreEqual<TTestColorSubRange>(tcGreen, TEnumHelper.NextValue<TTestColorSubRange>(LValue));
end;

procedure TEnumHelperNextPreviousTests.NextInMiddle;
begin
  Assert.AreEqual<TTestColor>(tcGreen, TEnumHelper.NextValue(tcRed));
  Assert.AreEqual<TTestColor>(tcBlue, TEnumHelper.NextValue(tcGreen));
  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.NextValue(tcYellow));
end;

procedure TEnumHelperNextPreviousTests.NextOutOfRangeClampsToHigh;
var
  LOrdinal: Integer;
  LValue: TTestColor;
begin
  LOrdinal := 200;
  LValue := TTestColor(LOrdinal);

  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.NextValue(LValue));
end;

procedure TEnumHelperNextPreviousTests.PreviousAtLowStays;
begin
  Assert.AreEqual<TTestColor>(tcRed, TEnumHelper.PreviousValue(tcRed));
  Assert.AreEqual<TTestBorderStyle>(bsNone, TEnumHelper.PreviousValue(bsNone));
end;

// tcRed is below the TTestColorSubRange bounds
procedure TEnumHelperNextPreviousTests.PreviousBelowSubRangeClampsToLow;
var
  LOrdinal: Integer;
  LValue: TTestColorSubRange;
begin
  LOrdinal := Ord(tcRed);
  LValue := TTestColorSubRange(LOrdinal);

  Assert.AreEqual<TTestColorSubRange>(tcGreen, TEnumHelper.PreviousValue<TTestColorSubRange>(LValue));
end;

procedure TEnumHelperNextPreviousTests.PreviousInMiddle;
begin
  Assert.AreEqual<TTestColor>(tcRed, TEnumHelper.PreviousValue(tcGreen));
  Assert.AreEqual<TTestColor>(tcYellow, TEnumHelper.PreviousValue(tcBlack));
end;

// An out of range value above High is clamped to High like NextValue does, not decremented to another invalid value
procedure TEnumHelperNextPreviousTests.PreviousOutOfRangeClampsToHigh;
var
  LOrdinal: Integer;
  LValue: TTestColor;
begin
  LOrdinal := 200;
  LValue := TTestColor(LOrdinal);

  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.PreviousValue(LValue));
end;

procedure TEnumHelperNextPreviousTests.ScopedEnum;
begin
  Assert.AreEqual<TTestScoped>(TTestScoped.Second, TEnumHelper.NextValue(TTestScoped.First));
  Assert.AreEqual<TTestScoped>(TTestScoped.Third, TEnumHelper.NextValue(TTestScoped.Third));
  Assert.AreEqual<TTestScoped>(TTestScoped.Second, TEnumHelper.PreviousValue(TTestScoped.Third));
  Assert.AreEqual<TTestScoped>(TTestScoped.First, TEnumHelper.PreviousValue(TTestScoped.First));
end;

procedure TEnumHelperNextPreviousTests.SingleValue;
begin
  Assert.AreEqual<TTestSingle>(tsOnly, TEnumHelper.NextValue(tsOnly));
  Assert.AreEqual<TTestSingle>(tsOnly, TEnumHelper.PreviousValue(tsOnly));
end;

// Bounds come from the subrange type, not from its base type
procedure TEnumHelperNextPreviousTests.SubRangeStaysInsideSubRange;
var
  LValue: TTestColorSubRange;
begin
  LValue := tcYellow;
  Assert.AreEqual<TTestColorSubRange>(tcYellow, TEnumHelper.NextValue<TTestColorSubRange>(LValue));

  LValue := tcGreen;
  Assert.AreEqual<TTestColorSubRange>(tcGreen, TEnumHelper.PreviousValue<TTestColorSubRange>(LValue));
  Assert.AreEqual<TTestColorSubRange>(tcBlue, TEnumHelper.NextValue<TTestColorSubRange>(LValue));
end;

procedure TEnumHelperNextPreviousTests.WalkBackwardVisitsAllValues;
begin
  TEnumChecks.CheckWalkBackward<TTestColor>;
  TEnumChecks.CheckWalkBackward<TTestColorSubRange>;
  TEnumChecks.CheckWalkBackward<TTestSingle>;
  TEnumChecks.CheckWalkBackward<TTestScoped>;
  TEnumChecks.CheckWalkBackward<TTestTwoBytes>;
  TEnumChecks.CheckWalkBackward<TTestFourBytes>;
  TEnumChecks.CheckWalkBackward<TTestByteFull>;
  TEnumChecks.CheckWalkBackward<TTestWord>;
  TEnumChecks.CheckWalkBackward<TTestBorderStyle>;
  TEnumChecks.CheckWalkBackward<Boolean>;
end;

procedure TEnumHelperNextPreviousTests.WalkForwardVisitsAllValues;
begin
  TEnumChecks.CheckWalkForward<TTestColor>;
  TEnumChecks.CheckWalkForward<TTestColorSubRange>;
  TEnumChecks.CheckWalkForward<TTestSingle>;
  TEnumChecks.CheckWalkForward<TTestScoped>;
  TEnumChecks.CheckWalkForward<TTestTwoBytes>;
  TEnumChecks.CheckWalkForward<TTestFourBytes>;
  TEnumChecks.CheckWalkForward<TTestByteFull>;
  TEnumChecks.CheckWalkForward<TTestWord>;
  TEnumChecks.CheckWalkForward<TTestBorderStyle>;
  TEnumChecks.CheckWalkForward<Boolean>;
end;

procedure TEnumHelperNextPreviousTests.WordEnumCrossesByteBoundary;
begin
  Assert.AreEqual<TTestWord>(w256, TEnumHelper.NextValue(w255));
  Assert.AreEqual<TTestWord>(w255, TEnumHelper.PreviousValue(w256));
  Assert.AreEqual<TTestWord>(w299, TEnumHelper.NextValue(w299));
end;

{ TEnumHelperIntegerInRangeTests }

procedure TEnumHelperIntegerInRangeTests.BooleanType;
begin
  Assert.IsFalse(TEnumHelper.IntegerInRange(False, -1));
  Assert.IsTrue(TEnumHelper.IntegerInRange(False, 0));
  Assert.IsTrue(TEnumHelper.IntegerInRange(False, 1));
  Assert.IsFalse(TEnumHelper.IntegerInRange(False, 2));
end;

procedure TEnumHelperIntegerInRangeTests.Color(const AValue: Integer; const AExpected: Boolean);
begin
  Assert.AreEqual<Boolean>(AExpected, TEnumHelper.IntegerInRange(tcRed, AValue));
end;

procedure TEnumHelperIntegerInRangeTests.IndependentOfArgumentValue;
var
  LValue: TTestColor;
begin
  for LValue := System.Low(TTestColor) to System.High(TTestColor) do
  begin
    Assert.IsTrue(TEnumHelper.IntegerInRange(LValue, 0));
    Assert.IsTrue(TEnumHelper.IntegerInRange(LValue, 4));
    Assert.IsFalse(TEnumHelper.IntegerInRange(LValue, 5));
  end;
end;

procedure TEnumHelperIntegerInRangeTests.SingleValue;
begin
  Assert.IsFalse(TEnumHelper.IntegerInRange(tsOnly, -1));
  Assert.IsTrue(TEnumHelper.IntegerInRange(tsOnly, 0));
  Assert.IsFalse(TEnumHelper.IntegerInRange(tsOnly, 1));
end;

procedure TEnumHelperIntegerInRangeTests.SubRange(const AValue: Integer; const AExpected: Boolean);
var
  LValue: TTestColorSubRange;
begin
  LValue := tcGreen;

  Assert.AreEqual<Boolean>(AExpected, TEnumHelper.IntegerInRange<TTestColorSubRange>(LValue, AValue));
end;

procedure TEnumHelperIntegerInRangeTests.WordEnum;
begin
  Assert.IsTrue(TEnumHelper.IntegerInRange(w000, 255));
  Assert.IsTrue(TEnumHelper.IntegerInRange(w000, 256));
  Assert.IsTrue(TEnumHelper.IntegerInRange(w000, 299));
  Assert.IsFalse(TEnumHelper.IntegerInRange(w000, 300));
end;

{ TEnumHelperPropertyTests }

procedure TEnumHelperPropertyTests.Setup;
begin
  FWindow := TTestWindow.Create;
end;

procedure TEnumHelperPropertyTests.TearDown;
begin
  FreeAndNil(FWindow);
end;

// NextValue stops at High, wrapping around to Low is up to the caller
procedure TEnumHelperPropertyTests.CycleAroundAllValues;
var
  LIndex: Integer;
begin
  FWindow.Color := tcRed;

  for LIndex := 1 to 6 do
    if FWindow.Color = TEnumHelper.High(FWindow.Color) then
      FWindow.Color := TEnumHelper.Low(FWindow.Color)
    else
      FWindow.Color := TEnumHelper.NextValue(FWindow.Color);

  // tcRed + 6 steps with 5 values and wrap around lands to tcGreen
  Assert.AreEqual<TTestColor>(tcGreen, FWindow.Color);
end;

procedure TEnumHelperPropertyTests.DefaultValues;
begin
  Assert.AreEqual(2, TEnumHelper.EnumToInt(FWindow.BorderStyle));
  Assert.AreEqual('bsSizeable', TEnumHelper.EnumToString(FWindow.BorderStyle));
  Assert.AreEqual('Sizeable', TEnumHelper.EnumToString(FWindow.BorderStyle, True));

  Assert.AreEqual(2, TEnumHelper.EnumToInt(FWindow.Color));
  Assert.AreEqual('tcBlue', TEnumHelper.EnumToString(FWindow.Color));
  Assert.AreEqual('Blue', TEnumHelper.EnumToString(FWindow.Color, True));
end;

procedure TEnumHelperPropertyTests.EnumToStringMatchesPublishedPropertyRtti;
var
  LBorderStyle: TTestBorderStyle;
begin
  for LBorderStyle := System.Low(TTestBorderStyle) to System.High(TTestBorderStyle) do
  begin
    FWindow.BorderStyle := LBorderStyle;

    Assert.AreEqual(GetEnumProp(FWindow, 'BorderStyle'), TEnumHelper.EnumToString(FWindow.BorderStyle));
    Assert.AreEqual(Integer(GetOrdProp(FWindow, 'BorderStyle')), TEnumHelper.EnumToInt(FWindow.BorderStyle));
  end;
end;

procedure TEnumHelperPropertyTests.HighAndLowAssignedToProperty;
begin
  FWindow.BorderStyle := TEnumHelper.High(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, FWindow.BorderStyle);
  Assert.AreEqual(TEnumHelper.HighAsInteger(FWindow.BorderStyle), TEnumHelper.EnumToInt(FWindow.BorderStyle));

  FWindow.BorderStyle := TEnumHelper.Low(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsNone, FWindow.BorderStyle);
  Assert.AreEqual(TEnumHelper.LowAsInteger(FWindow.BorderStyle), TEnumHelper.EnumToInt(FWindow.BorderStyle));
end;

// Check an integer (from a database, ini file etc.) before casting it into the property
procedure TEnumHelperPropertyTests.IntegerInRangeGuardsCastToProperty;
var
  LStoredValue: Integer;
begin
  LStoredValue := 3;

  if TEnumHelper.IntegerInRange(FWindow.Color, LStoredValue) then
    FWindow.Color := TTestColor(LStoredValue);

  Assert.AreEqual<TTestColor>(tcYellow, FWindow.Color);

  LStoredValue := 7;

  if TEnumHelper.IntegerInRange(FWindow.Color, LStoredValue) then
    FWindow.Color := TTestColor(LStoredValue);

  Assert.AreEqual<TTestColor>(tcYellow, FWindow.Color);
end;

procedure TEnumHelperPropertyTests.NextValueAssignedToProperty;
begin
  FWindow.BorderStyle := TEnumHelper.NextValue(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsDialog, FWindow.BorderStyle);

  FWindow.BorderStyle := TEnumHelper.NextValue(FWindow.BorderStyle);
  FWindow.BorderStyle := TEnumHelper.NextValue(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, FWindow.BorderStyle);

  FWindow.BorderStyle := TEnumHelper.NextValue(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, FWindow.BorderStyle);
end;

procedure TEnumHelperPropertyTests.PreviousValueAssignedToProperty;
begin
  FWindow.BorderStyle := TEnumHelper.PreviousValue(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsSingle, FWindow.BorderStyle);

  FWindow.BorderStyle := TEnumHelper.PreviousValue(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsNone, FWindow.BorderStyle);

  FWindow.BorderStyle := TEnumHelper.PreviousValue(FWindow.BorderStyle);
  Assert.AreEqual<TTestBorderStyle>(bsNone, FWindow.BorderStyle);
end;

procedure TEnumHelperPropertyTests.PropertiesAreIndependent;
begin
  FWindow.BorderStyle := TEnumHelper.High(FWindow.BorderStyle);
  FWindow.Color := TEnumHelper.Low(FWindow.Color);

  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, FWindow.BorderStyle);
  Assert.AreEqual<TTestColor>(tcRed, FWindow.Color);
  Assert.AreEqual(5, TEnumHelper.HighAsInteger(FWindow.BorderStyle));
  Assert.AreEqual(4, TEnumHelper.HighAsInteger(FWindow.Color));
end;

procedure TEnumHelperPropertyTests.StringToEnumInvalidKeepsProperty;
var
  LBorderStyle: TTestBorderStyle;
begin
  LBorderStyle := FWindow.BorderStyle;

  try
    TEnumHelper.StringToEnum('bsHuge', LBorderStyle);

    FWindow.BorderStyle := LBorderStyle;
  except
    on EArgumentException do;
  end;

  Assert.AreEqual<TTestBorderStyle>(bsSizeable, FWindow.BorderStyle);
end;

// A property can't be passed as a var parameter, so go through a local variable
procedure TEnumHelperPropertyTests.StringToEnumThroughLocalVariable;
var
  LBorderStyle: TTestBorderStyle;
begin
  LBorderStyle := FWindow.BorderStyle;

  TEnumHelper.StringToEnum('bsToolWindow', LBorderStyle);

  FWindow.BorderStyle := LBorderStyle;

  Assert.AreEqual<TTestBorderStyle>(bsToolWindow, FWindow.BorderStyle);
  Assert.AreEqual('bsToolWindow', GetEnumProp(FWindow, 'BorderStyle'));
end;

{$IF DEFINED(DEBUG)}
  {$IFOPT C+}
{ TEnumHelperSanityCheckTests }

procedure TEnumHelperSanityCheckTests.EnumToIntRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.EnumToInt(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.EnumToStringRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.EnumToString(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.EnumToStringRejectsString;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.EnumToString('tcRed');
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.HighAsIntegerRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.HighAsInteger(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.HighRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.High(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.IntegerInRangeRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.IntegerInRange(42, 1);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.LowAsIntegerRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.LowAsInteger(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.LowRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.Low(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.NextValueRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.NextValue(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.PreviousValueRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.PreviousValue(42);
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.StringToEnumRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    var
      LValue: Integer;
    begin
      LValue := 0;

      TEnumHelper.StringToEnum('42', LValue);
    end,
    EAssertionFailed);
end;
  {$ENDIF}
{$ENDIF}

initialization
  TDUnitX.RegisterTestFixture(TEnumHelperDemoTests);
  TDUnitX.RegisterTestFixture(TEnumHelperEnumToIntTests);
  TDUnitX.RegisterTestFixture(TEnumHelperEnumToStringTests);
  TDUnitX.RegisterTestFixture(TEnumHelperHighLowTests);
  TDUnitX.RegisterTestFixture(TEnumHelperIntegerInRangeTests);
  TDUnitX.RegisterTestFixture(TEnumHelperNextPreviousTests);
  TDUnitX.RegisterTestFixture(TEnumHelperPropertyTests);
  TDUnitX.RegisterTestFixture(TEnumHelperStringToEnumTests);
{$IF DEFINED(DEBUG)}
  {$IFOPT C+}
  TDUnitX.RegisterTestFixture(TEnumHelperSanityCheckTests);
  {$ENDIF}
{$ENDIF}

end.
