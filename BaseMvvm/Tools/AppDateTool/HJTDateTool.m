//
//  HJTDateTool.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "HJTDateTool.h"
#import "HJTDateFormatter.h"

@implementation HJTDateTool

+ (NSString *)dateForFormatOneWithDate:(NSDate *)date {
    [[HJTDateFormatter defaultDateFormatter] setDateFormat:@"yyyy-MM-dd"];
    return [[HJTDateFormatter defaultDateFormatter] stringFromDate:date];
}

+ (NSString *)dateForFormatOneWithTimeStamp:(NSString *)timeStamp {
    // 都是从1970开始
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    // 用于NSdate对象的格式化
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设置格式 zzz表示时区
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    // 设置地区
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    // NSDate转NSString
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)dateJudgeWithStartDate:(NSString *)startDate endData:(NSString *)endDate {
    [[HJTDateFormatter defaultDateFormatter] setDateFormat:@"yyyy-MM-dd"];
    
    // 当前日期
    NSString *currenDate = [[HJTDateFormatter defaultDateFormatter] stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    if (startDate.length != 0 && endDate.length != 0) {
        if ([startDate compare:endDate] == NSOrderedDescending) {
            return @"结束时间不应小于开始时间";
        }
    } else if (startDate.length != 0) {
        if ([startDate compare:currenDate] == NSOrderedAscending) {
            return @"开始时间不应小于当前时间";
        }
    } else {
        if ([endDate compare:currenDate] == NSOrderedAscending) {
            return @"结束时间不应小于当前时间";
        }
    }
    
    return nil;
}

+(NSString *)translateDate:(NSString *)dateStr{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [self compareCurrentTime:[formatter stringFromDate:confromTimesp]] ;
}

+ (NSString *)compareCurrentTime:(NSString *)str{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    NSString *result;
    
    if (timeInterval/60 < 1) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <10){
        if (temp == 1) {
            result = @"昨天";
        }else if(temp == 2){
            result = @"前天";
        }else{
            result = [NSString stringWithFormat:@"%ld天前",temp];
        }
    }
    else { //显示年月日
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        result = [dateFormatter stringFromDate:timeDate];
    }
    
    return result;
}

+(long)returnNSDateWithStandardTime:(NSString*)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *lastTime = timeStr;
    NSDate *lastDate = [formatter dateFromString:lastTime];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970];
    return firstStamp;
}




@end
