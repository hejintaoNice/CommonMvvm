//
//  HJTStringTool.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "HJTStringTool.h"

@implementation HJTStringTool


+(NSString *)string2percentEncode:(NSString*)str{
    
    return  [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
}

+(NSString*)stringCutOffWithstartRange:(NSString *)startRange endRange:(NSString *)endRange andStr:(NSString *)string{
    
    NSRange start = [string rangeOfString:startRange];
    NSRange end = [string rangeOfString:endRange];
    NSRange range = NSMakeRange(start.location + start.length, end.location - start.location - start.length);
    
    return [string substringWithRange:range];
    
}

+ (BOOL)allSpace:(NSString *)string {
    
    BOOL isAllSapce = NO;
    // 获取被空格分割后是空的字符串的个数
    NSInteger number = 0;
    NSArray *array = [string componentsSeparatedByString:@" "];
    for (NSString *str in array) {
        if ([str isEqualToString:@""]) {
            number++;
        }
    }
    // 如果空的字符串的个数等于 string.length+1，就说明全部是空格
    if (number == string.length+1) {
        isAllSapce = YES;
    }
    
    return isAllSapce;
    
}

+ (NSString *)transform:(NSString *)chinese{
    
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    return pinyin;
    
}
    
+ (NSString *)deleteSpacesInString:(NSString *)string{
    
    if ([string containsString:@" "]) {
        return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    } else {
        return string;
    }
    
}

+(BOOL)isStringContainNumberWith:(NSString *)str{
    
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
    
}

+ (NSString *)getNumFromString:(NSString *)string{
    
    //如果不包含数字 直接原样返回
    if (![HJTStringTool isStringContainNumberWith:string]) {
        return string;
    }
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSString *num=[NSString stringWithFormat:@"%d",number];
    return num;
    
}

+ (NSString*)unmaskEmoji:(NSString *)string{
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:
                                              @"\\[emoji:\\w{8}\\]"
                                                                                       options:0 error:nil];
    
    NSArray * a = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSString *resultString = string;
    
    for (NSInteger i = a.count - 1; i >= 0; i --) {
        NSTextCheckingResult *result = a[i];
        
        NSRange range = NSMakeRange(result.range.location+7, result.range.length-8);
        NSString *test = [string substringWithRange:range];
        test = [self convertString2Unicode:test];
        resultString = [resultString stringByReplacingCharactersInRange:result.range withString:test];
    }
    
    return resultString;
    
}


+ (NSString * )convertString2Unicode:(NSString *)input{
    
    if (input.length && input.length == 8) {
        
        unsigned short one = strtoul([[input substringWithRange:NSMakeRange(0, 4)] UTF8String],0,16);
        unsigned short two = strtoul([[input substringWithRange:NSMakeRange(4, 4)] UTF8String],0,16);
        
        return  [NSString stringWithFormat:@"%C%C",one,two];
        
    }
    else{
        return input;
    }
    
}

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    return responseJSON;
    
}

+(NSString *)convertToJSONData:(id)infoDict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (jsonData)
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
    
}

+ (NSString *)encodeString:(NSString*)sourceString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)sourceString,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

+ (NSString *)formatChapterName:(NSString *)cname appendLength:(NSInteger)appendLength{
    
    NSArray *sepArray = @[@"话",@"节",@"章",@"集",@"册"];
    for (NSString *str in sepArray) {
        if ([cname containsString:str]) {
            NSRange rg = [cname rangeOfString:str];
            if (rg.location + appendLength < cname.length) {
                NSRange rg2 = NSMakeRange(0, rg.location+appendLength);
                return [cname substringWithRange:rg2];
            }
            NSRange rg2 = NSMakeRange(0, rg.location+1);
            return [cname substringWithRange:rg2];
        }
    }
    
    return cname;
    
}


+ (NSDictionary *)transformation:(id)responseObject{
    
    NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    return dic;
}

+(BOOL)judgeStrIsOrNotPureNumber:(NSString *)target{
    
    if ([target isKindOfClass:[NSNumber class]]) {
        return YES;
    }
    
    target = [target stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    
    if(target.length > 0)
    {
        return NO;
    }
    return YES;
    
}

@end
