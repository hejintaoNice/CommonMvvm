//
//  HJTDateFormatter.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "HJTDateFormatter.h"

@implementation HJTDateFormatter

+ (instancetype)defaultDateFormatter {
    
    static HJTDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        dateFormatter = [[HJTDateFormatter alloc] init];
        
    });
    
    return dateFormatter;
}

@end
