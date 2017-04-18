unit UnFirebirdConn;
interface
uses Data.FMTBcd, Data.DB, Data.SqlExpr, system.SysUtils, Data.DBXFirebird, IniFiles,
  UnShowMessages;
  type
    TFirebirdConn = class
    private
      FSQLConn : TSQLConnection;
      FSQLQuery : TSQLQuery;
      FTransaction : TTransactionDesc;
      FPathDB :  String;
      FUserName : String;
      FPassword : String;
      procedure LerIni;
      procedure ConfiguraConexao;
    public
      destructor  Destroy; override;
      property  SQLConn : TSQLConnection read FSQLConn;
      property  SQLQuery : TSQLQuery read FSQLQuery;
      property  Transaction : TTransactionDesc read FTransaction;
      procedure StartTransaction;
      procedure RollbackTransaction;
      procedure CommitTransaction;
      procedure CloseConection;
      procedure ClearQuery;
      procedure InsertSQL(ASql : String);
      procedure OpenSQL;
      procedure ExecuteSQL;
      constructor Create;

  end;
implementation
{ TFirebird }
procedure TFirebirdConn.StartTransaction;
var
  I : Integer;
begin
  FSQLConn.Close;
  FSQLConn.Open;
  FSQLConn.StartTransaction(FTransaction);
  FTransaction.TransactionID := Random(I);
end;
procedure TFirebirdConn.ClearQuery;
begin
  SQLQuery.Close;
  SQLQuery.SQL.Clear;
end;

procedure TFirebirdConn.CloseConection;
begin
  SQLQuery.Close;
  SQLConn.Close;
end;

procedure TFirebirdConn.CommitTransaction;
begin
  FSQLConn.Commit(FTransaction);
end;
procedure TFirebirdConn.ConfiguraConexao;
begin
  FSQLConn := TSQLConnection.Create(nil);
  FSQLQuery := TSQLQuery.Create(nil);
  FSQLConn.Close;
  FSQLConn.DriverName   :=  'Firebird';
  FSQLConn.LoginPrompt  :=  false;
  FSQLconn.Params.Add('Database=' +  FPathDB);
  FSQLconn.Params.Add('User_Name='+ FUserName);
  FSQLconn.Params.Add('Password=' +  FPassword);
  {configura o query}
  FSQLQuery.Close;
  FSQLQuery.SQLConnection:= FSQLConn;
end;

constructor TFirebirdConn.Create;
begin
  LerIni;
  try
    ConfiguraConexao;
  except
    frmShowMessages.showMessage(iError, 'Erro ao tentar conexão com o banco de dados. Verifique suas configurações indo em Configurações');
  end;
end;
destructor TFirebirdConn.Destroy;
begin
  FreeAndNil(FSQLQuery);
  FreeAndNil(FSQLConn);
  inherited;
end;
procedure TFirebirdConn.ExecuteSQL;
begin
  FSQLQuery.ExecSQL;
end;
procedure TFirebirdConn.InsertSQL(ASql : String);
begin
  FSQLQuery.Close;
  FSQLQuery.SQL.Clear;
  FSQLQuery.SQL.Append(ASql);
end;
procedure TFirebirdConn.LerIni;
var
  umIniFile : TIniFile;
begin
   umIniFile := TIniFile.Create('config/config.ini');
   FPathDB := umIniFile.ReadString('database','path','');
   FUserName := umIniFile.ReadString('database','user','');
   FPassword := umIniFile.ReadString('database','pass','');
   umIniFile.Free;
end;
procedure TFirebirdConn.OpenSQL;
begin
  SQLQuery.Open;
end;

procedure TFirebirdConn.RollbackTransaction;
begin
  SQLConn.Rollback(FTransaction);
end;

end.
