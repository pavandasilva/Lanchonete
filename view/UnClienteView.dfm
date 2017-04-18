object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'frmCliente'
  ClientHeight = 448
  ClientWidth = 929
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
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 923
    Height = 442
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 850
    ExplicitHeight = 607
    object Label1: TLabel
      AlignWithMargins = True
      Left = 17
      Top = 164
      Width = 64
      Height = 23
      Caption = 'Telefone:'
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 17
      Top = 116
      Width = 46
      Height = 23
      Caption = 'Bairro:'
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 17
      Top = 212
      Width = 54
      Height = 23
      Caption = 'Celular:'
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 17
      Top = 68
      Width = 74
      Height = 23
      Caption = 'Endere'#231'o:'
    end
    object lbNome: TLabel
      AlignWithMargins = True
      Left = 18
      Top = 21
      Width = 49
      Height = 23
      Caption = 'Nome:'
    end
    object edtNome: TEdit
      AlignWithMargins = True
      Left = 18
      Top = 42
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
      Color = clWhite
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
    object edtEndereco: TEdit
      AlignWithMargins = True
      Left = 17
      Top = 90
      Width = 552
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alCustom
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clWhite
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
    end
    object edtBairro: TEdit
      AlignWithMargins = True
      Left = 17
      Top = 138
      Width = 552
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alCustom
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
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
    end
    object meCelular: TMaskEdit
      AlignWithMargins = True
      Left = 18
      Top = 234
      Width = 167
      Height = 29
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      EditMask = ' !\(99\)00000-0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      MaxLength = 15
      ParentFont = False
      TabOrder = 4
      Text = ' (  )     -    '
    end
    object meTelefone: TMaskEdit
      AlignWithMargins = True
      Left = 18
      Top = 186
      Width = 163
      Height = 29
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      EditMask = ' !\(99\)0000-0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      MaxLength = 14
      ParentFont = False
      TabOrder = 3
      Text = ' (  )    -    '
    end
  end
end
