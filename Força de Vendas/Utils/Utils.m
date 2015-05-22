//
//  Utils.m
//  Força de Vendas
//
//  Created by Samuel Bispo on 21/05/15.
//
//

#import "Utils.h"

@implementation Utils

// Padrões

+ (UIColor *)defaultColor {

    return [UIColor colorWithRed:0.02f green:0.49f blue:1 alpha:1];
}

+ (UIFont *)defaultFont {
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    return font;
    
}


+ (UIFont *)defaultFontWithSize:(CGFloat)size {    
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
    
    return font;

}

@end
