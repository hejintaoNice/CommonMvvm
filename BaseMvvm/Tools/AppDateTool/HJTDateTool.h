//
//  HJTDateTool.h
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJTDateTool : NSObject

/**
 *  NSDate -> yyyy-MM-dd
 *
 *  @param date 时间
 *
 *  @return yyyy-MM-dd格式的字符串
 */
+ (NSString *)dateForFormatOneWithDate:(NSDate *)date;

/**
 *  后台int类型的时间戳转换成字符串 MM月dd日
 *
 *  @param timeStamp 后台的时间戳
 *
 *  @return MM月dd日格式的字符串
 */
+ (NSString *)dateForFormatOneWithTimeStamp:(NSString *)timeStamp;


/**
 *  根据传入的开始日期与结束日期判断日期是否选择合法
 *
 *  @param startDate 开始日期
 *  @param endDate   结束日期
 *
 *  @return 是否合法（当前日期 <= 开始日期 <= 结束日期）
 */
+ (NSString *)dateJudgeWithStartDate:(NSString *)startDate endData:(NSString *)endDate;

/**
 根据传入的时间戳返回几分钟前 几小时前 几天前....
 
 @param dateStr 传入的时间戳字符串
 @return 返回 XX前
 */
+ (NSString *)translateDate:(NSString *)dateStr;


/**
 yyyy-MM-dd -> NSDate

 @param timeStr timeStr 标准时间
 @return 时间戳
 */
+(long)returnNSDateWithStandardTime:(NSString*)timeStr;
@end
