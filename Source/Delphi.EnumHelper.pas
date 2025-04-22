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
    class function NextValue<T>(const AEnumValue: T): T;
    class function PreviousValue<T>(const AEnumValue: T): T;
    class function High<T>(const AEnumValue: T): T;
    class function Low<T>(const AEnumValue: T): T;
    class function HighAsInteger<T>(const AEnumValue: T): Integer;
    class function LowAsInteger<T>(const AEnumValue: T): Integer;
  end;

implementation

uses
  System.Character, System.Rtti, System.SysUtils, System.TypInfo;


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
    var LIndex: Integer := 0;
    var LResultLength := Length(Result);

    while LIndex <= LResultLength do
    begin
      Inc(LIndex);

      if not Result[LIndex].IsLower then
        Break;
    end;

    Result := Copy(Result, LIndex, LResultLength);
  end;
end;

class function TEnumHelper.NextValue<T>(const AEnumValue: T): T;
var
  LValueOfEnum: TValue;
  LMaxIntValue: Integer;
  LIntValue: Integer;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  LMaxIntValue := LValueOfEnum.TypeInfo.TypeData.MaxValue;
  LIntValue := LValueOfEnum.AsOrdinal;

  if LIntValue = LMaxIntValue then
    Result := AEnumValue
  else if LIntValue > LMaxIntValue then
  begin
    LValueOfEnum := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LMaxIntValue);
    Result := LValueOfEnum.AsType<T>;
  end
  else
  begin
    Inc(LIntValue);

    LValueOfEnum := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LIntValue);
    Result := LValueOfEnum.AsType<T>;
  end;
end;

class function TEnumHelper.PreviousValue<T>(const AEnumValue: T): T;
var
  LValueOfEnum: TValue;
  LMinIntValue: Integer;
  LIntValue: Integer;
begin
{$IFDEF DEBUG_AND_ASSERTS}
  DoSanityCheck(AEnumValue);
{$ENDIF}

  LValueOfEnum := TValue.From(AEnumValue);
  LMinIntValue := LValueOfEnum.TypeInfo.TypeData.MinValue;
  LIntValue := LValueOfEnum.AsOrdinal;

  if LIntValue = LMinIntValue then
    Result := AEnumValue
  else if LIntValue < LMinIntValue then
  begin
    LValueOfEnum := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LMinIntValue);
    Result := LValueOfEnum.AsType<T>;
  end
  else
  begin
    Dec(LIntValue);

    LValueOfEnum := TValue.FromOrdinal(LValueOfEnum.TypeInfo, LIntValue);
    Result := LValueOfEnum.AsType<T>;
  end;
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
