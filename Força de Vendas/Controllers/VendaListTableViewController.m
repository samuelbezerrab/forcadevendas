//
//  VendaListTableViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 22/05/15.
//
//

#import "VendaListTableViewController.h"
#import "VendaDetailViewController.h"
#import "VendaTableViewCell.h"

#import "DataModels.h"

@interface VendaListTableViewController ()

@property (strong, nonatomic) RLMResults *processosDeVenda;

@end

@implementation VendaListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Vendas";
    
    self.processosDeVenda = [ProcessoDeVenda allObjects];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(novaVenda)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.processosDeVenda = [ProcessoDeVenda allObjects];
    [self.tableView reloadData];
}

#pragma mark - Private methods
- (void)novaVenda {
    
    [self.navigationController pushViewController:[VendaDetailViewController new] animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger) [self.processosDeVenda count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VendaCell";
    VendaTableViewCell *cell = (VendaTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[VendaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell inicialiar];
    }
    
    ProcessoDeVenda *pdv = [self.processosDeVenda objectAtIndex:(NSUInteger)indexPath.row];
    
    cell.textLabel.text = pdv.cliente.nome;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", pdv.estagio.nome];
    cell.dataVenda.text = [Utils formmatedStringForDate:pdv.dataInicio];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProcessoDeVenda *pdv = [self.processosDeVenda objectAtIndex:(NSUInteger)indexPath.row];
    
    VendaDetailViewController *vdVC = [VendaDetailViewController new];
    vdVC.processoVenda = pdv;
    
    [self.navigationController pushViewController:vdVC animated:YES];
}






@end
