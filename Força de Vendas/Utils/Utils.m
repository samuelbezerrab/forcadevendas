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

+ (NSString *)formmatedStringWithHourForDate:(NSDate *)date {
    
    NSDateFormatter *dateFormmatter = [[NSDateFormatter alloc] init];
    [dateFormmatter setDateFormat:@"hh:mm'h -' dd' de 'MMM"];
    return [dateFormmatter stringFromDate:date];
}

+ (NSString *)formmatedDayFromDate:(NSDate *)date {
    
    NSDateFormatter *dateFormmatter = [[NSDateFormatter alloc] init];
    [dateFormmatter setDateFormat:@"dd"];
    return [dateFormmatter stringFromDate:date];
}

+ (NSDate *)beginningOfDay{
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* dateComponents = [gregorian components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:[NSDate date]];
    
    [dateComponents setHour:00];
    [dateComponents setMinute:00];
    [dateComponents setSecond:00];
    
    return [gregorian dateFromComponents:dateComponents];
}

+ (NSDate *)endOfDay{
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* dateComponents = [gregorian components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:[NSDate date]];
    
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    
    return [gregorian dateFromComponents:dateComponents];
}

@end
