object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = #220'bung'
  ClientHeight = 644
  ClientWidth = 983
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 977
    Height = 601
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object BtnListeErstellen: TButton
    Left = 8
    Top = 610
    Width = 102
    Height = 25
    Caption = 'Liste erstellen'
    TabOrder = 1
    OnClick = BtnListeErstellenClick
  end
end
