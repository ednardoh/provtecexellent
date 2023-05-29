unit uPedidovendaModel;

interface

uses
  uEnumerado, FireDAC.Comp.Client;

type
  TPedidovendaModel = class
  private
    FAcao: TAcao;
    FNUMPEDIDO: integer;
    FDATAEMISSAO: TDateTime;
    FCODCLIENTE: integer;
    FVALORTOTAL: double;

    procedure SetAcao(const Value: TAcao);
    procedure SetNUMPEDIDO(const Value: integer);
    procedure SetDATAEMISSAO(const Value: TDateTime);
    procedure SetCODCLIENTE(const Value: integer);
    procedure SetVALORTOTAL(const Value: double);
  public
    function Obter(AValorpesquisa: string): TFDQuery;
    function Salvar: Boolean;
    function GetId: Integer;

    property Acao: TAcao            read FAcao        write SetAcao;
    property NUMPEDIDO: integer     read FNUMPEDIDO   write SetNUMPEDIDO;
    property DATAEMISSAO: TDateTime read FDATAEMISSAO write SetDATAEMISSAO;
    property CODCLIENTE: integer    read FCODCLIENTE  write SetCODCLIENTE;
    property VALORTOTAL: double     read FVALORTOTAL  write SetVALORTOTAL;

  end;

implementation

{ TPedidovendaModel }

Uses uPedidovendaDAO;

function TPedidovendaModel.GetId: Integer;
var
  VPedidovendaDAO: TPedidovendaDAO;
begin
  VPedidovendaDAO := TPedidovendaDAO.Create;
  try
    Result := VPedidovendaDAO.GetId;
  finally
    VPedidovendaDAO.Free;
  end;
end;

function TPedidovendaModel.Obter(AValorpesquisa: string): TFDQuery;
var
  VPedidovendaDAO: TPedidovendaDAO;
begin
  VPedidovendaDAO := TPedidovendaDAO.Create;
  try
    Result := VPedidovendaDAO.Obter(AValorpesquisa);
  finally
    VPedidovendaDAO.Free;
  end;
end;

function TPedidovendaModel.Salvar: Boolean;
var
  VPedidovendaDAO: TPedidovendaDAO;
begin
  Result := False;

  VPedidovendaDAO := TPedidovendaDAO.Create;
  try
    case FAcao of
      uEnumerado.tacIncluir: Result := VPedidovendaDAO.Incluir(Self);
      uEnumerado.tacAlterar: Result := VPedidovendaDAO.Alterar(Self);
      uEnumerado.tacExcluir: Result := VPedidovendaDAO.Excluir(Self);
    end;
  finally
    VPedidovendaDAO.Free;
  end;
end;

procedure TPedidovendaModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPedidovendaModel.SetCODCLIENTE(const Value: integer);
begin
  FCODCLIENTE := Value;
end;

procedure TPedidovendaModel.SetDATAEMISSAO(const Value: TDateTime);
begin
  FDATAEMISSAO := Value;
end;

procedure TPedidovendaModel.SetNUMPEDIDO(const Value: integer);
begin
  FNUMPEDIDO := Value;
end;

procedure TPedidovendaModel.SetVALORTOTAL(const Value: double);
begin
  FVALORTOTAL := Value;
end;

end.
