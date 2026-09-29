unit Delphi.EnumHelper;

interface

{$UNDEF DEBUG_AND_ASSERTS}

{$IFDEF DEBUG}
  {$IFOPT C+}
    {$DEFINE DEBUG_AND_ASSERTS}
  {$ENDIF}
{$ENDIF}

uses
  System.TypInfo;

  // Usage: LEnumNameStr := TEnumHelper.EnumToString(FormMain.BorderStyle);
  //        LCount := TEnumHelper.Count<TAlign>;
  //        ComboBox.Items.AddStrings(TEnumHelper.Names<TAlignment>(True));
  //        LStyles := TEnumHelper.StringToSet<TFontStyles>('fsBold,fsItalic');
type
  TEnumHelper = class
  protected
    const
      NO_RTTI_MESSAGE = 'Type has no RTTI: enumerations with assigned values are not supported';
  protected
    class function EnumTypeData<T>: PTypeData;
    class function FromOrdinal<T>(const AOrdinal: Integer): T;
    class function OrdinalOf<T>(const AEnumValue: T): Integer;
    class function StripLowercasePrefix(const AName: string): string;
    class function TryNameToOrdinal<T>(const AEnumString: string; const AAllowStrippedName: Boolean;
      var AOrdinal: Integer): Boolean;
    class function TrySetElementsValid<TSet>(const ASetString: string): Boolean;
    class procedure CheckEnumType<T>;
    class procedure CheckHasTypeInfo<T>;
    class procedure CheckSetType<TSet>;
  public
    class function Count<T>: Integer;
    class function EnumToInt<T>(const AEnumValue: T): Integer;
    class function EnumToString<T>(const AEnumValue: T; const AStripLowercasePrefix: Boolean = False): string;
    class function High<T>: T; overload;
    class function High<T>(const AEnumValue: T): T; overload;
    class function HighAsInteger<T>: Integer; overload;
    class function HighAsInteger<T>(const AEnumValue: T): Integer; overload;
    class function IntegerInRange<T>(const AIntegerValue: Integer): Boolean; overload;
    class function IntegerInRange<T>(const AEnumValue: T; const AIntegrValue: Integer): Boolean; overload;
    class function IntegerToEnum<T>(const AIntegerValue: Integer): T;
    class function IsValid<T>(const AEnumValue: T): Boolean;
    class function Low<T>: T; overload;
    class function Low<T>(const AEnumValue: T): T; overload;
    class function LowAsInteger<T>: Integer; overload;
    class function LowAsInteger<T>(const AEnumValue: T): Integer; overload;
    class function Names<T>(const AStripLowercasePrefix: Boolean = False): TArray<string>;
    class function NextValue<T>(const AEnumValue: T): T;
    class function NextValueWrap<T>(const AEnumValue: T): T;
    class function PreviousValue<T>(const AEnumValue: T): T;
    class function PreviousValueWrap<T>(const AEnumValue: T): T;
    class function SetToString<TSet>(const ASet: TSet; const ABrackets: Boolean = False): string;
    class function StringToEnumDef<T>(const AEnumString: string; const ADefault: T;
      const AAllowStrippedName: Boolean = False): T;
    class function StringToSet<TSet>(const ASetString: string): TSet;
    class function TryIntegerToEnum<T>(const AIntegerValue: Integer; var AEnumValue: T): Boolean;
    class function TryStringToEnum<T>(const AEnumString: string; var AEnumValue: T;
      const AAllowStrippedName: Boolean = False): Boolean;
    class function TryStringToSet<TSet>(const ASetString: string; var ASet: TSet): Boolean;
    class function Values<T>: TArray<T>;
    class procedure StringToEnum<T>(const AEnumString: string; var AEnumValue: T;
      const AAllowStrippedName: Boolean = False);
  end;

implementation

uses
  System.Character, System.Math, System.SysUtils;

{ TEnumHelper - protected }

// Enumerations with assigned values, like (eFirst = -1, eSecond = 5), have no RTTI and TypeInfo(T) is nil for them.
// Without it there are no names nor bounds, and not even the sign of the ordinal is known.
class procedure TEnumHelper.CheckHasTypeInfo<T>;
begin
  if not Assigned(TypeInfo(T)) then
    raise ENotSupportedException.Create(NO_RTTI_MESSAGE);
end;

class procedure TEnumHelper.CheckEnumType<T>;
begin
  CheckHasTypeInfo<T>;

{$IFDEF DEBUG_AND_ASSERTS}
  Assert(PTypeInfo(TypeInfo(T))^.Kind = tkEnumeration, 'Only Enumeration types supported');
{$ENDIF}
end;

class procedure TEnumHelper.CheckSetType<TSet>;
var
  LCompType: PPTypeInfo;
begin
  CheckHasTypeInfo<TSet>;

{$IFDEF DEBUG_AND_ASSERTS}
  Assert(PTypeInfo(TypeInfo(TSet))^.Kind = tkSet, 'Only Set types supported');
{$ENDIF}

  // A set of an enumeration without RTTI has type info itself, but not for its elements
  LCompType := GetTypeData(TypeInfo(TSet))^.CompType;

  if not Assigned(LCompType) or not Assigned(LCompType^) then
    raise ENotSupportedException.Create(NO_RTTI_MESSAGE);

  if LCompType^^.Kind <> tkEnumeration then
    raise ENotSupportedException.Create('Only sets of enumerations are supported');
end;

class function TEnumHelper.EnumTypeData<T>: PTypeData;
begin
  Result := GetTypeData(TypeInfo(T));
end;

// Enumerations with RTTI are never negative, so zero extending the stored 1, 2 or 4 bytes gives the ordinal
class function TEnumHelper.FromOrdinal<T>(const AOrdinal: Integer): T;
begin
  Move(AOrdinal, Result, SizeOf(T));
end;

class function TEnumHelper.OrdinalOf<T>(const AEnumValue: T): Integer;
begin
  Result := 0;

  Move(AEnumValue, Result, SizeOf(AEnumValue));
end;

class function TEnumHelper.StripLowercasePrefix(const AName: string): string;
var
  LIndex: Integer;
  LNameLength: Integer;
begin
  Result := AName;
  LIndex := 1;
  LNameLength := Length(AName);

  while (LIndex <= LNameLength) and AName[LIndex].IsLower do
    Inc(LIndex);

  // All lowercase name has no prefix to strip
  if LIndex <= LNameLength then
    Result := Copy(AName, LIndex, LNameLength);
end;

// Full names first (GetEnumValue, case-insensitive, also "TTypeName.Name"). Stripped names only when asked, and only
// when exactly one value matches: (abFoo, cdFoo) makes "Foo" ambiguous, and it is not accepted.
class function TEnumHelper.TryNameToOrdinal<T>(const AEnumString: string; const AAllowStrippedName: Boolean;
  var AOrdinal: Integer): Boolean;
var
  LTypeData: PTypeData;
  LOrdinal: Integer;
  LMatchCount: Integer;
begin
  LTypeData := EnumTypeData<T>;

  // GetEnumValue returns -1 for unknown names, and names of the base type for subranges
  AOrdinal := GetEnumValue(TypeInfo(T), AEnumString);
  Result := InRange(AOrdinal, LTypeData.MinValue, LTypeData.MaxValue);

  if Result or not AAllowStrippedName or AEnumString.IsEmpty then
    Exit;

  LMatchCount := 0;

  for LOrdinal := LTypeData.MinValue to LTypeData.MaxValue do
    if SameText(StripLowercasePrefix(GetEnumName(TypeInfo(T), LOrdinal)), AEnumString) then
    begin
      Inc(LMatchCount);
      AOrdinal := LOrdinal;
    end;

  Result := LMatchCount = 1;
end;

// System.TypInfo.StringToSet raises EPropertyConvertError for unknown names and accepts names outside a subrange,
// so every element is checked here first
class function TEnumHelper.TrySetElementsValid<TSet>(const ASetString: string): Boolean;
var
  LCompType: PTypeInfo;
  LCompTypeData: PTypeData;
  LElement: string;
  LOrdinal: Integer;
begin
  LCompType := GetTypeData(TypeInfo(TSet))^.CompType^;
  LCompTypeData := GetTypeData(LCompType);

  for LElement in ASetString.Trim.Trim(['[', ']']).Split([',']) do
  begin
    if LElement.Trim.IsEmpty then
      Continue;

    LOrdinal := GetEnumValue(LCompType, LElement.Trim);

    if not InRange(LOrdinal, LCompTypeData.MinValue, LCompTypeData.MaxValue) then
      Exit(False);
  end;

  Result := True;
end;

{ TEnumHelper - public }

class function TEnumHelper.Count<T>: Integer;
begin
  CheckEnumType<T>;

  Result := EnumTypeData<T>.MaxValue - EnumTypeData<T>.MinValue + 1;
end;

class function TEnumHelper.EnumToInt<T>(const AEnumValue: T): Integer;
begin
  CheckEnumType<T>;

  Result := OrdinalOf(AEnumValue);
end;

class function TEnumHelper.EnumToString<T>(const AEnumValue: T; const AStripLowercasePrefix: Boolean = False): string;
begin
  CheckEnumType<T>;

  Result := GetEnumName(TypeInfo(T), OrdinalOf(AEnumValue));

  if AStripLowercasePrefix then
    Result := StripLowercasePrefix(Result);
end;

class function TEnumHelper.High<T>: T;
begin
  CheckEnumType<T>;

  Result := FromOrdinal<T>(EnumTypeData<T>.MaxValue);
end;

class function TEnumHelper.High<T>(const AEnumValue: T): T;
begin
  Result := High<T>;
end;

class function TEnumHelper.HighAsInteger<T>: Integer;
begin
  CheckEnumType<T>;

  Result := EnumTypeData<T>.MaxValue;
end;

class function TEnumHelper.HighAsInteger<T>(const AEnumValue: T): Integer;
begin
  Result := HighAsInteger<T>;
end;

class function TEnumHelper.IntegerInRange<T>(const AIntegerValue: Integer): Boolean;
begin
  CheckEnumType<T>;

  Result := InRange(AIntegerValue, EnumTypeData<T>.MinValue, EnumTypeData<T>.MaxValue);
end;

class function TEnumHelper.IntegerInRange<T>(const AEnumValue: T; const AIntegrValue: Integer): Boolean;
begin
  Result := IntegerInRange<T>(AIntegrValue);
end;

class function TEnumHelper.IntegerToEnum<T>(const AIntegerValue: Integer): T;
begin
  if not TryIntegerToEnum<T>(AIntegerValue, Result) then
    raise EArgumentOutOfRangeException.CreateFmt('%d is not a valid ordinal of %s',
      [AIntegerValue, GetTypeName(TypeInfo(T))]);
end;

// False for a variable holding an ordinal outside the type, e.g. after a cast from an unchecked integer
class function TEnumHelper.IsValid<T>(const AEnumValue: T): Boolean;
begin
  Result := IntegerInRange<T>(OrdinalOf(AEnumValue));
end;

class function TEnumHelper.Low<T>: T;
begin
  CheckEnumType<T>;

  Result := FromOrdinal<T>(EnumTypeData<T>.MinValue);
end;

class function TEnumHelper.Low<T>(const AEnumValue: T): T;
begin
  Result := Low<T>;
end;

class function TEnumHelper.LowAsInteger<T>: Integer;
begin
  CheckEnumType<T>;

  Result := EnumTypeData<T>.MinValue;
end;

class function TEnumHelper.LowAsInteger<T>(const AEnumValue: T): Integer;
begin
  Result := LowAsInteger<T>;
end;

class function TEnumHelper.Names<T>(const AStripLowercasePrefix: Boolean = False): TArray<string>;
var
  LIndex: Integer;
  LMinValue: Integer;
begin
  CheckEnumType<T>;

  LMinValue := EnumTypeData<T>.MinValue;

  SetLength(Result, Count<T>);

  for LIndex := 0 to System.High(Result) do
  begin
    Result[LIndex] := GetEnumName(TypeInfo(T), LMinValue + LIndex);

    if AStripLowercasePrefix then
      Result[LIndex] := StripLowercasePrefix(Result[LIndex]);
  end;
end;

// Stops at High, out of range values are clamped between Low and High
class function TEnumHelper.NextValue<T>(const AEnumValue: T): T;
begin
  CheckEnumType<T>;

  Result := FromOrdinal<T>(EnsureRange(OrdinalOf(AEnumValue) + 1, EnumTypeData<T>.MinValue, EnumTypeData<T>.MaxValue));
end;

// After High comes Low, an out of range value also continues from Low
class function TEnumHelper.NextValueWrap<T>(const AEnumValue: T): T;
var
  LOrdinal: Integer;
begin
  CheckEnumType<T>;

  LOrdinal := OrdinalOf(AEnumValue);

  if (LOrdinal < EnumTypeData<T>.MinValue) or (LOrdinal >= EnumTypeData<T>.MaxValue) then
    Result := FromOrdinal<T>(EnumTypeData<T>.MinValue)
  else
    Result := FromOrdinal<T>(LOrdinal + 1);
end;

// Stops at Low, out of range values are clamped between Low and High
class function TEnumHelper.PreviousValue<T>(const AEnumValue: T): T;
begin
  CheckEnumType<T>;

  Result := FromOrdinal<T>(EnsureRange(OrdinalOf(AEnumValue) - 1, EnumTypeData<T>.MinValue, EnumTypeData<T>.MaxValue));
end;

// Before Low comes High, an out of range value also continues from High
class function TEnumHelper.PreviousValueWrap<T>(const AEnumValue: T): T;
var
  LOrdinal: Integer;
begin
  CheckEnumType<T>;

  LOrdinal := OrdinalOf(AEnumValue);

  if (LOrdinal <= EnumTypeData<T>.MinValue) or (LOrdinal > EnumTypeData<T>.MaxValue) then
    Result := FromOrdinal<T>(EnumTypeData<T>.MaxValue)
  else
    Result := FromOrdinal<T>(LOrdinal - 1);
end;

// Usage: TEnumHelper.SetToString(Font.Style) = 'fsBold,fsItalic', with ABrackets '[fsBold,fsItalic]'
class function TEnumHelper.SetToString<TSet>(const ASet: TSet; const ABrackets: Boolean = False): string;
begin
  CheckSetType<TSet>;

  Result := System.TypInfo.SetToString(PTypeInfo(TypeInfo(TSet)), @ASet, ABrackets);
end;

class function TEnumHelper.StringToEnumDef<T>(const AEnumString: string; const ADefault: T;
  const AAllowStrippedName: Boolean = False): T;
begin
  if not TryStringToEnum<T>(AEnumString, Result, AAllowStrippedName) then
    Result := ADefault;
end;

class function TEnumHelper.StringToSet<TSet>(const ASetString: string): TSet;
begin
  if not TryStringToSet<TSet>(ASetString, Result) then
    raise EArgumentException.CreateFmt('"%s" is not a valid value of %s', [ASetString, GetTypeName(TypeInfo(TSet))]);
end;

class function TEnumHelper.TryIntegerToEnum<T>(const AIntegerValue: Integer; var AEnumValue: T): Boolean;
begin
  Result := IntegerInRange<T>(AIntegerValue);

  if Result then
    AEnumValue := FromOrdinal<T>(AIntegerValue)
  else
    AEnumValue := Low<T>;
end;

// On failure AEnumValue is Low, which is always a valid value (Default(T) is not, for a subrange not starting at 0)
class function TEnumHelper.TryStringToEnum<T>(const AEnumString: string; var AEnumValue: T;
  const AAllowStrippedName: Boolean = False): Boolean;
var
  LOrdinal: Integer;
begin
  CheckEnumType<T>;

  Result := TryNameToOrdinal<T>(AEnumString, AAllowStrippedName, LOrdinal);

  if Result then
    AEnumValue := FromOrdinal<T>(LOrdinal)
  else
    AEnumValue := Low<T>;
end;

// Accepts the SetToString format with or without brackets; '' and '[]' give an empty set. On failure ASet is empty.
class function TEnumHelper.TryStringToSet<TSet>(const ASetString: string; var ASet: TSet): Boolean;
begin
  CheckSetType<TSet>;

  FillChar(ASet, SizeOf(TSet), 0);

  Result := TrySetElementsValid<TSet>(ASetString);

  if Result then
    System.TypInfo.StringToSet(PTypeInfo(TypeInfo(TSet)), ASetString, @ASet);
end;

// Usage: for LAlign in TEnumHelper.Values<TAlign> do
class function TEnumHelper.Values<T>: TArray<T>;
var
  LIndex: Integer;
  LMinValue: Integer;
begin
  CheckEnumType<T>;

  LMinValue := EnumTypeData<T>.MinValue;

  SetLength(Result, Count<T>);

  for LIndex := 0 to System.High(Result) do
    Result[LIndex] := FromOrdinal<T>(LMinValue + LIndex);
end;

// Raises EArgumentException for a name that is not a value of the type, and leaves AEnumValue as it was
class procedure TEnumHelper.StringToEnum<T>(const AEnumString: string; var AEnumValue: T;
  const AAllowStrippedName: Boolean = False);
var
  LOrdinal: Integer;
begin
  CheckEnumType<T>;

  if not TryNameToOrdinal<T>(AEnumString, AAllowStrippedName, LOrdinal) then
    raise EArgumentException.CreateFmt('"%s" is not a valid value of %s', [AEnumString, GetTypeName(TypeInfo(T))]);

  AEnumValue := FromOrdinal<T>(LOrdinal);
end;

end.
