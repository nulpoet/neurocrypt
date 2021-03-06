object Form1: TForm1
  Left = 192
  Top = 108
  BorderStyle = bsDialog
  Caption = 
    'Neural Cryptography Machine (NCM) by Alexander Popovsky aka Cybe' +
    'rTrone 2009 (c)'
  ClientHeight = 557
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 17
    Top = 175
    Width = 345
    Height = 306
  end
  object Label4: TLabel
    Left = 23
    Top = 505
    Width = 57
    Height = 13
    Caption = 'Shared key:'
  end
  object Label5: TLabel
    Left = 32
    Top = 156
    Width = 196
    Height = 13
    Caption = 'Neural machine'#39's difference chart:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel
    Left = 296
    Top = 466
    Width = 33
    Height = 13
    Caption = 'Equal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel
    Left = 296
    Top = 175
    Width = 56
    Height = 13
    Caption = 'Not equal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 8
    Width = 232
    Height = 142
    Caption = 'Neural Machine'#39's Parameters'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 91
      Height = 13
      Caption = 'Hidden neurons (K)'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 82
      Height = 13
      Caption = 'Input neurons (N)'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 86
      Height = 13
      Caption = 'Weight'#39's range (L)'
    end
    object Label8: TLabel
      Left = 21
      Top = 102
      Width = 47
      Height = 13
      Caption = 'Run times'
    end
    object SpinEdit1: TSpinEdit
      Left = 113
      Top = 21
      Width = 121
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 0
      Value = 8
    end
    object SpinEdit2: TSpinEdit
      Left = 113
      Top = 43
      Width = 121
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 1
      Value = 12
    end
    object SpinEdit3: TSpinEdit
      Left = 113
      Top = 71
      Width = 120
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 2
      Value = 4
    end
    object SpinEdit4: TSpinEdit
      Left = 113
      Top = 99
      Width = 121
      Height = 22
      MaxValue = 100000
      MinValue = 1
      TabOrder = 3
      Value = 1
    end
  end
  object Button3: TButton
    Left = 256
    Top = 11
    Width = 96
    Height = 118
    Caption = 'SYNC'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button3Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 538
    Width = 709
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Press sync to syncronize neural machines...'
  end
  object GroupBox1: TGroupBox
    Left = 368
    Top = 0
    Width = 305
    Height = 161
    Caption = 'Neural Machine A'
    TabOrder = 3
    object StringGrid1: TStringGrid
      Left = 2
      Top = 15
      Width = 301
      Height = 144
      Align = alClient
      DefaultColWidth = 15
      DefaultRowHeight = 10
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 368
    Top = 160
    Width = 305
    Height = 161
    Caption = 'Neural Machine B'
    TabOrder = 4
    object StringGrid2: TStringGrid
      Left = 2
      Top = 15
      Width = 301
      Height = 144
      Align = alClient
      DefaultColWidth = 15
      DefaultRowHeight = 10
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Edit1: TEdit
    Left = 86
    Top = 502
    Width = 593
    Height = 21
    ReadOnly = True
    TabOrder = 5
  end
  object GroupBox4: TGroupBox
    Left = 376
    Top = 320
    Width = 305
    Height = 161
    Caption = 'Neural Machine C'
    TabOrder = 6
    object StringGrid3: TStringGrid
      Left = 2
      Top = 15
      Width = 301
      Height = 144
      Align = alClient
      DefaultColWidth = 15
      DefaultRowHeight = 10
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
end
