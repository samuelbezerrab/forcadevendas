//
//  RealtorioVendasVersusPerdasViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import "RelatorioVendasVersusPerdasViewController.h"
#import "PNChart.h"

#import "DataModels.h"

@interface RelatorioVendasVersusPerdasViewController ()

@end

@implementation RelatorioVendasVersusPerdasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    super.title = @"Vendas X Perdas";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
    RLMResults *vendasConcluidas = [ProcessoDeVenda objectsWhere:@"estagio.nome == %@", @"Venda Realizada"];
    RLMResults *vendasPerdidas = [ProcessoDeVenda objectsWhere:@"estagio.nome == 'Venda Perdida'"];
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:[vendasConcluidas count] color:PNGreen description:@"Concluídas"],
                       [PNPieChartDataItem dataItemWithValue:[vendasPerdidas count] color:PNRed description:@"Perdidas"],
                       ];
    
    
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    [self.view addSubview:pieChart];
}


@end
