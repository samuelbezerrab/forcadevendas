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

#import <Realm/Realm.h>
#import "DataModels.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIViewController *clientesVC = [ClienteListTableViewController new];
    UINavigationController *clientesNav = [UINavigationController new];
    [clientesNav pushViewController:clientesVC animated:NO];
    
    
    UIViewController *vendasVC = [VendaListTableViewController new];
    UINavigationController *vendaNav = [UINavigationController new];
    [vendaNav pushViewController:vendasVC animated:NO];

    UITabBarController *tabBarController = [UITabBarController new];
    [tabBarController addChildViewController:clientesNav];
    [tabBarController addChildViewController:vendaNav];
        
    
    self.window.rootViewController = tabBarController;
    
    if (![[Utils getDefaults] boolForKey:@"dbCarregado"]) {
        
        [self popuplarDB];
        [[Utils getDefaults] setBool:YES forKey:@"dbCarregado"];
    }

    return YES;
}


- (void)popuplarDB {
    
    EstagioDeProcessoDeVenda *prospecto = [EstagioDeProcessoDeVenda new];
    prospecto.nome = @"Prospecto";
    
    EstagioDeProcessoDeVenda *qualificado = [EstagioDeProcessoDeVenda new];
    qualificado.nome = @"Qualificado";
    
    EstagioDeProcessoDeVenda *propostaEnviada = [EstagioDeProcessoDeVenda new];
    propostaEnviada.nome = @"Proposta Enviada";
    
    EstagioDeProcessoDeVenda *negociacao = [EstagioDeProcessoDeVenda new];
    negociacao.nome = @"Negociação";
    
    EstagioDeProcessoDeVenda *vendaRealizada = [EstagioDeProcessoDeVenda new];
    vendaRealizada.nome = @"Venda Realizada";
    
    EstagioDeProcessoDeVenda *vendaPerdida = [EstagioDeProcessoDeVenda new];
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

@end
