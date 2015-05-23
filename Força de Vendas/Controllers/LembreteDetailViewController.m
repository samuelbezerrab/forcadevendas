//
//  LembreteDetailViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import "LembreteDetailViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface LembreteDetailViewController ()

@property (nonatomic) CGFloat posicaoX;
@property (nonatomic) CGFloat tamanhoTelaComBordas;
@property (nonatomic) CGFloat espacamentoPadrao;

@property (strong, nonatomic) TPKeyboardAvoidingScrollView *scrollView;

@property (strong, nonatomic) UILabel *selecionarDataLabel;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UILabel *lembreteLabel;
@property (strong, nonatomic) UITextView *lembreteTextView;

@end

@implementation LembreteDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.posicaoX = 18;
    self.tamanhoTelaComBordas = 288;
    self.espacamentoPadrao = 12;
    
    // UI
    [self initializeUI];
    [self layoutUI];
    
    UIBarButtonItem *salvarButton = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(salvarLembrete)];
    self.navigationItem.rightBarButtonItem = salvarButton;
    
    if (self.lembrete) {
        [self passarLembreteParaParametros];
    }
}

#pragma mark - Private methods
- (void)salvarLembrete {
    
    if (self.lembrete) {
        [[UIApplication sharedApplication] cancelLocalNotification:self.lembrete];
    }
    
    self.lembrete = [UILocalNotification new];
    self.lembrete.fireDate = self.datePicker.date;
    self.lembrete.alertBody = self.lembreteTextView.text;
    self.lembrete.soundName = @"start.wav";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:self.lembrete];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)apagarNotificacao {
    
    [UIAlertView showWithTitle:@"Apagar lembrete?"
                       message:@"Tem certeza que deseja apagar este lembrete permanentemente"
             cancelButtonTitle:@"Não"
             otherButtonTitles:@[@"Sim"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                                                    
                                                    if (buttonIndex == 1) {
                                                        [[UIApplication sharedApplication] cancelLocalNotification:self.lembrete];
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    }

        
    }];
}

#pragma mark - UI
- (void)initializeUI {
    
    self.scrollView = [TPKeyboardAvoidingScrollView new];

    self.selecionarDataLabel = [UILabel new];
    self.datePicker = [UIDatePicker new];
    
    self.lembreteLabel = [UILabel new];
    self.lembreteTextView = [UITextView new];
}

- (void)layoutUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 560);
    [self.view addSubview:self.scrollView];
    
    // Hora
    self.selecionarDataLabel.text = @"selecione a data e hora desejada:";
    self.selecionarDataLabel.frame = CGRectMake(self.posicaoX, self.espacamentoPadrao, self.tamanhoTelaComBordas, 0);
    self.selecionarDataLabel.font = [Utils defaultFont];
    self.selecionarDataLabel.textColor = [Utils defaultColor];
    [self.selecionarDataLabel sizeToFit];
    [self.scrollView addSubview:self.selecionarDataLabel];
    
    self.datePicker.frame = CGRectMake(self.posicaoX, self.selecionarDataLabel.frame.origin.y + self.selecionarDataLabel.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, 180);
    [self.scrollView addSubview:self.datePicker];
    
    //Lembrete
    self.lembreteLabel.text = @"lembrar de:";
    self.lembreteLabel.frame = CGRectMake(self.posicaoX, self.datePicker.frame.origin.y + self.datePicker.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, 0);
    self.lembreteLabel.font = [Utils defaultFont];
    self.lembreteLabel.textColor = [Utils defaultColor];
    [self.lembreteLabel sizeToFit];
    [self.scrollView addSubview:self.lembreteLabel];
    
    self.lembreteTextView.frame = CGRectMake(self.posicaoX, self.lembreteLabel.frame.origin.y + self.lembreteLabel.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, 200);
    self.lembreteTextView.font = [Utils defaultFont];
    self.lembreteTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.11f];
    self.lembreteTextView.layer.cornerRadius = 5;
    [self.scrollView addSubview:self.lembreteTextView];
    
    if (self.lembrete) {
        [self addDeleteButton];
    }
}

- (void)passarLembreteParaParametros {
    
    self.datePicker.date = self.lembrete.fireDate;
    self.lembreteTextView.text = self.lembrete.alertBody;
}

- (void)addDeleteButton {
    
    if (self.lembrete) {
        
        UIButton *deleteButton = [UIButton new];
        [deleteButton setTitle:@"Apagar" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        deleteButton.frame = CGRectMake(self.posicaoX, self.lembreteTextView.frame.origin.y + self.lembreteTextView.frame.size.height + self.espacamentoPadrao, self.tamanhoTelaComBordas, 44);
        [deleteButton addTarget:self action:@selector(apagarNotificacao) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:deleteButton];
    }
}

@end
