unit uClienteModel;

interface

uses
  uEnumerado, FireDAC.Comp.Client;

type
  TClienteModel = class
  private
    FAcao: TAcao;
    FCodigo: Integer;
    FNome: string;
    FEndereco: string;
    FBairro: string;
    FCidade: string;
    FNumero: string;
    FCep: string;
    FUF: string;

    procedure SetAcao(const Value: TAcao);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetBairro(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetCep(const Value: string);
    procedure SetUF(const Value: string);
  public
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function Salvar: Boolean;
    function GetId: Integer;
    function ObterNomeCLI(AValorpesquisa: string): TFDQuery;

    property Codigo: Integer read FCodigo write SetCodigo;
    property Nome: string read FNome write SetNome;
    property Endereco: string read FEndereco write SetEndereco;
    property Bairro: string read FBairro write SetBairro;
    property Cidade: string read FCidade write SetCidade;
    property Numero: string read FNumero write SetNumero;
    property Cep: string read FCep write SetCep;
    property UF: string read  FUF write SetUF;
    property Acao: TAcao read FAcao write SetAcao;
  end;

implementation

{ TClienteModel }

Uses uClienteDAO;

function TClienteModel.GetId: Integer;
var
  VClienteDao: TClienteDao;
begin
  VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.GetId;
  finally
    VClienteDao.Free;
  end;
end;

function TClienteModel.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
var
  VClienteDao: TClienteDao;
begin
  VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.Obter(AorderBy,AValorparcial);
  finally
    VClienteDao.Free;
  end;
end;

function TClienteModel.ObterNomeCLI(AValorpesquisa: string): TFDQuery;
var
  VClienteDao: TClienteDao;
begin
  VClienteDao := TClienteDao.Create;
  try
    Result := VClienteDao.ObterCLIByID(AValorpesquisa);
  finally
    VClienteDao.Free;
  end;
end;

function TClienteModel.Salvar: Boolean;
var
  VClienteDao: TClienteDao;
begin
  Result := False;

  VClienteDao := TClienteDao.Create;
  try
    case FAcao of
      uEnumerado.tacIncluir: Result := VClienteDao.Incluir(Self);
      uEnumerado.tacAlterar: Result := VClienteDao.Alterar(Self);
      uEnumerado.tacExcluir: Result := VClienteDao.Excluir(Self);
    end;
  finally
    VClienteDao.Free;
  end;
end;

procedure TClienteModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TClienteModel.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TClienteModel.SetCep(const Value: string);
begin
  FCep := Value;
end;

procedure TClienteModel.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TClienteModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TClienteModel.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TClienteModel.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TClienteModel.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TClienteModel.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
