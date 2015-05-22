//
//  ClienteDetailViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 21/05/15.
//
//

#import "ClienteDetailViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

#import <Realm/Realm.h>
#import "DataModels.h"

@interface ClienteDetailViewController ()

@property (strong, nonatomic) TPKeyboardAvoidingScrollView *scrollView;

@property (strong, nonatomic) UITextField *nomeCliente;
@property (strong, nonatomic) UITextField *nomePessoaContatoField;
@property (strong, nonatomic) UITextField *apelidoPessoaContatoField;
@property (strong, nonatomic) UITextField *emailField;
@property (strong, nonatomic) UITextField *dddField;
@property (strong, nonatomic) UITextField *numeroField;
@property (strong, nonatomic) UITextField *ruaField;
@property (strong, nonatomic) UITextField *numeroEnderecoField;
@property (strong, nonatomic) UITextField *bairroField;
@property (strong, nonatomic) UITextField *referenciaTextfield;
@property (strong, nonatomic) UITextField *cidadeField;
@property (strong, nonatomic) UITextField *estadoField;
@property (strong, nonatomic) UITextField *paisFeild;
@property (strong, nonatomic) UITextView *observacaoTextView;

@end

@implementation ClienteDetailViewController

#pragma mark - Events
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cliente";
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self inicializarUI];
    
    
    if (self.cliente) {
        
        [self passarClienteParaParametros];
        [self adicionarBotaoApagar];
    }
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(salvar)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


#pragma mark - Model
- (void)passarParametrosParaCliente {
    
    self.cliente.nome = self.nomeCliente.text;
    self.cliente.nomePessoaDeContato = self.nomePessoaContatoField.text;
    self.cliente.apelidoPessoaDeContato = self.apelidoPessoaContatoField.text;
    self.cliente.email = self.emailField.text;
    
    Telefone *telefone = [Telefone new];
    telefone.ddd = (![self.dddField.text isEqualToString:@""])? self.dddField.text:@"75";
    telefone.numero = self.numeroField.text;
    telefone.cliente = self.cliente;
    self.cliente.telefone = telefone;
    
    Endereco *endereco = [Endereco new];
    endereco.logradouro = self.ruaField.text;
    endereco.numero = self.numeroField.text;
    endereco.bairro = self.bairroField.text;
    endereco.referencia = self.referenciaTextfield.text;
    endereco.cidade = (![self.cidadeField.text isEqualToString:@""])? self.cidadeField.text : @"Feira de Santana";
    endereco.estado = (![self.estadoField.text isEqualToString:@""])? self.estadoField.text:@"BA";
    endereco.pais = (![self.paisFeild.text isEqualToString:@""])? self.paisFeild.text: @"Brasil";
    endereco.cliente = self.cliente;
    self.cliente.endereco = endereco;
    
    self.cliente.observacao = self.observacaoTextView.text;
}

- (void)passarClienteParaParametros {

    self.title = self.cliente.nome;
    self.nomeCliente.text = self.cliente.nome;
    self.nomePessoaContatoField.text = self.cliente.nomePessoaDeContato;
    self.apelidoPessoaContatoField.text = self.cliente.apelidoPessoaDeContato;
    
    self.emailField.text = self.cliente.email;
    
    self.dddField.text = self.cliente.telefone.ddd;
    self.numeroField.text = self.cliente.telefone.numero;
    
    self.ruaField.text = self.cliente.endereco.logradouro;
    self.numeroEnderecoField.text = self.cliente.endereco.numero;
    self.bairroField.text = self.cliente.endereco.bairro;
    self.referenciaTextfield.text = self.cliente.endereco.referencia;
    self.cidadeField.text = self.cliente.endereco.cidade;
    self.estadoField.text = self.cliente.endereco.estado;
    self.paisFeild.text = self.cliente.endereco.pais;
}

- (void)salvarNovoCliente {
    
    self.cliente = [Cliente new];
    [self passarParametrosParaCliente];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:self.cliente];
    [realm commitWriteTransaction];
}


- (void)editarCliente {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [self passarParametrosParaCliente];
    [realm commitWriteTransaction];
}

- (void)apagarCliente {
    
    [UIAlertView showWithTitle:@"Tem certeza?"
                       message:@"Você deseja realmente apagar totalmente este cliente?"
             cancelButtonTitle:@"Não"
             otherButtonTitles:@[@"Sim"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                        if (buttonIndex == 1) {

                            RLMRealm *realm = [RLMRealm defaultRealm];
                            [realm beginWriteTransaction];
                            [realm deleteObject:self.cliente];
                            [realm commitWriteTransaction];
                            
                            [self.navigationController popViewControllerAnimated:YES];
                        }
    }];
                                                                                                                                                                               
}

#pragma mark - UIActions
- (void)salvar {

    if (self.cliente) {
        [self editarCliente];
    } else {
        [self salvarNovoCliente];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (void)inicializarUI {
    
    self.scrollView = [TPKeyboardAvoidingScrollView new];
    
    self.nomeCliente = [UITextField new];
    self.nomePessoaContatoField = [UITextField new];
    self.apelidoPessoaContatoField = [UITextField new];
    
    self.emailField = [UITextField new];
    
    self.dddField = [UITextField new];
    
    self.numeroField = [UITextField new];
    
    self.ruaField = [UITextField new];
    self.numeroEnderecoField = [UITextField new];
    self.bairroField = [UITextField new];
    self.referenciaTextfield = [UITextField new];
    self.cidadeField = [UITextField new];
    self.estadoField = [UITextField new];
    self.paisFeild = [UITextField new];

    self.observacaoTextView = [UITextView new];
    
    [self layoutUI];
}


- (void)setCamposEditaveis:(BOOL)isVisible {
    
    self.nomeCliente.enabled = isVisible;
    self.nomePessoaContatoField.enabled = isVisible;
    self.apelidoPessoaContatoField.enabled = isVisible;
    
    self.emailField.enabled = isVisible;
    
    self.dddField.enabled = isVisible;
    
    self.numeroField.enabled = isVisible;
    
    self.ruaField.enabled = isVisible;
    self.numeroEnderecoField.enabled = isVisible;
    self.bairroField.enabled = isVisible;
    self.referenciaTextfield.enabled = isVisible;
    self.cidadeField.enabled = isVisible;
    self.estadoField.enabled = isVisible;
    self.paisFeild.enabled = isVisible;
    
    self.observacaoTextView.editable = isVisible;
}

CGFloat posicaoX= 18;
CGFloat tamanhoTelaComBordas = 288;
- (void)layoutUI {
    
    
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 580);
    [self.view addSubview:self.scrollView];
    
    // Elementos
    
    // Cliente
    UILabel *clienteLabel = [UILabel new];
    clienteLabel.text = @"cliente:";
    clienteLabel.textColor = [Utils defaultColor];
    clienteLabel.font = [Utils defaultFont];
    clienteLabel.frame = CGRectMake(posicaoX, 12, 0, 0);
    [clienteLabel sizeToFit];
    [self.scrollView addSubview:clienteLabel];
    

    self.nomeCliente.frame = CGRectMake(posicaoX, clienteLabel.frame.origin.y + clienteLabel.frame.size.height, tamanhoTelaComBordas, 30);
    self.nomeCliente.font = [Utils defaultFont];
    self.nomeCliente.placeholder = @"Nome cliente";
    [self.scrollView addSubview:self.nomeCliente];
    
    
    // Name
    UILabel *pessoaContato = [UILabel new];
    pessoaContato.text = @"pessoa contato:";
    pessoaContato.textColor = [Utils defaultColor];
    pessoaContato.font = [Utils defaultFont];
    pessoaContato.frame = CGRectMake(posicaoX, self.nomeCliente.frame.origin.y + self.nomeCliente.frame.size.height + 10, 0, 0);
    [pessoaContato sizeToFit];
    [self.scrollView addSubview:pessoaContato];
    
    self.nomePessoaContatoField.frame = CGRectMake(posicaoX, pessoaContato.frame.origin.y + pessoaContato.frame.size.height, tamanhoTelaComBordas, 30);
    self.nomePessoaContatoField.font = [Utils defaultFont];
    self.nomePessoaContatoField.placeholder = @"Nome da pessoa de contato";
    [self.scrollView addSubview:self.nomePessoaContatoField];
    
    
    self.apelidoPessoaContatoField.frame = CGRectMake(posicaoX, self.nomePessoaContatoField.frame.origin.y + self.nomePessoaContatoField.frame.size.height, tamanhoTelaComBordas, 30);
    self.apelidoPessoaContatoField.font = [Utils defaultFont];
    self.apelidoPessoaContatoField.placeholder = @"Apelido da pessoa de contato";
    [self.scrollView addSubview:self.apelidoPessoaContatoField];
    
    
    // Email
    UILabel *emailLabel = [UILabel new];
    emailLabel.text = @"email:";
    emailLabel.textColor = [Utils defaultColor];
    emailLabel.font = [Utils defaultFont];
    emailLabel.frame = CGRectMake(posicaoX, self.apelidoPessoaContatoField.frame.origin.y + self.apelidoPessoaContatoField.frame.size.height + 10, 0, 0);
    [emailLabel sizeToFit];
    [self.scrollView addSubview:emailLabel];
    
    
    self.emailField.frame = CGRectMake(posicaoX, emailLabel.frame.origin.y + emailLabel.frame.size.height, tamanhoTelaComBordas, 30);
    self.emailField.font = [Utils defaultFont];
    self.emailField.placeholder = @"email@mail.com";
    [self.scrollView addSubview:self.emailField];
    
    
    // Telefone
    UILabel *telefoneLabel = [UILabel new];
    telefoneLabel.text = @"telefone:";
    telefoneLabel.textColor = [Utils defaultColor];
    telefoneLabel.font = [Utils defaultFont];
    telefoneLabel.frame = CGRectMake(posicaoX, self.emailField.frame.origin.y + self.emailField.frame.size.height + 10, 0, 0);
    [telefoneLabel sizeToFit];
    [self.scrollView addSubview:telefoneLabel];
    
    
    self.dddField.frame = CGRectMake(posicaoX, telefoneLabel.frame.origin.y + telefoneLabel.frame.size.height, tamanhoTelaComBordas * 0.12, 30);
    self.dddField.font = [Utils defaultFont];
    self.dddField.placeholder = @"(00)";
    [self.scrollView addSubview:self.dddField];
    
    
    self.numeroField.frame = CGRectMake(self.dddField.frame.origin.x + self.dddField.frame.size.width + 5, self.dddField.frame.origin.y, tamanhoTelaComBordas * 0.8 - 5, 30);
    self.numeroField.font = [Utils defaultFont];
    self.numeroField.placeholder = @"0000-0000";
    [self.scrollView addSubview:self.numeroField];
    
    // Endereço
    UILabel *enderecoLabel = [UILabel new];
    enderecoLabel.text = @"endereço:";
    enderecoLabel.textColor = [Utils defaultColor];
    enderecoLabel.font = [Utils defaultFont];
    enderecoLabel.frame = CGRectMake(posicaoX, self.numeroField.frame.origin.y + self.numeroField.frame.size.height + 10, 0, 0);
    [enderecoLabel sizeToFit];
    [self.scrollView addSubview:enderecoLabel];

    
    self.ruaField.frame = CGRectMake(posicaoX, enderecoLabel.frame.origin.y + enderecoLabel.frame.size.height, tamanhoTelaComBordas * 0.45, 30);
    self.ruaField.font = [Utils defaultFont];
    self.ruaField.placeholder = @"Rua";
    [self.scrollView addSubview:self.ruaField];
    
    UILabel *virgulaLabel = [UILabel new];
    virgulaLabel.text = @",";
    virgulaLabel.textColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.84f alpha:1];
    virgulaLabel.font = [Utils defaultFont];
    virgulaLabel.frame = CGRectMake(self.ruaField.frame.origin.x + self.ruaField.frame.size.width, self.ruaField.frame.origin.y + 5, 0, 0);
    [virgulaLabel sizeToFit];
    [self.scrollView addSubview:virgulaLabel];
    
    
    self.numeroEnderecoField.frame = CGRectMake(virgulaLabel.frame.origin.x + virgulaLabel.frame.size.width + 5, self.ruaField.frame.origin.y , tamanhoTelaComBordas * 0.15 - 5, 30);
    self.numeroEnderecoField.font = [Utils defaultFont];
    self.numeroEnderecoField.placeholder = @"Nº";
    [self.scrollView addSubview:self.numeroEnderecoField];
    
    UILabel *hifenLabel = [UILabel new];
    hifenLabel.text = @"-";
    hifenLabel.textColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.84f alpha:1];
    hifenLabel.font = [Utils defaultFont];
    hifenLabel.frame = CGRectMake(self.numeroEnderecoField.frame.origin.x + self.numeroEnderecoField.frame.size.width, self.numeroEnderecoField.frame.origin.y + 5, 0, 0);
    [hifenLabel sizeToFit];
    [self.scrollView addSubview:hifenLabel];
    
    self.bairroField.frame = CGRectMake(hifenLabel.frame.origin.x + hifenLabel.frame.size.width + 5, self.numeroEnderecoField.frame.origin.y,tamanhoTelaComBordas * 0.35, 30);
    self.bairroField.font = [Utils defaultFont];
    self.bairroField.placeholder = @"Bairro";
    [self.scrollView addSubview:self.bairroField];
    
    
    self.referenciaTextfield.frame = CGRectMake(posicaoX, self.bairroField.frame.origin.y + self.bairroField.frame.size.height, tamanhoTelaComBordas, 30);
    self.referenciaTextfield.font = [Utils defaultFont];
    self.referenciaTextfield.placeholder = @"referência";
    [self.scrollView addSubview:self.referenciaTextfield];
    
    
    self.cidadeField.frame = CGRectMake(posicaoX, self.referenciaTextfield.frame.origin.y + self.referenciaTextfield.frame.size.height, tamanhoTelaComBordas * 0.6, 30);
    self.cidadeField.font = [Utils defaultFont];
    self.cidadeField.placeholder = @"Feira de Santana";
    [self.scrollView addSubview:self.cidadeField];
    
    UILabel *hifenLabelEnd = [UILabel new];
    hifenLabelEnd.text = @"-";
    hifenLabelEnd.textColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.84f alpha:1];
    hifenLabelEnd.font = [Utils defaultFont];
    hifenLabelEnd.frame = CGRectMake(self.cidadeField.frame.origin.x + self.cidadeField.frame.size.width, self.cidadeField.frame.origin.y + 5, 0, 0);
    [hifenLabelEnd sizeToFit];
    [self.scrollView addSubview:hifenLabelEnd];

    self.estadoField.frame = CGRectMake(hifenLabelEnd.frame.origin.x + hifenLabelEnd.frame.size.width + 2, self.cidadeField.frame.origin.y, tamanhoTelaComBordas * 0.11, 30);
    self.estadoField.font = [Utils defaultFont];
    self.estadoField.placeholder = @"BA";
    [self.scrollView addSubview:self.estadoField];
    
    UILabel *virgulaLabelEnd = [UILabel new];
    virgulaLabelEnd.text = @",";
    virgulaLabelEnd.textColor = [UIColor colorWithRed:0.82f green:0.82f blue:0.84f alpha:1];
    virgulaLabelEnd.font = [Utils defaultFont];
    virgulaLabelEnd.frame = CGRectMake(self.estadoField.frame.origin.x + self.estadoField.frame.size.width, self.estadoField.frame.origin.y + 5, 0, 0);
    [virgulaLabelEnd sizeToFit];
    [self.scrollView addSubview:virgulaLabelEnd];
    

    self.paisFeild.frame = CGRectMake(virgulaLabelEnd.frame.origin.x + virgulaLabel.frame.size.width + 2, self.estadoField.frame.origin.y, tamanhoTelaComBordas * 0.25, 30);
    self.paisFeild.font = [Utils defaultFont];
    self.paisFeild.placeholder = @"Brasil";
    [self.scrollView addSubview:self.paisFeild];
    

    UILabel *observacaoLabel = [UILabel new];
    observacaoLabel.text = @"observação:";
    observacaoLabel.textColor = [Utils defaultColor];
    observacaoLabel.font = [Utils defaultFont];
    observacaoLabel.frame = CGRectMake(posicaoX, self.paisFeild.frame.origin.y + 10 + self.paisFeild.frame.size.height, 0, 0);
    [observacaoLabel sizeToFit];
    [self.scrollView addSubview:observacaoLabel];
    
    self.observacaoTextView.frame = CGRectMake(posicaoX, observacaoLabel.frame.origin.y + observacaoLabel.frame.size.height + 2, tamanhoTelaComBordas, 80);
    self.observacaoTextView.font = [Utils defaultFont];
    self.observacaoTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.scrollView addSubview:self.observacaoTextView];
    
}

- (void)adicionarBotaoApagar {
    
    if (self.cliente) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(posicaoX, self.observacaoTextView.frame.origin.y + self.observacaoTextView.frame.size.height + 10, tamanhoTelaComBordas, 44)];
        [button setTintColor:[UIColor redColor]];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:@"Apagar" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(apagarCliente) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
    }
}

@end
