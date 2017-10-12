object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Oracle Connection Test'
  ClientHeight = 651
  ClientWidth = 763
  Color = clBtnFace
  Constraints.MinHeight = 401
  Constraints.MinWidth = 604
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Consolas'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    763
    651)
  PixelsPerInch = 96
  TextHeight = 14
  object PageControl1: TPageControl
    Left = 8
    Top = 9
    Width = 747
    Height = 633
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Test'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 739
        Height = 601
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          739
          601)
        object Label1: TLabel
          Left = 24
          Top = 16
          Width = 56
          Height = 14
          Caption = 'UserName'
        end
        object Label2: TLabel
          Left = 24
          Top = 47
          Width = 56
          Height = 14
          Caption = 'Password'
        end
        object Label4: TLabel
          Left = 24
          Top = 352
          Width = 21
          Height = 14
          Caption = 'Sql'
        end
        object Label3: TLabel
          Left = 24
          Top = 78
          Width = 56
          Height = 14
          Caption = 'ServerIp'
        end
        object Label5: TLabel
          Left = 24
          Top = 144
          Width = 140
          Height = 14
          Caption = 'Server Instance Name'
        end
        object Label6: TLabel
          Left = 24
          Top = 112
          Width = 70
          Height = 14
          Caption = 'ServerPort'
        end
        object lblConnectionMessage: TLabel
          Left = 302
          Top = 245
          Width = 70
          Height = 14
          Caption = 'ServerPort'
        end
        object Button1: TButton
          Left = 174
          Top = 199
          Width = 121
          Height = 25
          Caption = 'Test Connection'
          TabOrder = 6
          OnClick = Button1Click
        end
        object DBGrid1: TDBGrid
          Left = 174
          Top = 345
          Width = 411
          Height = 115
          Anchors = [akLeft, akTop, akRight]
          DataSource = DataSource1
          TabOrder = 9
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Consolas'
          TitleFont.Style = []
        end
        object edtUserName: TEdit
          Left = 174
          Top = 12
          Width = 121
          Height = 22
          TabOrder = 0
          Text = 'edtUserName'
        end
        object edtPassword: TEdit
          Left = 174
          Top = 44
          Width = 121
          Height = 22
          TabOrder = 1
          Text = 'edtPassword'
        end
        object mmoSql: TMemo
          Left = 174
          Top = 234
          Width = 411
          Height = 66
          Anchors = [akLeft, akTop, akRight]
          Lines.Strings = (
            'select sysdate from dual')
          TabOrder = 7
        end
        object Button2: TButton
          Left = 174
          Top = 310
          Width = 121
          Height = 25
          Caption = 'Execute'
          TabOrder = 8
          OnClick = Button2Click
        end
        object edtServerIp: TEdit
          Left = 174
          Top = 76
          Width = 121
          Height = 22
          TabOrder = 2
          Text = 'edtServerIp'
        end
        object edtServeIinstanceName: TEdit
          Left = 174
          Top = 140
          Width = 121
          Height = 22
          TabOrder = 4
          Text = 'edtServeIinstanceName'
        end
        object edtServerPort: TEdit
          Left = 174
          Top = 108
          Width = 121
          Height = 22
          TabOrder = 3
          Text = 'edtServerPort'
        end
        object chkTracing: TCheckBox
          Left = 174
          Top = 172
          Width = 97
          Height = 17
          Caption = 'Tracing'
          TabOrder = 5
          OnClick = chkTracingClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tracing'
      ImageIndex = 1
      object mmolog: TMemo
        Left = 0
        Top = 0
        Width = 739
        Height = 601
        Align = alClient
        Lines.Strings = (
          'select sysdate from dual')
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object FDManager1: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 288
    Top = 24
  end
  object FDConnection1: TFDConnection
    Left = 408
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 328
    Top = 304
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 256
    Top = 304
  end
  object FDPhysOracleDriverLink1: TFDPhysOracleDriverLink
    Left = 544
    Top = 24
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
    EventKinds = [ekError, ekCmdExecute, ekCmdDataIn, ekCmdDataOut]
    OnOutput = FDMoniFlatFileClientLink1Output
    FileColumns = [tiMsgText]
    FileEncoding = ecUTF8
    ShowTraces = False
    Left = 56
    Top = 144
  end
end
