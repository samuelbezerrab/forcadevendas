//
//  RelatorioVendasPorTempoViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import "RelatorioVendasPorTempoViewController.h"
#import "PNChart.h"

#import "DataModels.h"

@interface RelatorioVendasPorTempoViewController ()

@end

@implementation RelatorioVendasPorTempoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Vendas X Tempo";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSDictionary *valoresDias = [self quantidadeDeVendasDosUltimosSeteDias];


    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, self.view.frame.size.width, 200.0)];
    [barChart setXLabels:[valoresDias valueForKey:@"labels"]];
    [barChart setYValues:[valoresDias valueForKey:@"results"]];
    [barChart strokeChart];
    [self.view addSubview:barChart];

}


- (NSDictionary *)quantidadeDeVendasDosUltimosSeteDias {
    
    NSDate *beginingOfTheDay = [Utils beginningOfDay];
    NSDate *endOfTheDay = [Utils endOfDay];
    
    NSMutableArray *results = [NSMutableArray new];
    NSMutableArray *labels = [NSMutableArray new];
    [results addObject:@([[ProcessoDeVenda objectsWhere:@"dataInicio > %@ && dataInicio < %@", beginingOfTheDay, endOfTheDay] count])];
    [labels addObject:[Utils formmatedDayFromDate:beginingOfTheDay]];
    for (int i = 0; i < 6; i++) {
        beginingOfTheDay = [beginingOfTheDay dateByAddingTimeInterval:60*60*24*-1];
        endOfTheDay = [endOfTheDay dateByAddingTimeInterval:60*60*24*-1];
        
        RLMResults *result = [ProcessoDeVenda objectsWhere:@"dataInicio > %@ && dataInicio < %@", beginingOfTheDay, endOfTheDay];
        
        [results addObject:@([result count])];
        [labels addObject:[Utils formmatedDayFromDate:beginingOfTheDay]];
    }
    
    NSDictionary *dict = @{@"labels": [[labels reverseObjectEnumerator] allObjects],
                           @"results":[[results reverseObjectEnumerator] allObjects]};
    
    return dict;
}

@end
