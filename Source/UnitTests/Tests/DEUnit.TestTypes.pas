unit DEUnit.TestTypes;

{ Types the unit tests run TEnumHelper against. Each enumeration covers a different shape: typical lowercase
  prefix, single value, no prefix at all, all-lowercase names, scoped, Unicode names, subranges, forced storage
  sizes and enums large enough to need one and two bytes of storage. TTestWindow has enumeration properties, like
  TForm.BorderStyle, without pulling VCL into the tests. }

interface

uses
  System.Classes;

type
  TTestColor = (tcRed, tcGreen, tcBlue, tcYellow, tcBlack);

  TTestColorSubRange = tcGreen..tcYellow;

  // Same values as TFormBorderStyle in Vcl.Forms
  TTestBorderStyle = (bsNone, bsSingle, bsSizeable, bsDialog, bsToolWindow, bsSizeToolWin);

  // Same subrange as TBorderStyle in Vcl.Forms
  TTestBorderStyleSubRange = bsNone..bsSingle;

  TTestSingle = (tsOnly);

  TTestNoPrefix = (Alpha, Beta, Gamma);

  TTestAllLowercase = (lowerone, lowertwo);

  TTestDigits = (x1Value, abc123, n9);

  TTestUnicode = (äÄiti, öÖljy, ålandÅ);

{$SCOPEDENUMS ON}
  TTestScoped = (First, Second, Third);
{$SCOPEDENUMS OFF}

{$MINENUMSIZE 2}
  TTestTwoBytes = (tbZero, tbOne, tbTwo);
{$MINENUMSIZE 4}
  TTestFourBytes = (fbZero, fbOne, fbTwo, fbThree);
{$MINENUMSIZE 1}

  // Exactly 256 values: still fits one byte, last value has ordinal 255
  TTestByteFull = (
    e000, e001, e002, e003, e004, e005, e006, e007, e008, e009, e010, e011, e012, e013, e014, e015, e016, e017, e018, e019, e020,
    e021, e022, e023, e024, e025, e026, e027, e028, e029, e030, e031, e032, e033, e034, e035, e036, e037, e038, e039, e040, e041,
    e042, e043, e044, e045, e046, e047, e048, e049, e050, e051, e052, e053, e054, e055, e056, e057, e058, e059, e060, e061, e062,
    e063, e064, e065, e066, e067, e068, e069, e070, e071, e072, e073, e074, e075, e076, e077, e078, e079, e080, e081, e082, e083,
    e084, e085, e086, e087, e088, e089, e090, e091, e092, e093, e094, e095, e096, e097, e098, e099, e100, e101, e102, e103, e104,
    e105, e106, e107, e108, e109, e110, e111, e112, e113, e114, e115, e116, e117, e118, e119, e120, e121, e122, e123, e124, e125,
    e126, e127, e128, e129, e130, e131, e132, e133, e134, e135, e136, e137, e138, e139, e140, e141, e142, e143, e144, e145, e146,
    e147, e148, e149, e150, e151, e152, e153, e154, e155, e156, e157, e158, e159, e160, e161, e162, e163, e164, e165, e166, e167,
    e168, e169, e170, e171, e172, e173, e174, e175, e176, e177, e178, e179, e180, e181, e182, e183, e184, e185, e186, e187, e188,
    e189, e190, e191, e192, e193, e194, e195, e196, e197, e198, e199, e200, e201, e202, e203, e204, e205, e206, e207, e208, e209,
    e210, e211, e212, e213, e214, e215, e216, e217, e218, e219, e220, e221, e222, e223, e224, e225, e226, e227, e228, e229, e230,
    e231, e232, e233, e234, e235, e236, e237, e238, e239, e240, e241, e242, e243, e244, e245, e246, e247, e248, e249, e250, e251,
    e252, e253, e254, e255
  );

  // 300 values: needs two bytes of storage
  TTestWord = (
    w000, w001, w002, w003, w004, w005, w006, w007, w008, w009, w010, w011, w012, w013, w014, w015, w016, w017, w018, w019, w020,
    w021, w022, w023, w024, w025, w026, w027, w028, w029, w030, w031, w032, w033, w034, w035, w036, w037, w038, w039, w040, w041,
    w042, w043, w044, w045, w046, w047, w048, w049, w050, w051, w052, w053, w054, w055, w056, w057, w058, w059, w060, w061, w062,
    w063, w064, w065, w066, w067, w068, w069, w070, w071, w072, w073, w074, w075, w076, w077, w078, w079, w080, w081, w082, w083,
    w084, w085, w086, w087, w088, w089, w090, w091, w092, w093, w094, w095, w096, w097, w098, w099, w100, w101, w102, w103, w104,
    w105, w106, w107, w108, w109, w110, w111, w112, w113, w114, w115, w116, w117, w118, w119, w120, w121, w122, w123, w124, w125,
    w126, w127, w128, w129, w130, w131, w132, w133, w134, w135, w136, w137, w138, w139, w140, w141, w142, w143, w144, w145, w146,
    w147, w148, w149, w150, w151, w152, w153, w154, w155, w156, w157, w158, w159, w160, w161, w162, w163, w164, w165, w166, w167,
    w168, w169, w170, w171, w172, w173, w174, w175, w176, w177, w178, w179, w180, w181, w182, w183, w184, w185, w186, w187, w188,
    w189, w190, w191, w192, w193, w194, w195, w196, w197, w198, w199, w200, w201, w202, w203, w204, w205, w206, w207, w208, w209,
    w210, w211, w212, w213, w214, w215, w216, w217, w218, w219, w220, w221, w222, w223, w224, w225, w226, w227, w228, w229, w230,
    w231, w232, w233, w234, w235, w236, w237, w238, w239, w240, w241, w242, w243, w244, w245, w246, w247, w248, w249, w250, w251,
    w252, w253, w254, w255, w256, w257, w258, w259, w260, w261, w262, w263, w264, w265, w266, w267, w268, w269, w270, w271, w272,
    w273, w274, w275, w276, w277, w278, w279, w280, w281, w282, w283, w284, w285, w286, w287, w288, w289, w290, w291, w292, w293,
    w294, w295, w296, w297, w298, w299
  );

  TEnumWithAssignedValues = (ewavFirst = -1, ewavSecond = 0, ewavThird = 1);

  // A set can't hold negative values, so the no RTTI set test uses positive assigned values
  TEnumWithPositiveAssignedValues = (ewpavOne = 1, ewpavThree = 3);

  TEnumWithPositiveAssignedValuesSet = set of TEnumWithPositiveAssignedValues;

  // Stripped names Foo, Foo and Bar: Foo is ambiguous, Bar is not
  TTestAmbiguousStripped = (abFoo, cdFoo, abBar);

  TTestColors = set of TTestColor;

  TTestColorSubRangeSet = set of TTestColorSubRange;

  // 256 elements, 32 bytes: larger than an Integer
  TTestByteFullSet = set of TTestByteFull;

  // Enumeration properties defaulting like TForm does (BorderStyle = bsSizeable)
  TTestWindow = class(TPersistent)
  strict private
    FBorderStyle: TTestBorderStyle;
    FColor: TTestColor;
  public
    constructor Create;
  published
    property BorderStyle: TTestBorderStyle read FBorderStyle write FBorderStyle default bsSizeable;
    property Color: TTestColor read FColor write FColor default tcBlue;
  end;

const
  EXPECTED_VALIDATE_INTEGERS_LOG =
    '-1 is not valid TTestBorderStyle' + sLineBreak +
    '0 is valid TTestBorderStyle: bsNone' + sLineBreak +
    '1 is valid TTestBorderStyle: bsSingle' + sLineBreak +
    '2 is valid TTestBorderStyle: bsSizeable' + sLineBreak +
    '3 is valid TTestBorderStyle: bsDialog' + sLineBreak +
    '4 is valid TTestBorderStyle: bsToolWindow' + sLineBreak +
    '5 is valid TTestBorderStyle: bsSizeToolWin' + sLineBreak +
    '6 is not valid TTestBorderStyle' + sLineBreak +
    '7 is not valid TTestBorderStyle' + sLineBreak;

implementation

{ TTestWindow }

constructor TTestWindow.Create;
begin
  inherited Create;

  FBorderStyle := bsSizeable;
  FColor := tcBlue;
end;


end.
