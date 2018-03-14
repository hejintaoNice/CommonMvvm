//
//  HJTStringTool.h
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJTStringTool : NSObject

/**
 *  将字符串进行百分号编码
 *
 *  @param str 目标字符串
 *
 *  @return 经过百分号编码后的字符串
 */
+(NSString *)string2percentEncode:(NSString*)str;

/**
 *  截取任意两个字符之间的字符串
 *
 *  @param startRange 第一个条件字符串
 *  @param endRange   第二个条件字符串
 *  @param string     目标字符串
 *
 *  @return 截取任意两个字符之间字符串
 */
+(NSString*)stringCutOffWithstartRange:(NSString *)startRange endRange:(NSString *)endRange andStr:(NSString *)string;

/**
 *  判断字符串是不是全是空格
 *
 *  @param string 目标字符串
 *
 *  @return 返回是与否
 */
+(BOOL)allSpace:(NSString *)string;
/**
 *  将汉字转化成拼音
 *
 *  @param chinese 中文
 *
 *  @return 小写拼音
 */
+ (NSString *)transform:(NSString *)chinese;
/**
 *  将字符串中的空格去掉再输出
 *
 *  @param chinese 目标字符串
 *
 *  @return 转换后的字符串
 */
+ (NSString *)deleteSpacesInString:(NSString *)string;
/**
 *  判断字符串中是否包含数字
 *
 *  @param chinese 目标字符串
 *
 *  @return 包含-->YES   不包含-->NO
 */
+ (BOOL)isStringContainNumberWith:(NSString *)str;
/**
 *  从字符串中拿到第一组数字
 *
 *  @param chinese 目标字符串
 *
 *  @return 返回数字字符串
 */
+ (NSString *)getNumFromString:(NSString *)string;
/**
 处理含有emoji编码的的字符串
 
 @param string 目标字符串
 @return 返回带有emoji表情的字符串
 */
+ (NSString*)unmaskEmoji:(NSString *)string;

/**
 将JSON字符串转化为字典
 
 @param JSONString 目标字符串
 @return 字典
 */
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

/**
 将对象转为Json
 */
+(NSString *)convertToJSONData:(id)infoDict;

/**
 encoding
 */
+ (NSString *)encodeString:(NSString*)sourceString;

/**
   格式化章节名
 */
+ (NSString *)formatChapterName:(NSString *)cname appendLength:(NSInteger)appendLength;

/**
 二进制转换字典
 
 @param responseObject 带转化的二进制
 @return 字典
 */
+ (NSDictionary *)transformation:(id)responseObject;

/**
 判断字符串是否是纯数字
 
 @param target 目标字符串
 @return YES 纯数字    NO 不是纯数字
 */
+(BOOL)judgeStrIsOrNotPureNumber:(NSString *)target;

@end
