//
//  RefreshTimeModel.h
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefreshTimeModel : NSObject


/**
 返回一个时间戳  用于网络数据请求 避免DNS缓存  主动刷新DNS

 @return <#return value description#>
 */
- (NSString *)refreshInterval;

@end
