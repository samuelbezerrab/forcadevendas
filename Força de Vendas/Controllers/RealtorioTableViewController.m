//
//  RealtorioTableViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import "RealtorioTableViewController.h"
#import "RelatorioNovosClientePorTempoViewController.h"
#import "RelatorioVendasPorTempoViewController.h"

#import "RelatorioVendasVersusPerdasViewController.h"

@interface RealtorioTableViewController ()

@property (strong, nonatomic) NSArray *relatorios;

@end

@implementation RealtorioTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Relatórios";
    self.relatorios = @[@{@"nome":@"Clientes Cadastrados por Tempo",
                        @"viewController":[RelatorioNovosClientePorTempoViewController new]},
                      @{@"nome":@"Vendas por Tempo",
                        @"viewController":[RelatorioVendasPorTempoViewController new]},
                        @{@"nome":@"Vendas por Perdas",
                          @"viewController":[RelatorioVendasVersusPerdasViewController new]}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (NSInteger)[self.relatorios count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RelatorioCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dict = [self.relatorios objectAtIndex:(NSUInteger)indexPath.row];
    cell.textLabel.text = [dict valueForKey:@"nome"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dict = [self.relatorios objectAtIndex:(NSUInteger)indexPath.row];
    
    UIViewController *vc = [dict valueForKey:@"viewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
