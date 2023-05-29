unit uPedidoXProdutosDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uPedidoXProdutosModel, System.SysUtils, uSistemaControl;

type
  TPedidoXProdutosDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;

      function Incluir(APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
      function Alterar(APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
      function Excluir(APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
      function GetId: Integer;
      function Obter(AValorpesquisa: string): TFDQuery;

  end;

implementation

{ TPedidoXProdutosDAO }

constructor TPedidoXProdutosDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TPedidoXProdutosDAO.GetId: Integer;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('SELECT coalesce(MAX(ID_PEDIDO),0)+1 AS ID_PEDIDO FROM PEDIDO_PRODUTOS');
    try
      Result := VQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TPedidoXProdutosDAO.Incluir(
  APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into PEDIDO_PRODUTOS (ID_PEDIDO, ID_PRODUTO, NUMPEDIDO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL) values (:ID_PEDIDO, :ID_PRODUTO, :NUMPEDIDO, :QUANTIDADE, :VALOR_UNITARIO, :VALOR_TOTAL)',
                  [
                    APedidoXProdutosModel.ID,
                    APedidoXProdutosModel.CODPRODUTO,
                    APedidoXProdutosModel.NUMPEDIDO,
                    APedidoXProdutosModel.QUANTIDADE,
                    APedidoXProdutosModel.VALORUNITARIO,
                    APedidoXProdutosModel.VALORTOTAL
                   ]
                  );

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TPedidoXProdutosDAO.Alterar(
  APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into PEDIDO_PRODUTOS (ID_PEDIDO, ID_PRODUTO, NUMPEDIDO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL) values (:ID_PEDIDO, :ID_PRODUTO, :NUMPEDIDO, :QUANTIDADE, :VALOR_UNITARIO, :VALOR_TOTAL)',
                  [
                    APedidoXProdutosModel.ID,
                    APedidoXProdutosModel.CODPRODUTO,
                    APedidoXProdutosModel.NUMPEDIDO,
                    APedidoXProdutosModel.QUANTIDADE,
                    APedidoXProdutosModel.VALORUNITARIO,
                    APedidoXProdutosModel.VALORTOTAL
                   ]
                  );
    Result := True;
  finally
    VQry.Free;
  end;
end;

function TPedidoXProdutosDAO.Excluir(
  APedidoXProdutosModel: TPedidoXProdutosModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete from PEDIDO_PRODUTOS where PEDIDO_PRODUTOS=:PEDIDO_PRODUTOS',
                  [APedidoXProdutosModel.ID]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TPedidoXProdutosDAO.Obter(AValorpesquisa: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  if AValorpesquisa = '' then
    VQry.Open('select ID_PEDIDO, ID_PRODUTO, NUMPEDIDO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL from PEDIDO_PRODUTOS order by 1')
  else
    VQry.Open('select ID_PEDIDO, ID_PRODUTO, NUMPEDIDO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL from PEDIDO_PRODUTOS WHERE NUMPEDIDO=' + quotedstr(AValorpesquisa) + ' order by 1');
  Result := VQry;
end;

end.
