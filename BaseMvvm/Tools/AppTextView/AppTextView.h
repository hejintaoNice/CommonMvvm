//
//  AppTextView.h
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/14.
//  Copyright © 2018年 hither. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppTextView : UITextView

@property (nonatomic, strong) UIFont *placeholderFont;

@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, copy) NSString *placeholder;

@end
