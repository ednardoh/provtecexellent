unit UListPedidos;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Data.DB,
  Datasnap.DBClient, Vcl.Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, IWCompButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWHTMLTag, IW.Content.Form,
  IW.HTTP.Request, IWCompEdit, IWDBStdCtrls, uPedidovendaControl, umain,
  uEnumerado, IWCompExtCtrls, IWCompListbox, uProdutoControl, uPedidoXProdutosControl;

type
  TIWFormListPedidos = class(TIWAppForm)
    ds_Pedidos: TDataSource;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    IWButtonGravar: TIWButton;
    IWButtonCancelar: TIWButton;
    IWDBEditNUMPEDI: TIWDBEdit;
    IWDBEditDATAEMISSAO: TIWDBEdit;
    IWDBEditID: TIWDBEdit;
    IWButtonNovo: TIWButton;
    IWButtonExcluir: TIWButton;
    IWEditRemessa: TIWEdit;
    IWButtonEdit: TIWButton;
    IWDBGrid1: TIWDBGrid;
    IWDBEditCODCLIENTE: TIWDBEdit;
    IWBUTTONVOLTAR: TIWButton;
    IWDBComboBoxPRD: TIWDBLookupComboBox;
    ds_Produtos: TDataSource;
    IWDBEditQUANTIDADE: TIWDBEdit;
    IWDBEditVALORUNITARIO: TIWDBEdit;
    IWDBEditVALORTOTAL: TIWDBEdit;
    ds_PedidoProduto: TDataSource;
    IWButtonGravarPedPrd: TIWButton;
    IWButtonCancelarPedPrd: TIWButton;
    procedure IWButtonGravarClick(Sender: TObject);
    procedure IWTemplateProcessorHTML1UnknownTag(const AName: string;
      var VValue: string);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWButtonEditAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWButtonCancelarAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonNovoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBUTTONVOLTARAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonGravarAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonNovoClick(Sender: TObject);
    procedure IWButtonExcluirClick(Sender: TObject);
    procedure IWButtonCancelarPedPrdAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonGravarPedPrdAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonGravarPedPrdClick(Sender: TObject);
  private
    Pedidos  : TPedidovendaControl;
    Produtos : TProdutoControl;
    PedidoXProduto : TPedidoXProdutosControl;
    Atipo: uEnumerado.TAcao;
    procedure PopulateTable;
  public

  end;

implementation

{$R *.dfm}

procedure TIWFormListPedidos.PopulateTable;
begin
  Pedidos := TPedidovendaControl.Create;
  ds_Pedidos.DataSet := Pedidos.Obter('');  //ordena por codigo
  Pedidos.Free;

  {para preencher o combo de Produtos}
  Produtos := TProdutoControl.Create;
  ds_Produtos.DataSet := Produtos.Obter(3,'');
  Produtos.Free;

  {Tabela dos produtos do pedido}
  PedidoXProduto := TPedidoXProdutosControl.Create;
  ds_PedidoProduto.DataSet := PedidoXProduto.Obter('');
  PedidoXProduto.Free;
end;

procedure TIWFormListPedidos.IWAppFormCreate(Sender: TObject);
begin
  PopulateTable;
end;

procedure TIWFormListPedidos.IWButtonGravarAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDadosPedido'').modal(''hide'');');
end;

procedure TIWFormListPedidos.IWButtonGravarClick(Sender: TObject);
begin
  try
    Pedidos := TPedidovendaControl.Create;
    case ATipo of
      uEnumerado.tacIncluir:
      begin
        Pedidos.PedidovendaModel.ID          := Pedidos.PedidovendaModel.GetId;
        Pedidos.PedidovendaModel.NUMPEDIDO   := ds_Pedidos.DataSet.FieldByName('NUMPEDI').AsInteger;
        Pedidos.PedidovendaModel.DATAEMISSAO := ds_Pedidos.DataSet.FieldByName('DATA_EMISSAO').AsDateTime;
        Pedidos.PedidovendaModel.CODCLIENTE  := ds_Pedidos.DataSet.FieldByName('COD_CLIENTE').AsInteger;
        Pedidos.Salvar;
      end;
      uEnumerado.tacAlterar:
      begin
        Pedidos.PedidovendaModel.ID          := ds_Pedidos.DataSet.FieldByName('ID').AsInteger;
        Pedidos.PedidovendaModel.NUMPEDIDO   := ds_Pedidos.DataSet.FieldByName('NUMPEDI').Asinteger;
        Pedidos.PedidovendaModel.DATAEMISSAO := ds_Pedidos.DataSet.FieldByName('DATA_EMISSAO').AsDateTime;
        Pedidos.PedidovendaModel.CODCLIENTE  := ds_Pedidos.DataSet.FieldByName('COD_CLIENTE').Asinteger;
        Pedidos.Salvar;
      end;
    end;
  finally
    TIWFormListPedidos.Create(WebApplication).Show;
    Pedidos.Free;
  end;
end;

procedure TIWFormListPedidos.IWButtonGravarPedPrdAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDadosPedproduto'').modal(''hide'');');
end;

procedure TIWFormListPedidos.IWButtonGravarPedPrdClick(Sender: TObject);
begin
  try
    PedidoXProduto := TPedidoXProdutosControl.Create;
    case ATipo of
      uEnumerado.tacIncluir:
      begin
        PedidoXProduto.PedidoXProdutosModel.ID         := ds_Pedidos.DataSet.FieldByName('ID').AsInteger;
        PedidoXProduto.PedidoXProdutosModel.NUMPEDIDO  := ds_Pedidos.DataSet.FieldByName('NUMPEDI').AsInteger;
        PedidoXProduto.PedidoXProdutosModel.QUANTIDADE := ds_PedidoProduto.DataSet.FieldByName('QUANTIDADE').AsFloat;
        PedidoXProduto.PedidoXProdutosModel.VALORUNITARIO := ds_PedidoProduto.DataSet.FieldByName('VALOR_UNITARIO').AsFloat;
        PedidoXProduto.PedidoXProdutosModel.VALORTOTAL := ds_PedidoProduto.DataSet.FieldByName('VALOR_TOTAL').AsFloat;
        PedidoXProduto.Salvar;
      end;
    end;
  finally
    TIWFormListPedidos.Create(WebApplication).Show;
    PedidoXProduto.Free;
  end;
end;

procedure TIWFormListPedidos.IWButtonNovoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  Atipo := uEnumerado.tacIncluir; //diz qual � o processo do CRUD
  ds_Pedidos.DataSet.Append;
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDadosPedido'').modal(''show'');');  //chama a showmodal
end;

procedure TIWFormListPedidos.IWButtonNovoClick(Sender: TObject);
begin
  Atipo := uEnumerado.tacIncluir; //diz qual � o processo do CRUD
end;

procedure TIWFormListPedidos.IWBUTTONVOLTARAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWFormMain.Create(WebApplication).Show;
  // Destr�i o formul�rio atual:
  Release;
end;

procedure TIWFormListPedidos.IWButtonCancelarAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDadosPedido'').modal(''hide'');');
end;

procedure TIWFormListPedidos.IWButtonCancelarPedPrdAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDadosPedproduto'').modal(''hide'');');
end;

procedure TIWFormListPedidos.IWButtonEditAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  Atipo := uEnumerado.tacAlterar; //diz qual � o processo do CRUD
  Pedidos := TPedidovendaControl.Create;
  ds_Pedidos.DataSet := Pedidos.Obter('');
  Pedidos.Free;

  ds_PedidoProduto.DataSet.Append;

  if ds_Pedidos.DataSet.Locate('ID',IWEditRemessa.Text,[]) then
  begin
    WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDadosPedproduto'').modal(''show'');');
  end
  else
    raise Exception.Create('Registro n�o localizado!');
end;

procedure TIWFormListPedidos.IWButtonExcluirClick(Sender: TObject);
begin
  Atipo := uEnumerado.tacExcluir; //diz qual � o processo do CRUD
  Pedidos := TPedidovendaControl.Create;
  Pedidos.PedidovendaModel.ID := ds_Pedidos.DataSet.FieldByName('ID').AsInteger;
  Pedidos.Salvar;
  Pedidos.Free;

  TIWFormListPedidos.Create(WebApplication).Show;

end;

procedure TIWFormListPedidos.IWTemplateProcessorHTML1UnknownTag(
  const AName: string; var VValue: string);
begin
  if AnsiUpperCase(AName)='GRIDPEDIDOSDATA' then
  begin
    ds_Pedidos.DataSet.First;
    while not ds_Pedidos.DataSet.Eof do
    begin
      VValue:=VValue+'<tr><td>'+ds_Pedidos.DataSet.FieldByName('ID').AsString+'</td>'+SLineBreak+
        '<td>'+ds_Pedidos.DataSet.FieldByName('NUMPEDI').AsString+'</td>'+SLineBreak+
        '<td>'+ds_Pedidos.DataSet.FieldByName('DATA_EMISSAO').AsString+'</td>'+SLineBreak+
        '<td>'+ds_Pedidos.DataSet.FieldByName('COD_CLIENTE').AsString+'</td>'+SLineBreak+
        '<td>'+
          '<button type="button" class="btn btn-warning" onclick="return setRecordPosition('+ds_Pedidos.DataSet.FieldByName('id').AsString+',''alterar'')">+ Produtos</button>'+SLineBreak+
          '<button type="button" class="btn btn-danger" onclick="return setRecordPosition('+ds_Pedidos.DataSet.FieldByName('id').AsString+',''excluir'')">Excluir</button>'+SLineBreak+
        '</td></tr>';
      ds_Pedidos.DataSet.Next;
    end;
  end;

end;

end.
