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
    VQry.Open('SELECT coalesce(MAX(ID),0)+1 AS ID FROM PEDIDO');
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
    VQry.ExecSQL('insert into PEDIDO (ID, NUMPEDIDO, DATAEMISSAO, CODCLIENTE) values (:ID, :NUMPEDIDO, :DATAEMISSAO, :CODCLIENTE)',
                  [APedidovendaModel.ID,APedidovendaModel.NUMPEDIDO, APedidovendaModel.DATAEMISSAO, APedidovendaModel.CODCLIENTE]);

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
    VQry.ExecSQL('update PEDIDO set NUMPEDIDO=:NUMPEDIDO, DATAEMISSAO = :DATAEMISSAO, CODCLIENTE=:CODCLIENTE where (ID = :ID)',
                 [APedidovendaModel.ID,APedidovendaModel.NUMPEDIDO, APedidovendaModel.DATAEMISSAO, APedidovendaModel.CODCLIENTE]);

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
    VQry.ExecSQL('delete from PEDIDO where ID = :ID',
                  [APedidovendaModel.ID]);

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
    VQry.Open('select ID, NUMPEDI , DATA_EMISSAO, COD_CLIENTE from PEDIDO order by 1')
  else
    VQry.Open('select ID, NUMPEDI , DATA_EMISSAO, COD_CLIENTE from PEDIDO WHERE NUMPEDI=' + QUOTEDSTR(AValorpesquisa) + ' order by 1');

  Result := VQry;
end;

end.
