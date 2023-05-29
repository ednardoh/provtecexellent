unit UListProdutos;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Data.DB,
  Datasnap.DBClient, Vcl.Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, IWCompButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWHTMLTag, IW.Content.Form,
  IW.HTTP.Request, IWCompEdit, IWDBStdCtrls, uProdutoControl, umain,
  uEnumerado, IWCompExtCtrls;

type
  TIWFormListProdutos = class(TIWAppForm)
    ds_Produtos: TDataSource;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    IWButtonGravar: TIWButton;
    IWButtonCancelar: TIWButton;
    IWDBEditCodigobarra: TIWDBEdit;
    IWDBEditDescricao: TIWDBEdit;
    IWDBEditCodigo: TIWDBEdit;
    IWButtonNovo: TIWButton;
    IWButtonExcluir: TIWButton;
    IWEditRemessa: TIWEdit;
    IWButtonEdit: TIWButton;
    IWDBGrid1: TIWDBGrid;
    IWDBEditPRECOCOMPRA: TIWDBEdit;
    IWDBEditPRECOVENDA: TIWDBEdit;
    IWDBEditQTDEESTOQUE: TIWDBEdit;
    IWBUTTONVOLTAR: TIWButton;
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
  private
    Produtos  : TProdutoControl;
    Atipo: uEnumerado.TAcao;
    procedure PopulateTable;
  public

  end;

implementation

{$R *.dfm}

procedure TIWFormListProdutos.PopulateTable;
begin
  Produtos := TProdutoControl.Create;
  ds_Produtos.DataSet := Produtos.Obter(1,'');  //ordena por codigo
  Produtos.Free;
end;

procedure TIWFormListProdutos.IWAppFormCreate(Sender: TObject);
begin
  PopulateTable;
end;

procedure TIWFormListProdutos.IWButtonGravarAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDados'').modal(''hide'');');
end;

procedure TIWFormListProdutos.IWButtonGravarClick(Sender: TObject);
begin
  try
    Produtos := TProdutoControl.Create;
    case ATipo of
      uEnumerado.tacIncluir:
      begin
        Produtos.ProdutoModel.Codigo      := Produtos.ProdutoModel.GetId;
        Produtos.ProdutoModel.Codigobarra := ds_Produtos.DataSet.FieldByName('Codigo_bar').AsString;
        Produtos.ProdutoModel.Descricao   := ds_Produtos.DataSet.FieldByName('Descricao').AsString;
        Produtos.ProdutoModel.PRECOCOMPRA := ds_Produtos.DataSet.FieldByName('PRECO_COMPRA').AsFloat;
        Produtos.ProdutoModel.PRECOVENDA  := ds_Produtos.DataSet.FieldByName('PRECO_VENDA').AsFloat;
        Produtos.ProdutoModel.QTDEESTOQUE := ds_Produtos.DataSet.FieldByName('QTD_ESTOQUE').AsFloat;
        Produtos.Salvar;
      end;
      uEnumerado.tacAlterar:
      begin
        Produtos.ProdutoModel.Codigo      := ds_Produtos.DataSet.FieldByName('ID').AsInteger;
        Produtos.ProdutoModel.Codigobarra := ds_Produtos.DataSet.FieldByName('Codigo_bar').AsString;
        Produtos.ProdutoModel.Descricao   := ds_Produtos.DataSet.FieldByName('Descricao').AsString;
        Produtos.ProdutoModel.PRECOCOMPRA := ds_Produtos.DataSet.FieldByName('PRECO_COMPRA').AsFloat;
        Produtos.ProdutoModel.PRECOVENDA  := ds_Produtos.DataSet.FieldByName('PRECO_VENDA').AsFloat;
        Produtos.ProdutoModel.QTDEESTOQUE := ds_Produtos.DataSet.FieldByName('QTD_ESTOQUE').AsFloat;
        Produtos.Salvar;
      end;
    end;
  finally
    TIWFormListProdutos.Create(WebApplication).Show;
    Produtos.Free;
  end;
end;

procedure TIWFormListProdutos.IWButtonNovoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  Atipo := uEnumerado.tacIncluir; //diz qual � o processo do CRUD
  ds_Produtos.DataSet.Append;
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDados'').modal(''show'');');  //chama a showmodal
end;

procedure TIWFormListProdutos.IWButtonNovoClick(Sender: TObject);
begin
  Atipo := uEnumerado.tacIncluir; //diz qual � o processo do CRUD
end;

procedure TIWFormListProdutos.IWBUTTONVOLTARAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  TIWFormMain.Create(WebApplication).Show;
  // Destr�i o formul�rio atual:
  Release;
end;

procedure TIWFormListProdutos.IWButtonCancelarAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDados'').modal(''hide'');');
end;

procedure TIWFormListProdutos.IWButtonEditAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  Atipo := uEnumerado.tacAlterar; //diz qual � o processo do CRUD
  Produtos := TProdutoControl.Create;
  ds_Produtos.DataSet := Produtos.Obter(strtoint(IWEditRemessa.Text),'');
  Produtos.Free;

  if ds_Produtos.DataSet.Locate('ID',IWEditRemessa.Text,[]) then
  begin
    WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#EditaDados'').modal(''show'');');
  end
  else
    raise Exception.Create('Registro n�o localizado!');
end;

procedure TIWFormListProdutos.IWButtonExcluirClick(Sender: TObject);
begin
  Atipo := uEnumerado.tacExcluir; //diz qual � o processo do CRUD
  Produtos := TProdutoControl.Create;
  Produtos.ProdutoModel.Codigo := ds_Produtos.DataSet.FieldByName('ID').AsInteger;
  Produtos.Salvar;
  Produtos.Free;

  TIWFormListProdutos.Create(WebApplication).Show;

end;

procedure TIWFormListProdutos.IWTemplateProcessorHTML1UnknownTag(
  const AName: string; var VValue: string);
begin
  if AnsiUpperCase(AName)='GRIDPRODUTOSDATA' then
  begin
    ds_Produtos.DataSet.First;
    while not ds_Produtos.DataSet.Eof do
    begin
      VValue:=VValue+'<tr><td>'+ds_Produtos.DataSet.FieldByName('id').AsString+'</td>'+SLineBreak+
        //'<td>'+ds_Produtos.DataSet.FieldByName('Codigo_bar').AsString+'</td>'+SLineBreak+
        '<td>'+ds_Produtos.DataSet.FieldByName('Descricao').AsString+'</td>'+SLineBreak+
        '<td>'+ds_Produtos.DataSet.FieldByName('PRECO_COMPRA').AsString+'</td>'+SLineBreak+
        '<td>'+ds_Produtos.DataSet.FieldByName('PRECO_VENDA').AsString+'</td>'+SLineBreak+
        '<td>'+ds_Produtos.DataSet.FieldByName('QTD_ESTOQUE').AsString+'</td>'+SLineBreak+
        '<td>'+
          '<button type="button" class="btn btn-warning" onclick="return setRecordPosition('+ds_Produtos.DataSet.FieldByName('id').AsString+',''alterar'')">Editar</button>'+SLineBreak+
          '<button type="button" class="btn btn-danger" onclick="return setRecordPosition('+ds_Produtos.DataSet.FieldByName('id').AsString+',''excluir'')">Excluir</button>'+SLineBreak+
        '</td></tr>';
      ds_Produtos.DataSet.Next;
    end;
  end;

end;

//initialization
//  TIWFormListProdutos.SetAsMainForm;

end.
