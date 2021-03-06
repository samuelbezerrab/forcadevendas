//
//  AppDelegate.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 5/21/15
//  Copyright (c) 2015 . All rights reserved.
//

#import "AppDelegate.h"
#import "ClienteListTableViewController.h"
#import "VendaListTableViewController.h"
#import "LembreteListTableViewController.h"
#import "RealtorioTableViewController.h"
#import "HomeViewController.h"

#import <Realm/Realm.h>
#import "DataModels.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    UIViewController *relatoriosVC = [RealtorioTableViewController new];
    UINavigationController *relatoriosNav = [UINavigationController new];
    relatoriosNav.tabBarItem.title = @"Relatórios";
    relatoriosNav.tabBarItem.image = [UIImage imageNamed:@"chart.png"];
    [relatoriosNav pushViewController:relatoriosVC animated:YES];
    
    LembreteListTableViewController *ltVC = [LembreteListTableViewController new];
    UINavigationController *lembretesNav = [UINavigationController new];
    lembretesNav.tabBarItem.title = @"Lembretes";
    lembretesNav.tabBarItem.image = [UIImage imageNamed:@"clock.png"];
    [lembretesNav pushViewController:ltVC animated:NO];

    HomeViewController *hVC = [HomeViewController new];
    UINavigationController *homveNav = [UINavigationController new];
    homveNav.tabBarItem.title = @"Home";
    homveNav.tabBarItem.image = [UIImage imageNamed:@"home"];
    [homveNav pushViewController:hVC animated:NO];
    
    UIViewController *vendasVC = [VendaListTableViewController new];
    UINavigationController *vendaNav = [UINavigationController new];
    vendaNav.tabBarItem.title = @"Vendas";
    vendaNav.tabBarItem.image = [UIImage imageNamed:@"money.png"];
    [vendaNav pushViewController:vendasVC animated:NO];

    UIViewController *clientesVC = [ClienteListTableViewController new];
    UINavigationController *clientesNav = [UINavigationController new];
    clientesNav.tabBarItem.title = @"Clientes";
    clientesNav.tabBarItem.image = [UIImage imageNamed:@"person.png"];
    [clientesNav pushViewController:clientesVC animated:NO];
    
    
    UITabBarController *tabBarController = [UITabBarController new];
    [tabBarController addChildViewController:relatoriosNav];
    [tabBarController addChildViewController:lembretesNav];
    [tabBarController addChildViewController:homveNav];
    [tabBarController addChildViewController:vendaNav];
    [tabBarController addChildViewController:clientesNav];
    
    [tabBarController setSelectedIndex:2];
    
    self.window.rootViewController = tabBarController;
    
    if (![[Utils getDefaults] boolForKey:@"dbCarregado"]) {
        
        [self popuplarDB];
        [[Utils getDefaults] setBool:YES forKey:@"dbCarregado"];
    }

    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [UIAlertView showWithTitle:@"Está na hora de:" message:notification.alertBody cancelButtonTitle:@"Ok" otherButtonTitles:nil tapBlock:nil];
}

#pragma mark - Private methods
- (void)popuplarDB {
    
    EstagioDeProcessoDeVenda *prospecto = [EstagioDeProcessoDeVenda new];
    prospecto.ordenacao = 1;
    prospecto.nome = @"Prospecto";
    
    EstagioDeProcessoDeVenda *qualificado = [EstagioDeProcessoDeVenda new];
    qualificado.ordenacao = 2;
    qualificado.nome = @"Qualificado";
    
    EstagioDeProcessoDeVenda *propostaEnviada = [EstagioDeProcessoDeVenda new];
    propostaEnviada.ordenacao = 3;
    propostaEnviada.nome = @"Proposta Enviada";
    
    EstagioDeProcessoDeVenda *negociacao = [EstagioDeProcessoDeVenda new];
    negociacao.ordenacao = 4;
    negociacao.nome = @"Negociação";
    
    EstagioDeProcessoDeVenda *vendaRealizada = [EstagioDeProcessoDeVenda new];
    vendaRealizada.ordenacao = 5;
    vendaRealizada.nome = @"Venda Realizada";
    
    EstagioDeProcessoDeVenda *vendaPerdida = [EstagioDeProcessoDeVenda new];
    vendaRealizada.ordenacao = 5;
    vendaPerdida.nome = @"Venda Perdida";
    
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:prospecto];
    [realm addObject:qualificado];
    [realm addObject:propostaEnviada];
    [realm addObject:negociacao];
    [realm addObject:vendaRealizada];
    [realm addObject:vendaPerdida];
    [realm commitWriteTransaction];
}

/*
 
 Fix para o grafico:
 Classe: PNBarChart.h
 Linha 94:
 
 CGFloat result =  _yValueMax  - (_yValueMax / [_yValues count] * (index));
 NSString *labelText = [NSString stringWithFormat:@"%.f", result];

*/

@end
