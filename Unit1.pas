unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.RegularExpressions,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Phys.OracleDef, FireDAC.Phys.Oracle, Vcl.ExtCtrls,
  FireDAC.Moni.RemoteClient, FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    FDManager1: TFDManager;
    FDConnection1: TFDConnection;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    FDPhysOracleDriverLink1: TFDPhysOracleDriverLink;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ScrollBox1: TScrollBox;
    TabSheet2: TTabSheet;
    mmolog: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    edtUserName: TEdit;
    edtPassword: TEdit;
    mmoSql: TMemo;
    Button2: TButton;
    edtServerIp: TEdit;
    edtServeIinstanceName: TEdit;
    edtServerPort: TEdit;
    lblConnectionMessage: TLabel;
    chkTracing: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDMoniFlatFileClientLink1Output(ASender: TFDMoniClientLinkBase;
      const AClassName, AObjName, AMessage: string);
    procedure chkTracingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  if (FDConnection1.Connected) then
  begin
    FDConnection1.Close;
  end;
  lblConnectionMessage.Caption := '';
  FDConnection1.Params.Clear;
  FDConnection1.Params.Add('DriverID=Ora');
  FDConnection1.Params.Add
    ('Database=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + self.edtServerIp.Text +
    ')(PORT=' + self.edtServerPort.Text + ')))(CONNECT_DATA=(SERVICE_NAME=' + self.edtServeIinstanceName.Text + ')))');
  FDConnection1.Params.Add('User_Name=' + edtUserName.Text);
  FDConnection1.Params.Add('Password=' + edtPassword.Text);
  FDConnection1.Params.Add('CharacterSet=UTF8'); // 否则中文乱码
  FDConnection1.Params.Add('MonitorBy=FlatFile'); // 这个必须加
  try
    FDConnection1.Connected := True;
    FDConnection1.Params.SaveToFile(ExtractFilePath(ParamStr(0)) + 'db.config');

    lblConnectionMessage.Caption := '成功到服务器！';
  except
    on e: Exception do
    begin
      Application.MessageBox(PChar(e.Message), PChar(Caption), MB_OK + MB_ICONSTOP);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FDQuery1.Close;
  FDQuery1.Open(self.mmoSql.Text);
end;

procedure TForm1.chkTracingClick(Sender: TObject);
begin
  if (FDConnection1.ConnectionIntf <> nil) then
    FDConnection1.ConnectionIntf.Tracing := TCheckBox(Sender).Checked;
  self.FDMoniFlatFileClientLink1.Tracing := TCheckBox(Sender).Checked;
end;

procedure TForm1.FDMoniFlatFileClientLink1Output(ASender: TFDMoniClientLinkBase;
  const AClassName, AObjName, AMessage: string);
begin
  mmolog.Lines.Add(Format('%-40s', [AObjName]) + '-----' + AMessage);
end;

procedure TForm1.FormCreate(Sender: TObject);
  function getValue(input, pattern: string): string;
  begin
    if TRegEx.IsMatch(input, pattern) then
      Result := TRegEx.Match(input, pattern).Value.Split(['='])[1];
  end;

begin
  edtUserName.Text := 'user name';
  edtPassword.Text := 'password';
  edtServerIp.Text := '127.0.0.1';
  edtServerPort.Text := '1521';
  edtServeIinstanceName.Text := 'orcl';

  if FileExists(ExtractFilePath(ParamStr(0)) + 'db.config') then
  begin
    FDConnection1.Params.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'db.config');
    edtUserName.Text := FDConnection1.Params.UserName;
    edtPassword.Text := FDConnection1.Params.Password;
    edtServerIp.Text := getValue(FDConnection1.Params.Database, 'HOST=\d*\.\d*\.\d*\.\d*');
    edtServerPort.Text := getValue(FDConnection1.Params.Database, 'PORT=\w*');
    edtServeIinstanceName.Text := getValue(FDConnection1.Params.Database, 'SERVICE_NAME=\w*');
  end;

  lblConnectionMessage.Caption := '';
  mmoSql.Text := 'select sysdate from dual';
  mmolog.Clear;
end;

end.
