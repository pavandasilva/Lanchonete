object frmClientes: TfrmClientes
  Left = 0
  Top = 0
  Caption = 'frmClientes'
  ClientHeight = 560
  ClientWidth = 758
  Color = 8876339
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clHighlightText
  Font.Height = -17
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 23
  object pnEdicao: TPanel
    Left = 0
    Top = 0
    Width = 758
    Height = 560
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 411
      Top = 131
      Width = 64
      Height = 23
      Caption = 'Telefone:'
    end
    object Label2: TLabel
      Left = 49
      Top = 263
      Width = 46
      Height = 23
      Caption = 'Bairro:'
    end
    object Label3: TLabel
      Left = 577
      Top = 131
      Width = 54
      Height = 23
      Caption = 'Celular:'
    end
    object Label4: TLabel
      Left = 49
      Top = 196
      Width = 74
      Height = 23
      Caption = 'Endere'#231'o:'
    end
    object lbNome: TLabel
      Left = 50
      Top = 131
      Width = 49
      Height = 23
      Caption = 'Nome:'
    end
    object Label5: TLabel
      Left = 50
      Top = 59
      Width = 58
      Height = 23
      Caption = 'C'#243'digo:'
    end
    object DBedtNome: TDBEdit
      Left = 50
      Top = 154
      Width = 331
      Height = 36
      ParentCustomHint = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -20
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
    end
    object DBedtTel: TDBEdit
      Left = 413
      Top = 154
      Width = 132
      Height = 36
      ParentCustomHint = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -20
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
    end
    object DBedtCel: TDBEdit
      Left = 577
      Top = 154
      Width = 132
      Height = 36
      ParentCustomHint = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -20
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
    end
    object DBedtEnd: TDBEdit
      Left = 49
      Top = 221
      Width = 660
      Height = 36
      ParentCustomHint = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -20
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
    end
    object DBedtBairro: TDBEdit
      Left = 49
      Top = 289
      Width = 660
      Height = 36
      ParentCustomHint = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -20
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
    end
    object DBCodigo: TDBEdit
      Left = 50
      Top = 82
      Width = 73
      Height = 36
      ParentCustomHint = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -20
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
end
