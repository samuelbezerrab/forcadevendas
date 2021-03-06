//
//  RelatorioNovosClientePorTempoViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import "RelatorioNovosClientePorTempoViewController.h"
#import "PNChart.h"

#import "DataModels.h"

@interface RelatorioNovosClientePorTempoViewController ()

@end

@implementation RelatorioNovosClientePorTempoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Novos Clientes X Tempo";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSDictionary *valoresDias = [self quantidadeDeNovosClientesDosUltimosSeteDias];
    
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, self.view.frame.size.width, 200.0)];
    [barChart setXLabels:[valoresDias valueForKey:@"labels"]];
    [barChart setYValues:[valoresDias valueForKey:@"results"]];
    [barChart strokeChart];
    [self.view addSubview:barChart];
    
}

- (NSDictionary *)quantidadeDeNovosClientesDosUltimosSeteDias {
    
    NSDate *beginingOfTheDay = [Utils beginningOfDay];
    NSDate *endOfTheDay = [Utils endOfDay];
    
    NSMutableArray *results = [NSMutableArray new];
    NSMutableArray *labels = [NSMutableArray new];
    [results addObject:@([[Cliente objectsWhere:@"dataCadastro > %@ && dataCadastro < %@", beginingOfTheDay, endOfTheDay] count])];
    [labels addObject:[Utils formmatedDayFromDate:beginingOfTheDay]];
    for (int i = 0; i < 6; i++) {
        beginingOfTheDay = [beginingOfTheDay dateByAddingTimeInterval:60*60*24*-1];
        endOfTheDay = [endOfTheDay dateByAddingTimeInterval:60*60*24*-1];
        
        RLMResults *result = [Cliente objectsWhere:@"dataCadastro > %@ && dataCadastro < %@", beginingOfTheDay, endOfTheDay];
        
        [results addObject:@([result count])];
        [labels addObject:[Utils formmatedDayFromDate:beginingOfTheDay]];
    }
    
    NSDictionary *dict = @{@"labels": [[labels reverseObjectEnumerator] allObjects],
                           @"results":[[results reverseObjectEnumerator] allObjects]};
    
    return dict;
}

@end
