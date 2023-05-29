unit uPedidovendaDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uPedidovendaModel, System.SysUtils, uSistemaControl;

type
  TPedidovendaDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;

      function Incluir(APedidovendaModel: TPedidovendaModel): Boolean;
      function Alterar(APedidovendaModel: TPedidovendaModel): Boolean;
      function Excluir(APedidovendaModel: TPedidovendaModel): Boolean;
      function GetId: Integer;
      function Obter(AValorpesquisa: string): TFDQuery;

  end;

implementation

{ TPedidovendaDAO }

constructor TPedidovendaDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TPedidovendaDAO.GetId: Integer;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('SELECT coalesce(MAX(NUMPEDIDO),0)+1 AS NUMPEDIDO FROM tb_pedidovenda');
    try
      Result := VQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TPedidovendaDAO.Incluir(APedidovendaModel: TPedidovendaModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into tb_pedidovenda (NUMPEDIDO, DATAEMISSAO, CODCLIENTE, VALOR_TOTAL) values (:NUMPEDIDO, :DATAEMISSAO, :CODCLIENTE, :VALOR_TOTAL)',
                  [APedidovendaModel.NUMPEDIDO, APedidovendaModel.DATAEMISSAO, APedidovendaModel.CODCLIENTE, APedidovendaModel.VALORTOTAL]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TPedidovendaDAO.Alterar(APedidovendaModel: TPedidovendaModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('update tb_pedidovenda set DATAEMISSAO = :DATAEMISSAO, CODCLIENTE=:CODCLIENTE, VALOR_TOTAL=:VALOR_TOTAL where (NUMPEDIDO = :NUMPEDIDO)',
                 [APedidovendaModel.NUMPEDIDO, APedidovendaModel.DATAEMISSAO, APedidovendaModel.CODCLIENTE, APedidovendaModel.VALORTOTAL]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TPedidovendaDAO.Excluir(APedidovendaModel: TPedidovendaModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete from tb_pedidovenda where (NUMPEDIDO = :NUMPEDIDO)',
                  [APedidovendaModel.NUMPEDIDO]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TPedidovendaDAO.Obter(AValorpesquisa: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();

  if AValorpesquisa = '' then
    VQry.Open('select NUMPEDIDO , DATAEMISSAO, CODCLIENTE, VALOR_TOTAL from tb_pedidovenda order by 1')
  else
    VQry.Open('select NUMPEDIDO , DATAEMISSAO, CODCLIENTE, VALOR_TOTAL from tb_pedidovenda WHERE NUMPEDIDO=' + QUOTEDSTR(AValorpesquisa) + ' order by 1');

  Result := VQry;
end;

end.
