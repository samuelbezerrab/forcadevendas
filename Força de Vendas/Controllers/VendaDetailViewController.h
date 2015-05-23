//
//  VendaDetailViewController.h
//  Força de Vendas
//
//  Created by Samuel Bispo on 22/05/15.
//
//

#import <UIKit/UIKit.h>

#import "DataModels.h"

@interface VendaDetailViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) ProcessoDeVenda *processoVenda;
@property (strong, nonatomic) Cliente *cliente;

@end
