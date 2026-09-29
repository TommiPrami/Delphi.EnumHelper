unit Delphi.EnumHelper;

interface

{$UNDEF DEBUG_AND_ASSERTS}

{$IFDEF DEBUG}
  {$IFOPT C+}
    {$DEFINE DEBUG_AND_ASSERTS}
  {$ENDIF}
{$ENDIF}

  // Usage: LEnumNameStr := TEnumHelper.EnumToString(FormMain.BorderStyle);
type
  TEnumHelper = class
  protected
{$IFDEF DEBUG_AND_ASSERTS}
    class procedure DoSanityCheck<T>(const AEnumValue: T);
{$ENDIF}
  public
    class function EnumToInt<T>(const AEnumValue: T): Integer;
    class function EnumToString<T>(const AEnumValue: T; const AStripLowercasePrefix: Boolean = False): string;
    class function High<T>(const AEnumValue: T): T;
    class function HighAsInteger<T>(const AEnumValue: T): Integer;
    class function IntegerInRange<T>(const AEnumValue: T; const AIntegrValue: Integer): Boolean;
    class function Low<T>(const AEnumValue: T): T;
    class function LowAsInteger<T>(const AEnumValue: T): Integer;
    class function NextValue<T>(const AEnumValue: T): T;
    class function PreviousValue<T>(const AEnumValue: T): T;
    class procedure StringToEnum<T>(const AEnumString: string; var AEnumValue: T);
  end;

implementation

uses
  System.Character, System.Math, System.Rtti, System.SysUtils, System.TypInfo;

{$IFDEF DEBUG_AND_ASSERTS}
class procedure TEnumHelper.DoSanityCheck<T>(const AEnumValue: T);
begin
  Assert(TTypeInfo(TypeInfo(T)^).Kind = tkEnumeration, 'Only Enumeration types supported');
end;
{$ENDIF}

class function TEnumHelper.EnumToInt<T>(const AEnumValue: T): Integer;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}
  Result := 0;

  Move(AEnumValue, Result, SizeOf(AEnumValue));
end;

class function TEnumHelper.EnumToString<T>(const AEnumValue: T; const AStripLowercasePrefix: Boolean = False): string;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  Result := GetEnumName(TypeInfo(T), EnumToInt(AEnumValue));

  if AStripLowercasePrefix and not Result.IsEmpty then
  begin
    var LIndex: Integer := 1;
    var LResultLength := Length(Result);

    while (LIndex <= LResultLength) and Result[LIndex].IsLower do
      Inc(LIndex);

    // All lowercase name has no prefix to strip
    if LIndex <= LResultLength then
      Result := Copy(Result, LIndex, LResultLength);
  end;
end;

class procedure TEnumHelper.StringToEnum<T>(const AEnumString: string; var AEnumValue: T);
var 
  LTYpeInfo: Pointer;
  LEnumValue: Integer;
  PEnumTemp: Pointer;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LTYpeInfo := TypeInfo(T);
  LEnumValue:= GetEnumValue(LTYpeInfo, AEnumString);

  // GetEnumValue returns -1 for unknown names, and names of the base type for subranges
  if not InRange(LEnumValue, GetTypeData(LTYpeInfo).MinValue, GetTypeData(LTYpeInfo).MaxValue) then
    raise EArgumentException.CreateFmt('"%s" is not a valid value of %s', [AEnumString, GetTypeName(LTYpeInfo)]);

  PEnumTemp := @LEnumValue;

  AEnumValue :=  T(PEnumTemp^);
end;

// Stops at High, out of range values are clamped between Low and High
class function TEnumHelper.NextValue<T>(const AEnumValue: T): T;
var
  LValueOfEnum: TValue;
  LTypeData: PTypeData;
  LIntValue: Integer;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  LTypeData := LValueOfEnum.TypeInfo.TypeData;
  LIntValue := EnsureRange(LValueOfEnum.AsOrdinal + 1, LTypeData.MinValue, LTypeData.MaxValue);

  Result := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LIntValue).AsType<T>;
end;

// Stops at Low, out of range values are clamped between Low and High
class function TEnumHelper.PreviousValue<T>(const AEnumValue: T): T;
var
  LValueOfEnum: TValue;
  LTypeData: PTypeData;
  LIntValue: Integer;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  LTypeData := LValueOfEnum.TypeInfo.TypeData;
  LIntValue := EnsureRange(LValueOfEnum.AsOrdinal - 1, LTypeData.MinValue, LTypeData.MaxValue);

  Result := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LIntValue).AsType<T>;
end;

class function TEnumHelper.High<T>(const AEnumValue: T): T;
var
  LValueOfEnum: TValue;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  LValueOfEnum := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LValueOfEnum.TypeInfo.TypeData.MaxValue);
  Result := LValueOfEnum.AsType<T>;
end;

class function TEnumHelper.Low<T>(const AEnumValue: T): T;
var
  LValueOfEnum: TValue;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  LValueOfEnum := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LValueOfEnum.TypeInfo.TypeData.MinValue);
  Result := LValueOfEnum.AsType<T>;
end;

class function TEnumHelper.HighAsInteger<T>(const AEnumValue: T): Integer;
var
  LValueOfEnum: TValue;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  Result := LValueOfEnum.TypeInfo.TypeData.MaxValue;
end;

class function TEnumHelper.IntegerInRange<T>(const AEnumValue: T; const AIntegrValue: Integer): Boolean;
begin
  Result := InRange(AIntegrValue, LowAsInteger(AEnumValue), HighAsInteger(AEnumValue));
end;

class function TEnumHelper.LowAsInteger<T>(const AEnumValue: T): Integer;
var
  LValueOfEnum: TValue;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  Result := LValueOfEnum.TypeInfo.TypeData.MinValue;
end;

end.
