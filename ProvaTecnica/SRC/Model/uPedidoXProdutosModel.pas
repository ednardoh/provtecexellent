unit uPedidoXProdutosModel;

interface

uses
  uEnumerado, FireDAC.Comp.Client;

type
  TPedidoXProdutosModel = class
    private
      FAcao: TAcao;
      FID: integer;
      FNUMPEDIDO: integer;
      FCODPRODUTO: string;
      FQUANTIDADE: double;
      FVALORUNITARIO: double;
      FVALORTOTAL: double;

      procedure SetAcao(const Value: TAcao);
      procedure SetID(const Value: integer);
      procedure SetNUMPEDIDO(const Value: integer);
      procedure SetCODPRODUTO(const Value: string);
      procedure SetQUANTIDADE(const Value: double);
      procedure SetVALORUNITARIO(const Value: double);
      procedure SetVALORTOTAL(const Value: double);
    public
      function Obter(AValorpesquisa: string): TFDQuery;
      function Salvar: Boolean;
      function GetId: Integer;

      property Acao: TAcao            read FAcao          write SetAcao;
      property ID: integer            read FID            write SetID;
      property NUMPEDIDO: integer     read FNUMPEDIDO     write SetNUMPEDIDO;
      property CODPRODUTO: string     read FCODPRODUTO    write SetCODPRODUTO;
      property QUANTIDADE: double     read FQUANTIDADE    write SetQUANTIDADE;
      property VALORUNITARIO: double  read FVALORUNITARIO write SetVALORUNITARIO;
      property VALORTOTAL: double     read FVALORTOTAL     write SetVALORTOTAL;

  end;

implementation

{ TPedidoXProdutosModel }

Uses uPedidoXProdutosDAO;

function TPedidoXProdutosModel.GetId: Integer;
var
  VPedidoXProdutosDAO: TPedidoXProdutosDAO;
begin
  VPedidoXProdutosDAO := TPedidoXProdutosDAO.Create;
  try
    Result := VPedidoXProdutosDAO.GetId;
  finally
    VPedidoXProdutosDAO.Free;
  end;
end;

function TPedidoXProdutosModel.Obter(AValorpesquisa: string): TFDQuery;
var
  VPedidoXProdutosDAO: TPedidoXProdutosDAO;
begin
  VPedidoXProdutosDAO := TPedidoXProdutosDAO.Create;
  try
    Result := VPedidoXProdutosDAO.Obter(AValorpesquisa);
  finally
    VPedidoXProdutosDAO.Free;
  end;
end;

function TPedidoXProdutosModel.Salvar: Boolean;
var
  VPedidoXProdutosDAO: TPedidoXProdutosDAO;
begin
  Result := False;

  VPedidoXProdutosDAO := TPedidoXProdutosDAO.Create;
  try
    case FAcao of
      uEnumerado.tacIncluir: Result := VPedidoXProdutosDAO.Incluir(Self);
      uEnumerado.tacAlterar: Result := VPedidoXProdutosDAO.Alterar(Self);
      uEnumerado.tacExcluir: Result := VPedidoXProdutosDAO.Excluir(Self);
    end;
  finally
    VPedidoXProdutosDAO.Free;
  end;
end;

procedure TPedidoXProdutosModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPedidoXProdutosModel.SetCODPRODUTO(const Value: string);
begin
  FCODPRODUTO := Value;
end;

procedure TPedidoXProdutosModel.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TPedidoXProdutosModel.SetNUMPEDIDO(const Value: integer);
begin
  FNUMPEDIDO := Value;
end;

procedure TPedidoXProdutosModel.SetQUANTIDADE(const Value: double);
begin
  FQUANTIDADE := Value;
end;

procedure TPedidoXProdutosModel.SetVALORTOTAL(const Value: double);
begin
  FVALORTOTAL := Value;
end;

procedure TPedidoXProdutosModel.SetVALORUNITARIO(const Value: double);
begin
  FVALORUNITARIO := Value;
end;

end.
