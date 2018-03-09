//
//  ComicDetailViewController.h
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/9.
//  Copyright © 2018年 hither. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComicRecommend.h"

@interface ComicDetailViewController : UIViewController

- (instancetype)initWithDataModel:(ComicRecommend *)model;

@end
