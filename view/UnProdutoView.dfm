object frmProdutoView: TfrmProdutoView
  Left = 0
  Top = 0
  Caption = 'frmProdutoView'
  ClientHeight = 417
  ClientWidth = 915
  Color = 8876339
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clHighlightText
  Font.Height = -17
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 23
  object pnEdicao: TPanel
    Left = 0
    Top = 0
    Width = 915
    Height = 417
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 801
    ExplicitHeight = 512
    object Label2: TLabel
      Left = 25
      Top = 175
      Width = 46
      Height = 23
      Caption = 'Pre'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 25
      Top = 127
      Width = 101
      Height = 23
      Caption = 'Tipo Unidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object lbNome: TLabel
      Left = 26
      Top = 29
      Width = 49
      Height = 23
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 26
      Top = 77
      Width = 74
      Height = 23
      Caption = 'Categoria:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object edtNome: TEdit
      Left = 25
      Top = 50
      Width = 551
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alCustom
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clHighlightText
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object cbUnidade: TComboBox
      Left = 25
      Top = 148
      Width = 144
      Height = 31
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clWhite
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      OnKeyPress = cbUnidadeKeyPress
    end
    object cbCategoria: TComboBox
      Left = 26
      Top = 99
      Width = 144
      Height = 31
      AutoComplete = False
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clHighlightText
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnKeyPress = cbCategoriaKeyPress
    end
    object edtPreco: TEdit
      Left = 26
      Top = 198
      Width = 143
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alCustom
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clHighlightText
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
    end
  end
end
