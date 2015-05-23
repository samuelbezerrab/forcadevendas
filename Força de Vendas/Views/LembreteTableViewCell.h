//
//  LembreteTableViewCell.h
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import <UIKit/UIKit.h>

@interface LembreteTableViewCell : UITableViewCell

@property (strong, nonatomic) UITextView *lembreteTextView;

- (void)inicializar;

@end
