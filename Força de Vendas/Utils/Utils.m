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

+ (NSUserDefaults *)getDefaults {
    
    return [NSUserDefaults standardUserDefaults];
}

+ (NSString *)replaceDotWithCommaForString:(NSString *)string {
    
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    NSRange range = NSMakeRange(0, [mutableString length]);
    
    [mutableString replaceOccurrencesOfString:@"." withString:@"," options:0 range:range];
    
    return [mutableString stringByAppendingString:@""];
}

+ (NSString *)replaceCommaWithDotForString:(NSString *)string {
    
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    NSRange range = NSMakeRange(0, [mutableString length]);
    
    [mutableString replaceOccurrencesOfString:@"," withString:@"." options:0 range:range];
    
    return [mutableString stringByAppendingString:@""];
}

+ (NSString *)formmatedStringForDate:(NSDate *)date {

    NSDateFormatter *dateFormmatter = [[NSDateFormatter alloc] init];
    [dateFormmatter setDateFormat:@"dd/MM/YYYY"];
    return [dateFormmatter stringFromDate:date];
}


@end
