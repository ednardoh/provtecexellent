program ProvaTec;

{$DEFINE IW}

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  ServerController in 'View\ServerController.pas' {IWServerController: TIWServerControllerBase},
  uformbase in 'View\uformbase.pas' {IWFormBase: TIWAppForm},
  umain in 'View\umain.pas' {IWFormMain: TIWAppForm},
  UserSessionUnit in 'View\UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  UListClientes in 'View\UListClientes.pas' {IWFormListClientes: TIWFormListClientes},
  UListProdutos in 'View\UListProdutos.pas' {IWFormListProdutos: TIWFormListProdutos},
  UListPedidos in 'View\UListPedidos.pas' {IWFormListPedidos: TIWFormListPedidos},
  uClienteModel in 'Model\uClienteModel.pas',
  uProdutoModel in 'Model\uProdutoModel.pas',
  uPedidovendaModel in 'Model\uPedidovendaModel.pas',
  uPedidoXProdutosModel in 'Model\uPedidoXProdutosModel.pas',
  uClienteControl in 'Controller\uClienteControl.pas',
  uProdutoControl in 'Controller\uProdutoControl.pas',
  uPedidovendaControl in 'Controller\uPedidovendaControl.pas',
  uPedidoXProdutosControl in 'Controller\uPedidoXProdutosControl.pas',
  uClienteDAO in 'DAO\uClienteDAO.pas',
  uProdutoDAO in 'DAO\uProdutoDAO.pas',
  uPedidovendaDAO in 'DAO\uPedidovendaDAO.pas',
  uPedidoXProdutosDAO in 'DAO\uPedidoXProdutosDAO.pas',
  uConexao in 'DAO\uConexao.pas',
  uEnumerado in 'Model\uEnumerado.pas',
  uSistemaControl in 'Controller\uSistemaControl.pas';

{$R *.res}

begin
  TIWStart.Execute(True);
end.
