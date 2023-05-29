unit uProdutoDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uProdutoModel, System.SysUtils, uSistemaControl;

type
  TProdutoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Incluir(AProdutoModel: TProdutoModel): Boolean;
    function Alterar(AProdutoModel: TProdutoModel): Boolean;
    function Excluir(AProdutoModel: TProdutoModel): Boolean;
    function GetId: Integer;
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterProdDesc(AValorpesquisa: string): TFDQuery;

  end;

implementation

{ TProdutoDAO }

constructor TProdutoDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TProdutoDAO.GetId: Integer;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('SELECT coalesce(MAX(ID),0)+1 AS ID FROM PRODUTOS');
    try
      Result := VQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TProdutoDAO.Incluir(AProdutoModel: TProdutoModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into PRODUTOS (ID, CODIGO_BAR, DESCRICAO, PRECO_COMPRA, PRECO_VENDA, QTD_ESTOQUE) values (:ID, :CODIGO_BAR, :DESCRICAO, :PRECO_COMPRA, :PRECO_VENDA, :QTD_ESTOQUE)',
                  [AProdutoModel.Codigo, AProdutoModel.Codigobarra, AProdutoModel.Descricao, AProdutoModel.PRECOCOMPRA, AProdutoModel.PRECOVENDA, AProdutoModel.QTDEESTOQUE]);

    VQry.Connection.Commit;
    VQry.Connection.CommitRetaining;
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TProdutoDAO.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  if AValorparcial = '' then
    VQry.Open('select ID, CODIGO_BAR, DESCRICAO, PRECO_COMPRA, PRECO_VENDA, QTD_ESTOQUE from PRODUTOS order by ' + AorderBy.ToString)
  else
    VQry.Open('select ID, CODIGO_BAR, DESCRICAO, PRECO_COMPRA, PRECO_VENDA, QTD_ESTOQUE from PRODUTOS where DESCRICAO like '+ quotedstr(AValorparcial) + ' order by ' + AorderBy.ToString);

  Result := VQry;
end;

function TProdutoDAO.ObterProdDesc(AValorpesquisa: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  VQry.Open('select ID, CODIGO_BAR, DESCRICAO, PRECO_COMPRA, PRECO_VENDA, QTD_ESTOQUE from PRODUTOS where CODIGO = '+ quotedstr(AValorpesquisa));

  Result := VQry;
end;

function TProdutoDAO.Alterar(AProdutoModel: TProdutoModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('update PRODUTOS set CODIGO_BAR =:CODIGO_BAR, DESCRICAO =:DESCRICAO, PRECO_COMPRA=:PRECO_COMPRA, PRECO_VENDA=:PRECO_VENDA, QTD_ESTOQUE=:QTD_ESTOQUE where ID =:ID',
                 [AProdutoModel.DESCRICAO, AProdutoModel.PRECOVENDA, AProdutoModel.codigo]);

    VQry.Connection.Commit;
    VQry.Connection.CommitRetaining;
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TProdutoDAO.Excluir(AProdutoModel: TProdutoModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete from PRODUTOS where ID =:ID',
                  [AProdutoModel.Codigo]);

    VQry.Connection.Commit;
    VQry.Connection.CommitRetaining;
    Result := True;
  finally
    VQry.Free;
  end;
end;

end.
