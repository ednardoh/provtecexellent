unit uPedidovendaControl;

interface

uses
  uPedidovendaModel, System.SysUtils, FireDAC.Comp.Client;

type
  TPedidovendaControl = class
    private
      FPedidovendaModel: TPedidovendaModel;

    public
      constructor Create;
      destructor Destroy; override;

      function Salvar: Boolean;
      function Obter(AValorpesquisa: string): TFDQuery;
      function GetId: Integer;

      property PedidovendaModel: TPedidovendaModel read FPedidovendaModel write FPedidovendaModel;

  end;

implementation

{ TPedidovendaControl }

constructor TPedidovendaControl.Create;
begin
  FPedidovendaModel := TPedidovendaModel.Create;
end;

destructor TPedidovendaControl.Destroy;
begin
  FPedidovendaModel.Free;
  inherited;
end;

function TPedidovendaControl.GetId: Integer;
begin
  Result := FPedidovendaModel.GetId;
end;

function TPedidovendaControl.Obter(AValorpesquisa: string): TFDQuery;
begin
  Result := FPedidovendaModel.Obter(AValorpesquisa);
end;

function TPedidovendaControl.Salvar: Boolean;
begin
  Result := FPedidovendaModel.Salvar;
end;

end.
