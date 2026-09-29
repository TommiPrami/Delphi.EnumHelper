object DEDemoMainForm: TDEDemoMainForm
  Left = 0
  Top = 0
  Caption = 'DEForm.DemoMain'
  ClientHeight = 339
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    700
    339)
  TextHeight = 15
  object LabelAlignment: TLabel
    Left = 541
    Top = 233
    Width = 92
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Memo alignment'
  end
  object ButtonDemoThings: TButton
    Left = 541
    Top = 8
    Width = 151
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Demo things'
    TabOrder = 0
    OnClick = ButtonDemoThingsClick
  end
  object MemoLog: TMemo
    Left = 8
    Top = 8
    Width = 527
    Height = 323
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 8
  end
  object ButtonListValues: TButton
    Left = 541
    Top = 39
    Width = 151
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'List all values'
    TabOrder = 1
    OnClick = ButtonListValuesClick
  end
  object ButtonCycleAlignment: TButton
    Left = 541
    Top = 70
    Width = 151
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Cycle memo alignment'
    TabOrder = 2
    OnClick = ButtonCycleAlignmentClick
  end
  object ButtonIntegerInRange: TButton
    Left = 541
    Top = 101
    Width = 151
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Validate integers'
    TabOrder = 3
    OnClick = ButtonIntegerInRangeClick
  end
  object ButtonInvalidString: TButton
    Left = 541
    Top = 132
    Width = 151
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Invalid string'
    TabOrder = 4
    OnClick = ButtonInvalidStringClick
  end
  object ButtonSaveAndLoadAsText: TButton
    Left = 541
    Top = 163
    Width = 151
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save and load as text'
    TabOrder = 5
    OnClick = ButtonSaveAndLoadAsTextClick
  end
  object ButtonAssignedValues: TButton
    Left = 541
    Top = 194
    Width = 151
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Assigned values enum'
    TabOrder = 6
    OnClick = ButtonAssignedValuesClick
  end
  object ComboBoxAlignment: TComboBox
    Left = 541
    Top = 252
    Width = 151
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    TabOrder = 7
    OnChange = ComboBoxAlignmentChange
  end
end
