unit uClienteDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uClienteModel, System.SysUtils, uSistemaControl;

type
  TClienteDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Incluir(AClienteModel: TClienteModel): Boolean;
    function Alterar(AClienteModel: TClienteModel): Boolean;
    function Excluir(AClienteModel: TClienteModel): Boolean;
    function GetId: Integer;
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterCLIByID(AValorpesquisa: string): TFDQuery;
  end;

implementation

{ TClienteDao }

constructor TClienteDao.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TClienteDao.GetId: Integer;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('SELECT coalesce(MAX(CODIGO),0)+1 AS CODIGO FROM CLIENTES');
    try
      Result := VQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TClienteDao.Incluir(AClienteModel: TClienteModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into CLIENTES (codigo,         '+
                 '                      nome,           '+
                 '                      endereco,       '+
                 '                      bairro,         '+
                 '                      Cidade,         '+
                 '                      numero,         '+
                 '                      Cep,            '+
                 '                      UF) values (    '+
                 '                      :codigo,        '+
                 '                      :nome,          '+
                 '                      :endereco,      '+
                 '                      :bairro,        '+
                 '                      :Cidade,        '+
                 '                      :numero,        '+
                 '                      :Cep,           '+
                 '                      :UF)            ',
                 [AClienteModel.Codigo,
                  AClienteModel.Nome,
                  AClienteModel.Endereco,
                  AClienteModel.Bairro,
                  AClienteModel.Cidade,
                  AClienteModel.Numero,
                  AClienteModel.Cep,
                  AClienteModel.UF]);

    VQry.Connection.Commit;
    VQry.Connection.CommitRetaining;
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TClienteDao.Excluir(AClienteModel: TClienteModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete from CLIENTES where codigo =:codigo', [AClienteModel.Codigo]);

    VQry.Connection.Commit;
    VQry.Connection.CommitRetaining;
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TClienteDao.Alterar(AClienteModel: TClienteModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('update CLIENTES set nome     =:nome      '+
                 '                    endereco =:endereco, '+
                 '                    bairro   =:bairro,   '+
                 '                    Cidade   =:Cidade,   '+
                 '                    numero   =:numero,   '+
                 '                    Cep      =:Cep,      '+
                 '                    UF       =:UF        '+
                 'where Codigo =:Codigo                    ',
                 [AClienteModel.Codigo,
                  AClienteModel.Nome,
                  AClienteModel.Endereco,
                  AClienteModel.Bairro,
                  AClienteModel.Cidade,
                  AClienteModel.Numero,
                  AClienteModel.Cep,
                  AClienteModel.UF]);

    VQry.Connection.Commit;
    VQry.Connection.CommitRetaining;
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TClienteDao.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  if AValorparcial = '' then
    VQry.Open('select codigo, nome, endereco, bairro, Cidade, numero, Cep, UF from CLIENTES order by '+AorderBy.ToString)
  else
     VQry.Open('select codigo, nome, endereco, bairro, Cidade, numero, Cep, UF from CLIENTES where NOME like ' + quotedstr(AValorparcial) + ' order by '+AorderBy.ToString);

  Result := VQry;
end;

function TClienteDao.ObterCLIByID(AValorpesquisa: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  VQry.Open('select codigo, nome, endereco, bairro, Cidade, numero, Cep, UF from CLIENTES where codigo = '+AValorpesquisa);

  Result := VQry;
end;

end.
