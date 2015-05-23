//
//  Utils.h
//  Força de Vendas
//
//  Created by Samuel Bispo on 21/05/15.
//
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (UIColor *)defaultColor;
+ (UIFont *)defaultFont;
+ (UIFont *)defaultFontWithSize:(CGFloat)size;

+ (NSUserDefaults *)getDefaults;
+ (NSString *)replaceDotWithCommaForString:(NSString *)string;
+ (NSString *)replaceCommaWithDotForString:(NSString *)string;
+ (NSString *)formmatedStringForDate:(NSDate *)date;
+ (NSString *)formmatedStringWithHourForDate:(NSDate *)date;

@end
