//
//  LembreteTableViewCell.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 23/05/15.
//
//

#import "LembreteTableViewCell.h"

@implementation LembreteTableViewCell

- (void)inicializar {
    
    self.lembreteTextView = [UITextView new];
    self.lembreteTextView.frame = CGRectMake(170, 00, 120, 40);
    self.lembreteTextView.editable = NO;
    self.lembreteTextView.scrollEnabled = YES;
    self.lembreteTextView.font = [Utils defaultFontWithSize:9];
    [self.contentView addSubview:self.lembreteTextView];
    
}

@end
