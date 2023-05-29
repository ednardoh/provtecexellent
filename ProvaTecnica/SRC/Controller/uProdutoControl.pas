unit uProdutoControl;

interface

uses
  uProdutoModel, System.SysUtils, FireDAC.Comp.Client;

type
  TProdutoControl = class
  private
    FProdutoModel: TProdutoModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Salvar: Boolean;
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterProdDesc(AValorpesquisa: string): TFDQuery;
    function GetId: Integer;

    property ProdutoModel: TProdutoModel read FProdutoModel write FProdutoModel;
  end;


implementation

{ TProdutoControl }

constructor TProdutoControl.Create;
begin
  FProdutoModel := TProdutoModel.Create;
end;

destructor TProdutoControl.Destroy;
begin
  FProdutoModel.Free;
  inherited;
end;

function TProdutoControl.GetId: Integer;
begin
  Result := FProdutoModel.GetId;
end;

function TProdutoControl.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
begin
  Result := FProdutoModel.Obter(AorderBy,AValorparcial);
end;

function TProdutoControl.ObterProdDesc(AValorpesquisa: string): TFDQuery;
begin
  Result := FProdutoModel.ObterProdDesc(AValorpesquisa);
end;

function TProdutoControl.Salvar: Boolean;
begin
  Result := FProdutoModel.Salvar;
end;

end.
