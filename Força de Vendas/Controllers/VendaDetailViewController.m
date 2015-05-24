//
//  VendaDetailViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 22/05/15.
//
//

#import "VendaDetailViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ClienteListTableViewController.h"

@interface VendaDetailViewController ()

// Atributos
@property (strong, nonatomic) RLMResults *estagiosDeVenda;

// UI
@property (strong, nonatomic) TPKeyboardAvoidingScrollView *scrollView;

@property (strong, nonatomic) UILabel *clienteLabelLabel;
@property (strong, nonatomic) UILabel *clienteLabel;
@property (strong, nonatomic) UIButton *selecionarClienteButton;
@property (strong, nonatomic) UILabel *nomeContatoLabelLabel;
@property (strong, nonatomic) UILabel *nomeContatoLabel;
@property (strong, nonatomic) UILabel *dataInicioVendaLabel;
@property (strong, nonatomic) UILabel *dataInicioVenda;
@property (strong, nonatomic) UILabel *estagioVendasLabel;
@property (strong, nonatomic) UIPickerView *estagioVendaPicker;
@property (strong, nonatomic) UILabel *valorPropostaLabel;
@property (strong, nonatomic) UITextField *valorProposta;
@property (strong, nonatomic) UILabel *valorVendaLabel;
@property (strong, nonatomic) UITextField *valorVenda;

@property (nonatomic) CGFloat posicaoX;
@property (nonatomic) CGFloat tamanhoTelaComBordas;
@property (nonatomic) CGFloat tamnanhoPadraoLabel;
@property (nonatomic) CGFloat espacamentoPadrao;


@end

@implementation VendaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.posicaoX = 18;
    self.tamanhoTelaComBordas = 288;
    self.tamnanhoPadraoLabel = 22;
    self.espacamentoPadrao = 12;
    
    // UI
    [self inicializarUI];
    
    self.estagioVendaPicker.dataSource = self;
    self.estagioVendaPicker.delegate = self;
    
    
    if (self.processoVenda) {
        self.cliente = self.processoVenda.cliente;
        [self passarProcessoDeVendaParaParametros];
        [self layoutUI];
    } else {
        
        self.dataInicioVenda.text = [Utils formmatedStringForDate:[NSDate new]];
        [self layoutUI];
    }
    
    [self mostrarValoresSePossivel];
    
    UIBarButtonItem *salvarButton = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(salvarVenda)];
    self.navigationItem.rightBarButtonItem = salvarButton;
    
    if ([self.navigationController.viewControllers count] == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Fechar" style:UIBarButtonItemStylePlain target:self action:@selector(fecharTela)];
    }
}

#pragma mark - Geters & Seters
- (RLMResults *)estagiosDeVenda {
    
    if (!_estagiosDeVenda) {
        _estagiosDeVenda = [EstagioDeProcessoDeVenda allObjects];
    }
    
    return _estagiosDeVenda;
}

- (void)setCliente:(Cliente *)cliente {
    
    _cliente = cliente;
    
    self.clienteLabel.text = [NSString stringWithFormat:@"%@\n%@ - %@", self.cliente.nome, self.cliente.nomePessoaDeContato, self.cliente.apelidoPessoaDeContato];
    [self layoutUI];
}

#pragma mark - Private methods
- (void)salvarVenda {
    
    if (!self.cliente) {
        
        [UIAlertView showWithTitle:@"Selecionar cliente!" message:@"Selecione um cliente para poder salvar." cancelButtonTitle:@"Ok" otherButtonTitles:nil tapBlock:nil];
        return;
    }
    if (self.processoVenda) {
        [self editarVenda];
    } else {
        [self salvarNovaVenda];
    }
    
    
    if ([self.navigationController.viewControllers count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)fecharTela {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)salvarNovaVenda {
    
    self.processoVenda = [ProcessoDeVenda new];
    
    [self passarParametrosParaProcessoDeVenda];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:self.processoVenda];
    [realm commitWriteTransaction];
}

- (void)editarVenda {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [self passarParametrosParaProcessoDeVenda];
    [realm commitWriteTransaction];
}

- (void)passarParametrosParaProcessoDeVenda {
    
    self.processoVenda.cliente = self.cliente;
    self.processoVenda.dataInicio = (self.processoVenda.dataInicio)? self.processoVenda.dataInicio:[NSDate new];
    self.processoVenda.estagio = [self.estagiosDeVenda objectAtIndex:(NSUInteger)[self.estagioVendaPicker selectedRowInComponent:0]];
    self.processoVenda.valorProposta = [[Utils replaceDotWithCommaForString:self.valorProposta.text] floatValue];
    self.processoVenda.valorFechado = [[Utils replaceDotWithCommaForString:self.valorVenda.text] floatValue];
    
}

- (void)passarProcessoDeVendaParaParametros {
    
    self.title = self.processoVenda.estagio.nome;
    
    self.clienteLabel.text = [NSString stringWithFormat:@"%@\n%@ - %@", self.processoVenda.cliente.nome, self.processoVenda.cliente.nomePessoaDeContato, self.processoVenda.cliente.apelidoPessoaDeContato];
    
    self.dataInicioVenda.text = [Utils formmatedStringForDate:self.processoVenda.dataInicio];
    
    if (self.processoVenda.valorProposta) {
        self.valorProposta.text = [Utils replaceDotWithCommaForString:[NSString stringWithFormat:@"%.2f", self.processoVenda.valorProposta]];
    }
    
    if (self.processoVenda.valorFechado) {
        self.valorVenda.text = [Utils replaceDotWithCommaForString:[NSString stringWithFormat:@"%.2f", self.processoVenda.valorProposta]];
    }

    
    for (int i = 0; i < (int)[self.estagiosDeVenda count]; i++) {
        
        EstagioDeProcessoDeVenda *e = [self.estagiosDeVenda objectAtIndex:(NSUInteger)i];
        if ([self.processoVenda.estagio.nome isEqualToString:e.nome]) {
            
            [self.estagioVendaPicker selectRow:i inComponent:0 animated:YES];
        }
        
    }
}

- (void)mostrarValoresSePossivel {
    int row = (int)[self.estagioVendaPicker selectedRowInComponent:0];
    
    self.valorPropostaLabel.hidden = (row <= 1);
    self.valorProposta.hidden = (row <= 1);
    
    self.valorVendaLabel.hidden = (row != 4);
    self.valorVenda.hidden = (row != 4);
}


- (void)selecinarCliente {
    
    ClienteListTableViewController *cltVC = [ClienteListTableViewController new];
    cltVC.vendaVC = self;
    
    UINavigationController *navController = [UINavigationController new];
    [navController pushViewController:cltVC animated:YES];
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Picker view datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return (NSInteger) [self.estagiosDeVenda count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    EstagioDeProcessoDeVenda *estagio = [self.estagiosDeVenda objectAtIndex:(NSUInteger)row];
    
    return estagio.nome;
}

#pragma mark - Picker view delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [self mostrarValoresSePossivel];
}

#pragma mark - UI
- (void)inicializarUI {
    
    self.scrollView = [TPKeyboardAvoidingScrollView new];
    
    self.clienteLabelLabel = [UILabel new];
    self.clienteLabel = [UILabel new];
    self.selecionarClienteButton = [UIButton new];
    self.nomeContatoLabelLabel = [UILabel new];
    self.nomeContatoLabel = [UILabel new];
    
    self.dataInicioVendaLabel = [UILabel new];
    self.dataInicioVenda = [UILabel new];
    
    self.estagioVendasLabel = [UILabel new];
    self.estagioVendaPicker = [UIPickerView new];
    
    self.valorPropostaLabel = [UILabel new];
    self.valorProposta = [UITextField new];
    self.valorVendaLabel = [UILabel new];
    self.valorVenda = [UITextField new];
}


- (void)layoutUI {

    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 550);
    
    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Ciente
    self.clienteLabelLabel.text = @"cliente:";
    self.clienteLabelLabel.frame = CGRectMake(self.posicaoX, self.espacamentoPadrao, 0, 0);
    self.clienteLabelLabel.textColor = [Utils defaultColor];
    self.clienteLabelLabel.font = [Utils defaultFont];
    [self.clienteLabelLabel sizeToFit];
    [self.scrollView addSubview:self.clienteLabelLabel];
    
    
    [self.selecionarClienteButton setTitle:@" selecionar cliente " forState:UIControlStateNormal];
    [self.selecionarClienteButton setTitleColor:[UIColor colorWithRed:0 green:0.78 blue:0.02 alpha:1] forState:UIControlStateNormal];
    self.selecionarClienteButton.frame = CGRectMake(self.clienteLabelLabel.frame.origin.x + self.clienteLabelLabel.frame.size.width + 10, self.clienteLabelLabel.frame.origin.y, 220, self.tamnanhoPadraoLabel);
    [self.selecionarClienteButton addTarget:self action:@selector(selecinarCliente) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.selecionarClienteButton];
    
    self.clienteLabel.lineBreakMode = YES;
    self.clienteLabel.numberOfLines = 3;
    self.clienteLabel.frame = CGRectMake(self.posicaoX, self.clienteLabelLabel.frame.origin.y + self.clienteLabelLabel.frame.size.height, self.tamanhoTelaComBordas, 0);
    self.clienteLabel.font = [Utils defaultFont];
    [self.clienteLabel sizeToFit];
    [self.scrollView addSubview:self.clienteLabel];
    
    // Data inicio venda
    self.dataInicioVendaLabel.text = @"inicio da venda:";
    self.dataInicioVendaLabel.frame = CGRectMake(self.posicaoX, self.clienteLabel.frame.origin.y + self.clienteLabel.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, 0);
    self.dataInicioVendaLabel.textColor = [Utils defaultColor];
    self.dataInicioVendaLabel.font = [Utils defaultFont];
    [self.dataInicioVendaLabel sizeToFit];
    [self.scrollView addSubview:self.dataInicioVendaLabel];
    
   
    self.dataInicioVenda.frame = CGRectMake(self.posicaoX, self.dataInicioVendaLabel.frame.origin.y + self.dataInicioVendaLabel.frame.size.height, self.tamanhoTelaComBordas, self.tamnanhoPadraoLabel);
    self.dataInicioVenda.font = [Utils defaultFont];
    [self.scrollView addSubview:self.dataInicioVenda];
    
    
    // Estagio da venda
    self.estagioVendasLabel.text = @"estágio venda:";
    self.estagioVendasLabel.frame = CGRectMake(self.posicaoX, self.dataInicioVenda.frame.origin.y + self.dataInicioVendaLabel.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, self.tamnanhoPadraoLabel);
    self.estagioVendasLabel.font = [Utils defaultFont];
    self.estagioVendasLabel.textColor = [Utils defaultColor];
    [self.scrollView addSubview:self.estagioVendasLabel];
    
    self.estagioVendaPicker.frame = CGRectMake(self.posicaoX, self.estagioVendasLabel.frame.origin.y + self.estagioVendasLabel.frame.size.height + 12, self.tamanhoTelaComBordas, 180);
    self.estagioVendaPicker.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    self.estagioVendaPicker.layer.cornerRadius = 5;
    [self.scrollView addSubview:self.estagioVendaPicker];
    
    // Valores
    self.valorPropostaLabel.text = @"valor proposta enviada (R$):";
    self.valorPropostaLabel.frame = CGRectMake(self.posicaoX, self.estagioVendaPicker.frame.origin.y + self.estagioVendaPicker.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, self.tamnanhoPadraoLabel);
    self.valorPropostaLabel.textColor = [Utils defaultColor];
    self.valorPropostaLabel.font = [Utils defaultFont];
    [self.valorPropostaLabel sizeToFit];
    [self.scrollView addSubview:self.valorPropostaLabel];

    self.valorProposta.placeholder = @"0,00";
    self.valorProposta.font = [Utils defaultFont];
    self.valorProposta.keyboardType = UIKeyboardTypeDecimalPad;
    self.valorProposta.frame = CGRectMake(self.posicaoX, self.valorPropostaLabel.frame.origin.y + self.valorPropostaLabel.frame.size.height, self.tamanhoTelaComBordas, 30);
    [self.scrollView addSubview:self.valorProposta];
    
    self.valorVendaLabel.text = @"valor da venda (R$):";
    self.valorVendaLabel.frame = CGRectMake(self.posicaoX, self.valorProposta.frame.origin.y + self.valorProposta.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, self.tamnanhoPadraoLabel);
    self.valorVendaLabel.textColor = [Utils defaultColor];
    self.valorVendaLabel.font = [Utils defaultFont];
    [self.valorVendaLabel sizeToFit];
    [self.scrollView addSubview:self.valorVendaLabel];
    
    self.valorVenda.placeholder = @"0,00";
    self.valorVenda.font = [Utils defaultFont];
    self.valorVenda.keyboardType = UIKeyboardTypeDecimalPad;
    self.valorVenda.frame = CGRectMake(self.posicaoX, self.valorVendaLabel.frame.origin.y + self.valorVendaLabel.frame.size.height, self.tamanhoTelaComBordas, 30);
    [self.scrollView addSubview:self.valorVenda];
}

@end
