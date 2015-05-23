//
//  LembreteListTableViewController.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import "LembreteListTableViewController.h"
#import "LembreteDetailViewController.h"
#import "LembreteTableViewCell.h"

@interface LembreteListTableViewController ()

@property (strong, nonatomic) NSArray *lembretes;

@end

@implementation LembreteListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lembretes";
    
    [self registrarParaNotificacoes];
    
    self.lembretes = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    // UI
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(novoLembrete)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.lembretes = [[UIApplication sharedApplication] scheduledLocalNotifications];
    [self.tableView reloadData];
}

#pragma mark - Private methods
- (void)registrarParaNotificacoes {
    UIApplication *application = [UIApplication sharedApplication];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
}

- (void)novoLembrete {
    
    LembreteDetailViewController *ldVC = [LembreteDetailViewController new];
    [self.navigationController pushViewController:ldVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (NSInteger)[self.lembretes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VendaCell";
    LembreteTableViewCell *cell = (LembreteTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LembreteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell inicializar];
    }
    
    UILocalNotification *lembrete = [self.lembretes objectAtIndex:(NSUInteger)indexPath.row];
    cell.textLabel.text = [Utils formmatedStringWithHourForDate:lembrete.fireDate];
    cell.lembreteTextView.text = lembrete.alertBody;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;

}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILocalNotification *lembrete = [self.lembretes objectAtIndex:(NSUInteger)indexPath.row];
    LembreteDetailViewController *ldVC = [LembreteDetailViewController new];
    ldVC.lembrete = lembrete;
    
    [self.navigationController pushViewController:ldVC animated:YES];
    
}


@end
