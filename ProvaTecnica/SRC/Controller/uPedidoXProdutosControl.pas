unit uPedidoXProdutosControl;

interface

uses
  uPedidoXProdutosModel, System.SysUtils, FireDAC.Comp.Client;

type
  TPedidoXProdutosControl = class
    private
      FPedidoXProdutosModel: TPedidoXProdutosModel;

    public
      constructor Create;
      destructor Destroy; override;

      function Salvar: Boolean;
      function Obter(AValorpesquisa: string): TFDQuery;
      function GetId: Integer;

      property PedidoXProdutosModel: TPedidoXProdutosModel read FPedidoXProdutosModel write FPedidoXProdutosModel;

  end;


implementation

{ TPedidoXProdutosControl }

constructor TPedidoXProdutosControl.Create;
begin
  FPedidoXProdutosModel:= TPedidoXProdutosModel.Create;
end;

destructor TPedidoXProdutosControl.Destroy;
begin
  FPedidoXProdutosModel.Free;
  inherited;
end;

function TPedidoXProdutosControl.GetId: Integer;
begin
  Result := FPedidoXProdutosModel.GetId;
end;

function TPedidoXProdutosControl.Obter(AValorpesquisa: string): TFDQuery;
begin
  Result := FPedidoXProdutosModel.Obter(AValorpesquisa);
end;

function TPedidoXProdutosControl.Salvar: Boolean;
begin
  Result := FPedidoXProdutosModel.Salvar;
end;

end.
