//
//  RefreshTimeModel.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "RefreshTimeModel.h"

@interface RefreshTimeModel ()

@property (nonatomic, strong) NSDate *oldRefreshDate;

@end

@implementation RefreshTimeModel


/**
 返回refreshTime，一分钟以内不改变此值

 @return <#return value description#>
 */
-(NSString *)refreshInterval{
    
    NSDate *date = [NSDate date];
    double refreshtime = [(_oldRefreshDate ? _oldRefreshDate:date) timeIntervalSince1970];
    
    if (_oldRefreshDate) {
        NSTimeInterval interval = [date timeIntervalSinceDate:_oldRefreshDate];
        int minute = ((int)interval)%(3600*24)%3600/60;
        if (minute >= 1) {
            refreshtime = [date timeIntervalSince1970];
            _oldRefreshDate = date;
        }
    }
    else{
        _oldRefreshDate = date;
    }
    NSString *pms = [NSString stringWithFormat:@"&refreshTime=%.f",refreshtime/60.0];
    
    return pms;
}

@end
