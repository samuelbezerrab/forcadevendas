//
//  HomeViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 24/05/15.
//
//

#import "HomeViewController.h"
#import "VendaDetailViewController.h"

#import "DataModels.h"

@interface HomeViewController ()

@property (strong, nonatomic) UIWebView *graficoWebView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    
    // UI
    self.view.backgroundColor = [UIColor whiteColor];
    [self inicializarUI];
    [self layoutUI];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"nova venda" style:UIBarButtonItemStylePlain target:self action:@selector(novaVenda)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *filePathString = [[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"] absoluteString];
    NSString *paramsString = [self valuesString];
    NSString *urlString = [NSString stringWithFormat:@"@%@?%@", filePathString, paramsString];
    
    [self.graficoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

#pragma mark - Private Methods
- (void)novaVenda {
    
    UIViewController *vc = [VendaDetailViewController new];
    UINavigationController *navController = [UINavigationController new];
    [navController pushViewController:vc animated:YES];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (NSString *)valuesString {
    
    RLMResults *todosProcessos = [ProcessoDeVenda allObjects];
    RLMResults *prospectos = [ProcessoDeVenda objectsWhere:@"estagio.nome == 'Prospecto'"];
    RLMResults *qualificados = [ProcessoDeVenda objectsWhere:@"estagio.nome == 'Qualificado'"];
    RLMResults *propEnviada = [ProcessoDeVenda objectsWhere:@"estagio.nome == 'Proposta Enviada'"];
    RLMResults *negociacao = [ProcessoDeVenda objectsWhere:@"estagio.nome == 'Negociação'"];
    
    NSUInteger prospectosValue = [todosProcessos count];
    NSUInteger qualificadosValue = prospectosValue - [prospectos count];
    NSUInteger propEnviadaValue = qualificadosValue - [qualificados count];
    NSUInteger negociacaoValue = propEnviadaValue - [propEnviada count];
    NSUInteger vendaRealizadaValue = negociacaoValue - [negociacao count];
    
    NSString *values = [NSString stringWithFormat:@"1=%lu&2=%lu&3=%lu&4=%lu&5=%lu", (unsigned long)prospectosValue, (unsigned long)qualificadosValue, (unsigned long)propEnviadaValue, (unsigned long)negociacaoValue, (unsigned long)vendaRealizadaValue];
    
    
    return values;
}

#pragma mark - UI
- (void)inicializarUI {
    
    self.graficoWebView = [UIWebView new];
}

- (void)layoutUI {
    
    self.graficoWebView.frame = self.view.frame;
    self.graficoWebView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.graficoWebView];
    
}


@end
