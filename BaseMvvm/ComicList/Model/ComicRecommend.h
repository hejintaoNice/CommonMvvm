//
//  ComicRecommend.h
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/8.
//  Copyright © 2018年 hither. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ComicRecommend : JSONModel

@property (nonatomic, copy) NSString *comic_name;

@property (nonatomic, copy) NSString *comic_id;

@property (nonatomic, copy) NSString *last_chapter_name;

@end
