unit uClienteControl;

interface

uses
  uClienteModel, System.SysUtils, FireDAC.Comp.Client;

type
  TClienteControl = class
  private
    FClienteModel: TClienteModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Salvar: Boolean;
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterNomeCLI(AValorpesquisa: string): TFDQuery;
    function GetId: Integer;

    property ClienteModel: TClienteModel read FClienteModel write FClienteModel;
  end;

implementation

{ TClienteControl }

constructor TClienteControl.Create;
begin
  FClienteModel := TClienteModel.Create;
end;

destructor TClienteControl.Destroy;
begin
  FClienteModel.Free;
  inherited;
end;

function TClienteControl.GetId: Integer;
begin
  Result := FClienteModel.GetId;
end;

function TClienteControl.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
begin
  Result := FClienteModel.Obter(AorderBy,AValorparcial);
end;

function TClienteControl.ObterNomeCLI(AValorpesquisa: string): TFDQuery;
begin
  Result := FClienteModel.ObterNomeCLI(AValorpesquisa);
end;

function TClienteControl.Salvar: Boolean;
begin
  Result := FClienteModel.Salvar;
end;

end.
