object DEDemoMainForm: TDEDemoMainForm
  Left = 0
  Top = 0
  Caption = 'DEForm.DemoMain'
  ClientHeight = 339
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    651
    339)
  TextHeight = 15
  object ButtonDemoThings: TButton
    Left = 533
    Top = 8
    Width = 110
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Demo things'
    TabOrder = 0
    OnClick = ButtonDemoThingsClick
  end
  object MemoLog: TMemo
    Left = 8
    Top = 8
    Width = 519
    Height = 323
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
end
