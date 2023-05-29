unit uProdutoModel;

interface

uses
  uEnumerado, FireDAC.Comp.Client;

type
  TProdutoModel = class
  private
    FAcao: TAcao;
    FCodigo: string;
    FDescricao: string;
    FPRECOVENDA: Double;

    procedure SetAcao(const Value: TAcao);
    procedure SetCodigo(const Value: string);
    procedure SetDescricao(const Value: string);
    procedure SetPRECOVENDA(const Value: Double);
  public
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterProdDesc(AValorpesquisa: string): TFDQuery;
    function Salvar: Boolean;
    function GetId: Integer;

    property Acao: TAcao read FAcao write SetAcao;
    property Codigo: string read FCodigo write SetCodigo;
    property Descricao: string read FDescricao write SetDescricao;
    property PRECOVENDA: Double read FPRECOVENDA write SetPRECOVENDA;
  end;

implementation

{ TProdutoModel }

Uses uProdutoDAO;

function TProdutoModel.GetId: Integer;
var
  VProdutoDao: TProdutoDao;
begin
  VProdutoDao := TProdutoDao.Create;
  try
    Result := VProdutoDao.GetId;
  finally
    VProdutoDao.Free;
  end;
end;

function TProdutoModel.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
var
  VProdutoDao: TProdutoDao;
begin
  VProdutoDao := TProdutoDao.Create;
  try
    Result := VProdutoDao.Obter(AorderBy,AValorparcial);
  finally
    VProdutoDao.Free;
  end;
end;

function TProdutoModel.ObterProdDesc(AValorpesquisa: string): TFDQuery;
var
  VProdutoDao: TProdutoDao;
begin
  VProdutoDao := TProdutoDao.Create;
  try
    Result := VProdutoDao.ObterProdDesc(AValorpesquisa);
  finally
    VProdutoDao.Free;
  end;
end;

function TProdutoModel.Salvar: Boolean;
var
  VProdutoDao: TProdutoDao;
begin
  Result := False;

  VProdutoDao := TProdutoDao.Create;
  try
    case FAcao of
      uEnumerado.tacIncluir: Result := VProdutoDao.Incluir(Self);
      uEnumerado.tacAlterar: Result := VProdutoDao.Alterar(Self);
      uEnumerado.tacExcluir: Result := VProdutoDao.Excluir(Self);
    end;
  finally
    VProdutoDao.Free;
  end;
end;

procedure TProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TProdutoModel.SetCodigo(const Value: string);
begin
  FCodigo := Value;
end;

procedure TProdutoModel.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProdutoModel.SetPRECOVENDA(const Value: Double);
begin
  FPRECOVENDA := Value;
end;

end.
