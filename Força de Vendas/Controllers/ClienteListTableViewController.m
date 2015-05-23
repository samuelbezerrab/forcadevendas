//
//  ClienteListTableViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 22/05/15.
//
//

#import "ClienteListTableViewController.h"
#import "ClienteDetailViewController.h"

#import <Realm/Realm.h>
#import "DataModels.h"

@interface ClienteListTableViewController ()

@property (strong, nonatomic) RLMResults *clientes;

@end

@implementation ClienteListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Clientes";
    self.clientes = [Cliente allObjects];
    
    UIBarButtonItem *novoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(novoCliente)];
    self.navigationItem.rightBarButtonItem = novoButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.clientes = [Cliente allObjects];
    [self.tableView reloadData];
}

#pragma mark - Private methods
- (void)novoCliente {
    
    UIViewController *vc = [ClienteDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  (NSInteger)[self.clientes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ClienteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    Cliente *c = [self.clientes objectAtIndex:(NSUInteger)indexPath.row];
    
    cell.textLabel.text = c.nome;
    cell.detailTextLabel.text = c.nomePessoaDeContato;
    if (!self.vendaVC) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Cliente *cliente = [self.clientes objectAtIndex:(NSUInteger)indexPath.row];
    if (!self.vendaVC) {
        ClienteDetailViewController *cVC = [ClienteDetailViewController new];
        cVC.cliente = cliente;
        
        [self.navigationController pushViewController:cVC animated:YES];

    } else {
        
        self.vendaVC.cliente = cliente;
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

@end
