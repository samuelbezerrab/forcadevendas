//
//  AppDelegate.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 5/21/15
//  Copyright (c) 2015 . All rights reserved.
//

#import "AppDelegate.h"
#import "ClienteListTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIViewController *vc = [ClienteListTableViewController new];

    UINavigationController *navControlelr = [UINavigationController new];
    [navControlelr pushViewController:vc animated:NO];
    
    self.window.rootViewController = navControlelr;
    

    return YES;
}

@end
