program ProLanchonete;

uses
  Vcl.Forms,
  UnPrincipal in 'view\UnPrincipal.pas' {frmPrincipal},
  UnClienteView in 'view\UnClienteView.pas' {frmCliente},
  UnShowMessages in 'view\UnShowMessages.pas' {frmShowMessages},
  UnPessoa in 'model\UnPessoa.pas',
  UnCliente in 'model\UnCliente.pas',
  UnFirebirdConn in 'dao\UnFirebirdConn.pas',
  UnProdutoModel in 'model\UnProdutoModel.pas',
  UnProduto in 'model\UnProduto.pas',
  UnClienteModel in 'model\UnClienteModel.pas',
  UnCategoriaProduto in 'model\UnCategoriaProduto.pas',
  UnFormControl in 'objcontrol\UnFormControl.pas',
  UnUnidadeProduto in 'model\UnUnidadeProduto.pas',
  UnCadastroPadrao in 'view\UnCadastroPadrao.pas' {frmCadastroPadrao},
  UnVendaEntregaView in 'view\UnVendaEntregaView.pas' {frmVendaEntregaVIew},
  UnProdutoView in 'view\UnProdutoView.pas',
  UnPedidoModel in 'model\UnPedidoModel.pas',
  UnPedido in 'model\UnPedido.pas',
  UnBuscarProdutoView in 'view\UnBuscarProdutoView.pas' {frmBuscaProduto},
  UnProdutoPedido in 'model\UnProdutoPedido.pas',
  UnProdutoPedidoModel in 'model\UnProdutoPedidoModel.pas',
  UnPagamento in 'model\UnPagamento.pas',
  UnRelatorioVendasView in 'view\UnRelatorioVendasView.pas' {frmRelatorioVendasView},
  UnConfigView in 'view\UnConfigView.pas' {frmConfigView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Lanchonete';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmShowMessages, frmShowMessages);
  Application.Run;
end.
