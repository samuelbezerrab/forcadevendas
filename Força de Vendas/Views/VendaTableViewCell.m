//
//  VendaTableViewCell.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 22/05/15.
//
//

#import "VendaTableViewCell.h"

@implementation VendaTableViewCell

- (void)inicialiar {
    
    self.detailTextLabel.textColor = [UIColor grayColor];
    
    self.dataVenda = [UILabel new];
    self.dataVenda .text = @"26/07/05";
    self.dataVenda .font = [UIFont systemFontOfSize:12];
    self.dataVenda .textColor = [UIColor colorWithRed:0.46f green:0.46f blue:0.46f alpha:1];
    self.dataVenda .frame = CGRectMake(225, 6, 70, 30);
    [self.contentView addSubview:self.dataVenda ];
    
}


- (void)setData {
    
}
@end
