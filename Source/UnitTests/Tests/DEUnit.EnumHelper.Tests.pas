unit DEUnit.EnumHelper.Tests;

interface

uses
  DUnitX.TestFramework, DEUnit.TestTypes;

type
  // Enumerations with assigned values have no RTTI, every method raises ENotSupportedException instead of an AV
  [TestFixture]
  TEnumHelperAssignedValuesTests = class
  public
    [Test]
    procedure EnumToIntRaises;
    [Test]
    procedure EnumToStringRaises;
    [Test]
    procedure HighAsIntegerRaises;
    [Test]
    procedure HighRaises;
    [Test]
    procedure IntegerInRangeRaises;
    [Test]
    procedure LowAsIntegerRaises;
    [Test]
    procedure LowRaises;
    [Test]
    procedure NextValueRaises;
    [Test]
    procedure PreviousValueRaises;
    [Test]
    procedure StorageIsSignedByte;
    [Test]
    procedure StringToEnumKeepsValue;
    [Test]
    procedure StringToEnumRaises;
  end;

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
    [Test]
    procedure DemoValidateIntegers;
    [Test]
    procedure DemoValidateIntegersFromProperty;
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

  // Count, Names and Values
  [TestFixture]
  TEnumHelperCountNamesValuesTests = class
  public
    [Test]
    procedure CountOfTypes;
    [Test]
    procedure NamesFull;
    [Test]
    procedure NamesMatchEnumToString;
    [Test]
    procedure NamesStripped;
    [Test]
    procedure NamesSubRange;
    [Test]
    procedure NoRttiRaises;
    [Test]
    procedure ValuesForIn;
    [Test]
    procedure ValuesInOrder;
    [Test]
    procedure ValuesSubRange;
  end;

  // Type level High, Low, HighAsInteger, LowAsInteger and IntegerInRange, no value needed
  [TestFixture]
  TEnumHelperTypeOnlyTests = class
  public
    [Test]
    procedure HighAndLow;
    [Test]
    procedure HighAndLowAsInteger;
    [Test]
    [TestCase('Below low', '-1,False')]
    [TestCase('Low', '0,True')]
    [TestCase('High', '4,True')]
    [TestCase('Above high', '5,False')]
    procedure IntegerInRange(const AValue: Integer; const AExpected: Boolean);
    [Test]
    procedure MatchValueVersions;
    [Test]
    procedure SubRange;
  end;

  [TestFixture]
  TEnumHelperIntegerToEnumTests = class
  public
    [Test]
    procedure AllValues;
    [Test]
    procedure OutOfRangeRaises;
    [Test]
    procedure SubRange;
    [Test]
    procedure TryInvalidReturnsFalseAndLow;
    [Test]
    procedure TryValid;
    [Test]
    procedure WordEnum;
  end;

  [TestFixture]
  TEnumHelperIsValidTests = class
  public
    [Test]
    procedure AllValuesValid;
    [Test]
    procedure BelowSubRangeInvalid;
    [Test]
    procedure OutOfRangeCastInvalid;
    [Test]
    procedure WordEnum;
  end;

  [TestFixture]
  TEnumHelperWrapTests = class
  public
    [Test]
    procedure BooleanType;
    [Test]
    procedure FullCycleBackward;
    [Test]
    procedure FullCycleForward;
    [Test]
    procedure NextInMiddle;
    [Test]
    procedure NextWrapsHighToLow;
    [Test]
    procedure OutOfRangeContinues;
    [Test]
    procedure PreviousInMiddle;
    [Test]
    procedure PreviousWrapsLowToHigh;
    [Test]
    procedure SingleValue;
    [Test]
    procedure SubRangeWrapsInsideSubRange;
  end;

  // TryStringToEnum, StringToEnumDef, and stripped names with AAllowStrippedName
  [TestFixture]
  TEnumHelperTryStringToEnumTests = class
  public
    [Test]
    procedure DefInvalidGivesDefault;
    [Test]
    procedure DefToProperty;
    [Test]
    procedure DefValid;
    [Test]
    procedure StrippedAmbiguousNotAccepted;
    [Test]
    procedure StrippedCaseInsensitive;
    [Test]
    procedure StrippedName;
    [Test]
    procedure StrippedNameNeedsFlag;
    [Test]
    procedure StrippedOutsideSubRange;
    [Test]
    procedure StrippedWithDef;
    [Test]
    procedure TryInvalidReturnsFalseAndLow;
    [Test]
    procedure TryNoRttiRaises;
    [Test]
    procedure TrySubRangeInvalidGivesSubRangeLow;
    [Test]
    procedure TryValid;
  end;

  [TestFixture]
  TEnumHelperSetTests = class
  public
    [Test]
    procedure ByteFullSetRoundTrip;
    [Test]
    procedure EmptySet;
    [Test]
    procedure NoRttiElementsRaise;
    [Test]
    procedure RoundTripAllSubsets;
    [Test]
    procedure SetToStringBrackets;
    [Test]
    procedure SetToStringValues;
    [Test]
    procedure StringToSetCaseInsensitive;
    [Test]
    procedure StringToSetInvalidRaises;
    [Test]
    procedure StringToSetSpacesAndBrackets;
    [Test]
    procedure SubRangeSetRejectsBaseTypeName;
    [Test]
    procedure SystemShiftState;
    [Test]
    procedure TryInvalidReturnsFalseAndEmpty;
  end;

{$IF DEFINED(DEBUG)}
  {$IFOPT C+}
  // TEnumHelper asserts that T is an enumeration only in DEBUG builds with assertions on
  [TestFixture]
  TEnumHelperSanityCheckTests = class
  public
    [Test]
    procedure CountRejectsInteger;
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
    procedure SetToStringRejectsEnum;
    [Test]
    procedure StringToEnumRejectsInteger;
  end;
  {$ENDIF}
{$ENDIF}

implementation

uses
  System.Classes, System.Rtti, System.SysUtils, System.TypInfo, Delphi.EnumHelper;

// Same code as TDEDemoMainForm.ButtonIntegerInRangeClick, lines collected into a string instead of the memo
function ValidateIntegersLog(const ABorderStyle: TTestBorderStyle): string;
var
  LLines: TStringList;
  LStoredValue: Integer;
begin
  LLines := TStringList.Create;
  try
    for LStoredValue := -1 to 7 do
      if TEnumHelper.IntegerInRange(ABorderStyle, LStoredValue) then
        LLines.Add(Format('%d is valid TTestBorderStyle: %s', [LStoredValue,
          TEnumHelper.EnumToString(TTestBorderStyle(LStoredValue))]))
      else
        LLines.Add(Format('%d is not valid TTestBorderStyle', [LStoredValue]));

    Result := LLines.Text;
  finally
    LLines.Free;
  end;
end;


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

{ TEnumHelperAssignedValuesTests }

procedure TEnumHelperAssignedValuesTests.EnumToIntRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.EnumToInt(ewavFirst);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.EnumToStringRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.EnumToString(ewavSecond);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.HighAsIntegerRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.HighAsInteger(ewavSecond);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.HighRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.High(ewavSecond);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.IntegerInRangeRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.IntegerInRange(ewavSecond, -1);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.LowAsIntegerRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.LowAsInteger(ewavSecond);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.LowRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.Low(ewavSecond);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.NextValueRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.NextValue(ewavSecond);
    end,
    ENotSupportedException);
end;

procedure TEnumHelperAssignedValuesTests.PreviousValueRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.PreviousValue(ewavSecond);
    end,
    ENotSupportedException);
end;

// Guards the premise: -1 is stored in one signed byte, so copying it into an Integer would give 255, not -1
procedure TEnumHelperAssignedValuesTests.StorageIsSignedByte;
begin
  Assert.AreEqual(1, Integer(SizeOf(TEnumWithAssignedValues)));
  Assert.AreEqual(-1, Integer(Ord(ewavFirst)));
  Assert.AreEqual(1, Integer(Ord(ewavThird)));
end;

procedure TEnumHelperAssignedValuesTests.StringToEnumKeepsValue;
var
  LValue: TEnumWithAssignedValues;
begin
  LValue := ewavThird;

  try
    TEnumHelper.StringToEnum('ewavFirst', LValue);
  except
    on ENotSupportedException do
    begin
      // 
    end;;
  end;

  // Assert.AreEqual<T> needs RTTI for its comparer, so compare the ordinals
  Assert.AreEqual(Integer(Ord(ewavThird)), Integer(Ord(LValue)));
end;

procedure TEnumHelperAssignedValuesTests.StringToEnumRaises;
var
  LValue: TEnumWithAssignedValues;
begin
  LValue := ewavSecond;

  Assert.WillRaiseWithMessage(
    procedure
    begin
      TEnumHelper.StringToEnum('ewavFirst', LValue);
    end,
    ENotSupportedException,
    'Type has no RTTI: enumerations with assigned values are not supported');
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

// Demo "Validate integers" button, the one that hit the access violation in the IDE
procedure TEnumHelperDemoTests.DemoValidateIntegers;
var
  LBorderStyle: TTestBorderStyle;
begin
  LBorderStyle := bsSizeable;

  Assert.AreEqual(EXPECTED_VALIDATE_INTEGERS_LOG, ValidateIntegersLog(LBorderStyle));
end;

// Same as DemoValidateIntegers, but the enumeration comes from a property like Self.BorderStyle in the demo form
procedure TEnumHelperDemoTests.DemoValidateIntegersFromProperty;
var
  LWindow: TTestWindow;
begin
  LWindow := TTestWindow.Create;
  try
    Assert.AreEqual(EXPECTED_VALIDATE_INTEGERS_LOG, ValidateIntegersLog(LWindow.BorderStyle));
  finally
    LWindow.Free;
  end;
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
    on EArgumentException do
    begin
      // 
    end;
  end;

  try
    TEnumHelper.StringToEnum('NotAValue', LFourByteValue);
  except
    on EArgumentException do
    begin
      // 
    end;
  end;

  try
    TEnumHelper.StringToEnum('NotAValue', LWordValue);
  except
    on EArgumentException do
    begin
      // 
    end;
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
    on EArgumentException do
    begin
      // 
    end;
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

{ TEnumHelperCountNamesValuesTests }

procedure TEnumHelperCountNamesValuesTests.CountOfTypes;
begin
  Assert.AreEqual(5, TEnumHelper.Count<TTestColor>);
  Assert.AreEqual(3, TEnumHelper.Count<TTestColorSubRange>);
  Assert.AreEqual(1, TEnumHelper.Count<TTestSingle>);
  Assert.AreEqual(4, TEnumHelper.Count<TTestFourBytes>);
  Assert.AreEqual(256, TEnumHelper.Count<TTestByteFull>);
  Assert.AreEqual(300, TEnumHelper.Count<TTestWord>);
  Assert.AreEqual(2, TEnumHelper.Count<Boolean>);
end;

procedure TEnumHelperCountNamesValuesTests.NamesFull;
begin
  Assert.AreEqual('tcRed,tcGreen,tcBlue,tcYellow,tcBlack', string.Join(',', TEnumHelper.Names<TTestColor>));
  Assert.AreEqual('False,True', string.Join(',', TEnumHelper.Names<Boolean>));
  Assert.AreEqual('First,Second,Third', string.Join(',', TEnumHelper.Names<TTestScoped>));
end;

procedure TEnumHelperCountNamesValuesTests.NamesMatchEnumToString;
var
  LNames: TArray<string>;
  LStrippedNames: TArray<string>;
  LValue: TTestWord;
begin
  LNames := TEnumHelper.Names<TTestWord>;
  LStrippedNames := TEnumHelper.Names<TTestWord>(True);

  Assert.AreEqual(300, Integer(Length(LNames)));

  for LValue := System.Low(TTestWord) to System.High(TTestWord) do
  begin
    Assert.AreEqual(TEnumHelper.EnumToString(LValue), LNames[Ord(LValue)]);
    Assert.AreEqual(TEnumHelper.EnumToString(LValue, True), LStrippedNames[Ord(LValue)]);
  end;
end;

procedure TEnumHelperCountNamesValuesTests.NamesStripped;
begin
  Assert.AreEqual('Red,Green,Blue,Yellow,Black', string.Join(',', TEnumHelper.Names<TTestColor>(True)));
  Assert.AreEqual('None,Single,Sizeable,Dialog,ToolWindow,SizeToolWin',
    string.Join(',', TEnumHelper.Names<TTestBorderStyle>(True)));
  Assert.AreEqual('lowerone,lowertwo', string.Join(',', TEnumHelper.Names<TTestAllLowercase>(True)));
  Assert.AreEqual('Äiti,Öljy,Å', string.Join(',', TEnumHelper.Names<TTestUnicode>(True)));
end;

procedure TEnumHelperCountNamesValuesTests.NamesSubRange;
begin
  Assert.AreEqual('tcGreen,tcBlue,tcYellow', string.Join(',', TEnumHelper.Names<TTestColorSubRange>));
  Assert.AreEqual('Green,Blue,Yellow', string.Join(',', TEnumHelper.Names<TTestColorSubRange>(True)));
end;

procedure TEnumHelperCountNamesValuesTests.NoRttiRaises;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.Count<TEnumWithAssignedValues>;
    end,
    ENotSupportedException);

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.Names<TEnumWithAssignedValues>;
    end,
    ENotSupportedException);

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.Values<TEnumWithAssignedValues>;
    end,
    ENotSupportedException);
end;

procedure TEnumHelperCountNamesValuesTests.ValuesForIn;
var
  LExpectedOrdinal: Integer;
  LValue: TTestWord;
begin
  LExpectedOrdinal := 0;

  for LValue in TEnumHelper.Values<TTestWord> do
  begin
    Assert.AreEqual(LExpectedOrdinal, Integer(Ord(LValue)));

    Inc(LExpectedOrdinal);
  end;

  Assert.AreEqual(300, LExpectedOrdinal);
end;

procedure TEnumHelperCountNamesValuesTests.ValuesInOrder;
var
  LValues: TArray<TTestColor>;
begin
  LValues := TEnumHelper.Values<TTestColor>;

  Assert.AreEqual(5, Integer(Length(LValues)));
  Assert.AreEqual<TTestColor>(tcRed, LValues[0]);
  Assert.AreEqual<TTestColor>(tcGreen, LValues[1]);
  Assert.AreEqual<TTestColor>(tcBlue, LValues[2]);
  Assert.AreEqual<TTestColor>(tcYellow, LValues[3]);
  Assert.AreEqual<TTestColor>(tcBlack, LValues[4]);

  Assert.AreEqual(2, Integer(Length(TEnumHelper.Values<Boolean>)));
  Assert.AreEqual<TTestFourBytes>(fbThree, TEnumHelper.Values<TTestFourBytes>[3]);
end;

procedure TEnumHelperCountNamesValuesTests.ValuesSubRange;
var
  LValues: TArray<TTestColorSubRange>;
begin
  LValues := TEnumHelper.Values<TTestColorSubRange>;

  Assert.AreEqual(3, Integer(Length(LValues)));
  Assert.AreEqual<TTestColorSubRange>(tcGreen, LValues[0]);
  Assert.AreEqual<TTestColorSubRange>(tcYellow, LValues[2]);
end;

{ TEnumHelperTypeOnlyTests }

procedure TEnumHelperTypeOnlyTests.HighAndLow;
begin
  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.High<TTestColor>);
  Assert.AreEqual<TTestColor>(tcRed, TEnumHelper.Low<TTestColor>);
  Assert.AreEqual<TTestWord>(w299, TEnumHelper.High<TTestWord>);
  Assert.AreEqual<TTestFourBytes>(fbThree, TEnumHelper.High<TTestFourBytes>);
  Assert.AreEqual<Boolean>(True, TEnumHelper.High<Boolean>);
end;

procedure TEnumHelperTypeOnlyTests.HighAndLowAsInteger;
begin
  Assert.AreEqual(4, TEnumHelper.HighAsInteger<TTestColor>);
  Assert.AreEqual(0, TEnumHelper.LowAsInteger<TTestColor>);
  Assert.AreEqual(255, TEnumHelper.HighAsInteger<TTestByteFull>);
  Assert.AreEqual(299, TEnumHelper.HighAsInteger<TTestWord>);
end;

procedure TEnumHelperTypeOnlyTests.IntegerInRange(const AValue: Integer; const AExpected: Boolean);
begin
  Assert.AreEqual<Boolean>(AExpected, TEnumHelper.IntegerInRange<TTestColor>(AValue));
end;

procedure TEnumHelperTypeOnlyTests.MatchValueVersions;
begin
  Assert.AreEqual<TTestBorderStyle>(TEnumHelper.High(bsDialog), TEnumHelper.High<TTestBorderStyle>);
  Assert.AreEqual<TTestBorderStyle>(TEnumHelper.Low(bsDialog), TEnumHelper.Low<TTestBorderStyle>);
  Assert.AreEqual(TEnumHelper.HighAsInteger(bsDialog), TEnumHelper.HighAsInteger<TTestBorderStyle>);
  Assert.AreEqual(TEnumHelper.LowAsInteger(bsDialog), TEnumHelper.LowAsInteger<TTestBorderStyle>);
  Assert.AreEqual(TEnumHelper.IntegerInRange(bsDialog, 5), TEnumHelper.IntegerInRange<TTestBorderStyle>(5));
end;

procedure TEnumHelperTypeOnlyTests.SubRange;
begin
  Assert.AreEqual<TTestColorSubRange>(tcYellow, TEnumHelper.High<TTestColorSubRange>);
  Assert.AreEqual<TTestColorSubRange>(tcGreen, TEnumHelper.Low<TTestColorSubRange>);
  Assert.AreEqual(3, TEnumHelper.HighAsInteger<TTestColorSubRange>);
  Assert.AreEqual(1, TEnumHelper.LowAsInteger<TTestColorSubRange>);
  Assert.IsFalse(TEnumHelper.IntegerInRange<TTestColorSubRange>(0));
  Assert.IsTrue(TEnumHelper.IntegerInRange<TTestColorSubRange>(1));
end;

{ TEnumHelperIntegerToEnumTests }

procedure TEnumHelperIntegerToEnumTests.AllValues;
var
  LOrdinal: Integer;
begin
  for LOrdinal := 0 to 4 do
    Assert.AreEqual(LOrdinal, TEnumHelper.EnumToInt(TEnumHelper.IntegerToEnum<TTestColor>(LOrdinal)));
end;

procedure TEnumHelperIntegerToEnumTests.OutOfRangeRaises;
begin
  Assert.WillRaiseWithMessage(
    procedure
    begin
      TEnumHelper.IntegerToEnum<TTestColor>(5);
    end,
    EArgumentOutOfRangeException,
    '5 is not a valid ordinal of TTestColor');

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.IntegerToEnum<TTestColor>(-1);
    end,
    EArgumentOutOfRangeException);
end;

procedure TEnumHelperIntegerToEnumTests.SubRange;
begin
  Assert.AreEqual<TTestColorSubRange>(tcGreen, TEnumHelper.IntegerToEnum<TTestColorSubRange>(1));
  Assert.AreEqual<TTestColorSubRange>(tcYellow, TEnumHelper.IntegerToEnum<TTestColorSubRange>(3));

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.IntegerToEnum<TTestColorSubRange>(0);
    end,
    EArgumentOutOfRangeException);
end;

procedure TEnumHelperIntegerToEnumTests.TryInvalidReturnsFalseAndLow;
var
  LColor: TTestColor;
  LSubRange: TTestColorSubRange;
begin
  LColor := tcBlack;
  Assert.IsFalse(TEnumHelper.TryIntegerToEnum<TTestColor>(7, LColor));
  Assert.AreEqual<TTestColor>(tcRed, LColor);

  LSubRange := tcYellow;
  Assert.IsFalse(TEnumHelper.TryIntegerToEnum<TTestColorSubRange>(0, LSubRange));
  Assert.AreEqual<TTestColorSubRange>(tcGreen, LSubRange);
end;

procedure TEnumHelperIntegerToEnumTests.TryValid;
var
  LColor: TTestColor;
begin
  Assert.IsTrue(TEnumHelper.TryIntegerToEnum<TTestColor>(3, LColor));
  Assert.AreEqual<TTestColor>(tcYellow, LColor);
end;

procedure TEnumHelperIntegerToEnumTests.WordEnum;
begin
  Assert.AreEqual<TTestWord>(w256, TEnumHelper.IntegerToEnum<TTestWord>(256));
  Assert.AreEqual<TTestWord>(w299, TEnumHelper.IntegerToEnum<TTestWord>(299));
  Assert.AreEqual<TTestFourBytes>(fbThree, TEnumHelper.IntegerToEnum<TTestFourBytes>(3));
end;

{ TEnumHelperIsValidTests }

procedure TEnumHelperIsValidTests.AllValuesValid;
var
  LValue: TTestColor;
begin
  for LValue := System.Low(TTestColor) to System.High(TTestColor) do
    Assert.IsTrue(TEnumHelper.IsValid(LValue));

  Assert.IsTrue(TEnumHelper.IsValid(True));
  Assert.IsTrue(TEnumHelper.IsValid(fbThree));
end;

procedure TEnumHelperIsValidTests.BelowSubRangeInvalid;
var
  LOrdinal: Integer;
  LValue: TTestColorSubRange;
begin
  LOrdinal := Ord(tcRed);
  LValue := TTestColorSubRange(LOrdinal);

  Assert.IsFalse(TEnumHelper.IsValid<TTestColorSubRange>(LValue));
end;

procedure TEnumHelperIsValidTests.OutOfRangeCastInvalid;
var
  LOrdinal: Integer;
  LValue: TTestColor;
begin
  LOrdinal := 200;
  LValue := TTestColor(LOrdinal);

  Assert.IsFalse(TEnumHelper.IsValid(LValue));
end;

procedure TEnumHelperIsValidTests.WordEnum;
var
  LOrdinal: Integer;
  LValue: TTestWord;
begin
  Assert.IsTrue(TEnumHelper.IsValid(w299));

  LOrdinal := 300;
  LValue := TTestWord(LOrdinal);

  Assert.IsFalse(TEnumHelper.IsValid(LValue));
end;

{ TEnumHelperWrapTests }

procedure TEnumHelperWrapTests.BooleanType;
begin
  Assert.AreEqual<Boolean>(False, TEnumHelper.NextValueWrap(True));
  Assert.AreEqual<Boolean>(True, TEnumHelper.PreviousValueWrap(False));
end;

procedure TEnumHelperWrapTests.FullCycleBackward;
var
  LIndex: Integer;
  LValue: TTestWord;
begin
  LValue := w100;

  for LIndex := 1 to TEnumHelper.Count<TTestWord> do
    LValue := TEnumHelper.PreviousValueWrap(LValue);

  Assert.AreEqual<TTestWord>(w100, LValue);
end;

procedure TEnumHelperWrapTests.FullCycleForward;
var
  LIndex: Integer;
  LValue: TTestColor;
begin
  LValue := tcBlue;

  for LIndex := 1 to TEnumHelper.Count<TTestColor> do
    LValue := TEnumHelper.NextValueWrap(LValue);

  Assert.AreEqual<TTestColor>(tcBlue, LValue);
end;

procedure TEnumHelperWrapTests.NextInMiddle;
begin
  Assert.AreEqual<TTestColor>(tcGreen, TEnumHelper.NextValueWrap(tcRed));
  Assert.AreEqual<TTestWord>(w256, TEnumHelper.NextValueWrap(w255));
end;

procedure TEnumHelperWrapTests.NextWrapsHighToLow;
begin
  Assert.AreEqual<TTestColor>(tcRed, TEnumHelper.NextValueWrap(tcBlack));
  Assert.AreEqual<TTestByteFull>(e000, TEnumHelper.NextValueWrap(e255));
  Assert.AreEqual<TTestFourBytes>(fbZero, TEnumHelper.NextValueWrap(fbThree));
end;

procedure TEnumHelperWrapTests.OutOfRangeContinues;
var
  LOrdinal: Integer;
  LValue: TTestColor;
begin
  LOrdinal := 200;
  LValue := TTestColor(LOrdinal);

  Assert.AreEqual<TTestColor>(tcRed, TEnumHelper.NextValueWrap(LValue));
  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.PreviousValueWrap(LValue));
end;

procedure TEnumHelperWrapTests.PreviousInMiddle;
begin
  Assert.AreEqual<TTestColor>(tcYellow, TEnumHelper.PreviousValueWrap(tcBlack));
  Assert.AreEqual<TTestWord>(w255, TEnumHelper.PreviousValueWrap(w256));
end;

procedure TEnumHelperWrapTests.PreviousWrapsLowToHigh;
begin
  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.PreviousValueWrap(tcRed));
  Assert.AreEqual<TTestWord>(w299, TEnumHelper.PreviousValueWrap(w000));
end;

procedure TEnumHelperWrapTests.SingleValue;
begin
  Assert.AreEqual<TTestSingle>(tsOnly, TEnumHelper.NextValueWrap(tsOnly));
  Assert.AreEqual<TTestSingle>(tsOnly, TEnumHelper.PreviousValueWrap(tsOnly));
end;

procedure TEnumHelperWrapTests.SubRangeWrapsInsideSubRange;
var
  LValue: TTestColorSubRange;
begin
  LValue := tcYellow;
  Assert.AreEqual<TTestColorSubRange>(tcGreen, TEnumHelper.NextValueWrap<TTestColorSubRange>(LValue));

  LValue := tcGreen;
  Assert.AreEqual<TTestColorSubRange>(tcYellow, TEnumHelper.PreviousValueWrap<TTestColorSubRange>(LValue));
end;

{ TEnumHelperTryStringToEnumTests }

procedure TEnumHelperTryStringToEnumTests.DefInvalidGivesDefault;
begin
  Assert.AreEqual<TTestColor>(tcYellow, TEnumHelper.StringToEnumDef('NotAValue', tcYellow));
  Assert.AreEqual<TTestColor>(tcYellow, TEnumHelper.StringToEnumDef('', tcYellow));
end;

// The function form works with properties directly, StringToEnum needs a local variable for them
procedure TEnumHelperTryStringToEnumTests.DefToProperty;
var
  LWindow: TTestWindow;
begin
  LWindow := TTestWindow.Create;
  try
    LWindow.BorderStyle := TEnumHelper.StringToEnumDef('bsDialog', LWindow.BorderStyle);
    Assert.AreEqual<TTestBorderStyle>(bsDialog, LWindow.BorderStyle);

    LWindow.BorderStyle := TEnumHelper.StringToEnumDef('bsHuge', LWindow.BorderStyle);
    Assert.AreEqual<TTestBorderStyle>(bsDialog, LWindow.BorderStyle);
  finally
    LWindow.Free;
  end;
end;

procedure TEnumHelperTryStringToEnumTests.DefValid;
begin
  Assert.AreEqual<TTestColor>(tcBlue, TEnumHelper.StringToEnumDef('tcBlue', tcYellow));
  Assert.AreEqual<TTestWord>(w299, TEnumHelper.StringToEnumDef('w299', w000));
end;

procedure TEnumHelperTryStringToEnumTests.StrippedAmbiguousNotAccepted;
var
  LValue: TTestAmbiguousStripped;
begin
  Assert.IsFalse(TEnumHelper.TryStringToEnum<TTestAmbiguousStripped>('Foo', LValue, True));

  Assert.IsTrue(TEnumHelper.TryStringToEnum<TTestAmbiguousStripped>('Bar', LValue, True));
  Assert.AreEqual<TTestAmbiguousStripped>(abBar, LValue);

  // Full names are never ambiguous
  Assert.IsTrue(TEnumHelper.TryStringToEnum<TTestAmbiguousStripped>('cdFoo', LValue, True));
  Assert.AreEqual<TTestAmbiguousStripped>(cdFoo, LValue);

  LValue := abBar;

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.StringToEnum('Foo', LValue, True);
    end,
    EArgumentException);
end;

procedure TEnumHelperTryStringToEnumTests.StrippedCaseInsensitive;
var
  LValue: TTestColor;
begin
  Assert.IsTrue(TEnumHelper.TryStringToEnum<TTestColor>('YELLOW', LValue, True));
  Assert.AreEqual<TTestColor>(tcYellow, LValue);
end;

procedure TEnumHelperTryStringToEnumTests.StrippedName;
var
  LValue: TTestBorderStyle;
begin
  LValue := bsNone;

  TEnumHelper.StringToEnum('SizeToolWin', LValue, True);
  Assert.AreEqual<TTestBorderStyle>(bsSizeToolWin, LValue);

  // Round trip through EnumToString(..., True) now works
  TEnumHelper.StringToEnum(TEnumHelper.EnumToString(bsDialog, True), LValue, True);
  Assert.AreEqual<TTestBorderStyle>(bsDialog, LValue);
end;

procedure TEnumHelperTryStringToEnumTests.StrippedNameNeedsFlag;
var
  LValue: TTestColor;
begin
  Assert.IsFalse(TEnumHelper.TryStringToEnum<TTestColor>('Blue', LValue));
  Assert.IsTrue(TEnumHelper.TryStringToEnum<TTestColor>('Blue', LValue, True));
end;

procedure TEnumHelperTryStringToEnumTests.StrippedOutsideSubRange;
var
  LValue: TTestColorSubRange;
begin
  Assert.IsFalse(TEnumHelper.TryStringToEnum<TTestColorSubRange>('Red', LValue, True));
  Assert.IsTrue(TEnumHelper.TryStringToEnum<TTestColorSubRange>('Blue', LValue, True));
  Assert.AreEqual<TTestColorSubRange>(tcBlue, LValue);
end;

procedure TEnumHelperTryStringToEnumTests.StrippedWithDef;
begin
  Assert.AreEqual<TTestColor>(tcBlack, TEnumHelper.StringToEnumDef('Black', tcRed, True));
  Assert.AreEqual<TTestColor>(tcRed, TEnumHelper.StringToEnumDef('Black', tcRed));
end;

procedure TEnumHelperTryStringToEnumTests.TryInvalidReturnsFalseAndLow;
var
  LValue: TTestColor;
begin
  LValue := tcBlack;

  Assert.IsFalse(TEnumHelper.TryStringToEnum<TTestColor>('NotAValue', LValue));
  Assert.AreEqual<TTestColor>(tcRed, LValue);
end;

procedure TEnumHelperTryStringToEnumTests.TryNoRttiRaises;
begin
  Assert.WillRaise(
    procedure
    var
      LValue: TEnumWithAssignedValues;
    begin
      TEnumHelper.TryStringToEnum<TEnumWithAssignedValues>('ewavFirst', LValue);
    end,
    ENotSupportedException);
end;

// Default(T) would be tcRed, which is not a value of the subrange
procedure TEnumHelperTryStringToEnumTests.TrySubRangeInvalidGivesSubRangeLow;
var
  LValue: TTestColorSubRange;
begin
  Assert.IsFalse(TEnumHelper.TryStringToEnum<TTestColorSubRange>('tcRed', LValue));
  Assert.AreEqual<TTestColorSubRange>(tcGreen, LValue);
end;

procedure TEnumHelperTryStringToEnumTests.TryValid;
var
  LValue: TTestColor;
begin
  Assert.IsTrue(TEnumHelper.TryStringToEnum<TTestColor>('tcYellow', LValue));
  Assert.AreEqual<TTestColor>(tcYellow, LValue);

  Assert.IsTrue(TEnumHelper.TryStringToEnum<TTestColor>('TTestColor.tcBlack', LValue));
  Assert.AreEqual<TTestColor>(tcBlack, LValue);
end;

{ TEnumHelperSetTests }

procedure TEnumHelperSetTests.ByteFullSetRoundTrip;
var
  LSet: TTestByteFullSet;
begin
  LSet := [e000, e128, e255];

  Assert.AreEqual('e000,e128,e255', TEnumHelper.SetToString(LSet));
  Assert.IsTrue(TEnumHelper.StringToSet<TTestByteFullSet>('e000,e128,e255') = LSet);
end;

procedure TEnumHelperSetTests.EmptySet;
var
  LSet: TTestColors;
begin
  LSet := [];

  Assert.AreEqual('', TEnumHelper.SetToString(LSet));
  Assert.AreEqual('[]', TEnumHelper.SetToString(LSet, True));
  Assert.IsTrue(TEnumHelper.StringToSet<TTestColors>('') = []);
  Assert.IsTrue(TEnumHelper.StringToSet<TTestColors>('[]') = []);
end;

procedure TEnumHelperSetTests.NoRttiElementsRaise;
begin
  Assert.WillRaise(
    procedure
    var
      LSet: TEnumWithPositiveAssignedValuesSet;
    begin
      LSet := [ewpavOne];

      TEnumHelper.SetToString(LSet);
    end,
    ENotSupportedException);

  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.StringToSet<TEnumWithPositiveAssignedValuesSet>('ewpavOne');
    end,
    ENotSupportedException);
end;

procedure TEnumHelperSetTests.RoundTripAllSubsets;
var
  LBits: Integer;
  LColor: TTestColor;
  LSet: TTestColors;
begin
  for LBits := 0 to 31 do
  begin
    LSet := [];

    for LColor := System.Low(TTestColor) to System.High(TTestColor) do
      if LBits and (1 shl Ord(LColor)) <> 0 then
        Include(LSet, LColor);

    Assert.IsTrue(TEnumHelper.StringToSet<TTestColors>(TEnumHelper.SetToString(LSet)) = LSet);
    Assert.IsTrue(TEnumHelper.StringToSet<TTestColors>(TEnumHelper.SetToString(LSet, True)) = LSet);
  end;
end;

procedure TEnumHelperSetTests.SetToStringBrackets;
begin
  Assert.AreEqual('[tcRed,tcBlue]', TEnumHelper.SetToString<TTestColors>([tcRed, tcBlue], True));
end;

procedure TEnumHelperSetTests.SetToStringValues;
begin
  Assert.AreEqual('tcRed,tcBlue', TEnumHelper.SetToString<TTestColors>([tcBlue, tcRed]));
  Assert.AreEqual('tcRed,tcGreen,tcBlue,tcYellow,tcBlack',
    TEnumHelper.SetToString<TTestColors>([System.Low(TTestColor)..System.High(TTestColor)]));
  Assert.AreEqual('tcGreen,tcYellow', TEnumHelper.SetToString<TTestColorSubRangeSet>([tcGreen, tcYellow]));
end;

procedure TEnumHelperSetTests.StringToSetCaseInsensitive;
begin
  Assert.IsTrue(TEnumHelper.StringToSet<TTestColors>('TCRED,tcblue') = [tcRed, tcBlue]);
end;

procedure TEnumHelperSetTests.StringToSetInvalidRaises;
begin
  Assert.WillRaiseWithMessage(
    procedure
    begin
      TEnumHelper.StringToSet<TTestColors>('tcRed,tcPurple');
    end,
    EArgumentException,
    '"tcRed,tcPurple" is not a valid value of TTestColors');
end;

procedure TEnumHelperSetTests.StringToSetSpacesAndBrackets;
begin
  Assert.IsTrue(TEnumHelper.StringToSet<TTestColors>('[tcRed, tcBlue]') = [tcRed, tcBlue]);
  Assert.IsTrue(TEnumHelper.StringToSet<TTestColors>(' [ tcBlack ] ') = [tcBlack]);
end;

procedure TEnumHelperSetTests.SubRangeSetRejectsBaseTypeName;
var
  LSet: TTestColorSubRangeSet;
begin
  Assert.IsTrue(TEnumHelper.TryStringToSet<TTestColorSubRangeSet>('tcGreen,tcYellow', LSet));
  Assert.IsTrue(LSet = [tcGreen, tcYellow]);

  Assert.IsFalse(TEnumHelper.TryStringToSet<TTestColorSubRangeSet>('tcGreen,tcRed', LSet));
end;

// A real RTL set type: TShiftState from System.Classes
procedure TEnumHelperSetTests.SystemShiftState;
var
  LShiftState: TShiftState;
begin
  LShiftState := [ssShift, ssCtrl];

  Assert.AreEqual('ssShift,ssCtrl', TEnumHelper.SetToString(LShiftState));
  Assert.IsTrue(TEnumHelper.StringToSet<TShiftState>('ssCtrl,ssShift') = LShiftState);
end;

procedure TEnumHelperSetTests.TryInvalidReturnsFalseAndEmpty;
var
  LSet: TTestColors;
begin
  LSet := [tcRed];

  Assert.IsFalse(TEnumHelper.TryStringToSet<TTestColors>('tcRed,NotAValue', LSet));
  Assert.IsTrue(LSet = []);
end;

{$IF DEFINED(DEBUG)}
  {$IFOPT C+}
{ TEnumHelperSanityCheckTests }

procedure TEnumHelperSanityCheckTests.CountRejectsInteger;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.Count<Integer>;
    end,
    EAssertionFailed);
end;

procedure TEnumHelperSanityCheckTests.SetToStringRejectsEnum;
begin
  Assert.WillRaise(
    procedure
    begin
      TEnumHelper.SetToString(tcRed);
    end,
    EAssertionFailed);
end;

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
  TDUnitX.RegisterTestFixture(TEnumHelperAssignedValuesTests);
  TDUnitX.RegisterTestFixture(TEnumHelperDemoTests);
  TDUnitX.RegisterTestFixture(TEnumHelperEnumToIntTests);
  TDUnitX.RegisterTestFixture(TEnumHelperEnumToStringTests);
  TDUnitX.RegisterTestFixture(TEnumHelperHighLowTests);
  TDUnitX.RegisterTestFixture(TEnumHelperIntegerInRangeTests);
  TDUnitX.RegisterTestFixture(TEnumHelperNextPreviousTests);
  TDUnitX.RegisterTestFixture(TEnumHelperPropertyTests);
  TDUnitX.RegisterTestFixture(TEnumHelperCountNamesValuesTests);
  TDUnitX.RegisterTestFixture(TEnumHelperTypeOnlyTests);
  TDUnitX.RegisterTestFixture(TEnumHelperIntegerToEnumTests);
  TDUnitX.RegisterTestFixture(TEnumHelperIsValidTests);
  TDUnitX.RegisterTestFixture(TEnumHelperWrapTests);
  TDUnitX.RegisterTestFixture(TEnumHelperTryStringToEnumTests);
  TDUnitX.RegisterTestFixture(TEnumHelperSetTests);
  TDUnitX.RegisterTestFixture(TEnumHelperStringToEnumTests);
{$IF DEFINED(DEBUG)}
  {$IFOPT C+}
  TDUnitX.RegisterTestFixture(TEnumHelperSanityCheckTests);
  {$ENDIF}
{$ENDIF}

end.
