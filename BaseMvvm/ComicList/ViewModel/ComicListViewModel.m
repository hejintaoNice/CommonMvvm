//
//  ComicListViewModel.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/8.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "ComicListViewModel.h"
#import "ComicDetailViewController.h"

@interface ComicListViewModel()

//用于存放漫画列表数据的数组
@property (nonatomic, strong) NSMutableArray *comicDataAry;
//加载更多
@property (nonatomic, assign) NSInteger current_page;

@end

@implementation ComicListViewModel

#pragma mark -- 跳转逻辑

-(void)goDetailPageWithModel:(ComicRecommend *)model WithViewController:(UIViewController *)superController{
    
    ComicDetailViewController *vc = [[ComicDetailViewController alloc]initWithDataModel:model];
    vc.hidesBottomBarWhenPushed = YES;
    [superController.navigationController pushViewController:vc animated:YES];
}



#pragma mark -- 数据逻辑

-(void)getNewDataFromServer:(callBack)callBack{
    
    self.current_page = 1;
    
    [PPNetworkHelper GET:[NSString stringWithFormat:@"%@%@&orderby=%@&page=1",GetCategoryList,@"?comic_sort=baihe",@"click"] parameters:nil success:^(id responseObject) {
        
        if (self.comicDataAry.count > 0) {
            [self.comicDataAry removeAllObjects];
        }
        
        NSDictionary *dic = responseObject;
        NSArray *ary = [dic valueForKey:@"data"];
        
        for (NSDictionary *dic in ary) {
            @autoreleasepool{
                ComicRecommend *model = [[ComicRecommend alloc]initWithDictionary:dic error:nil];
                [self.comicDataAry addObject:model];
            }
        }
        
        if (callBack) {
            callBack(self.comicDataAry, self.comicDataAry.count > 0);
        }
        
    } failure:^(NSError *error) {
        
        if (callBack) {
            callBack(nil, NO);
        }
        
    }];
    
}

/*
 NSMutableDictionary *params = [NSMutableDictionary dictionary];
 [params setObject:showType forKey:@"showType"];
 */


-(void)getMoreDataFromServer:(pullUpCallBack)callBack{
    
    if (self.current_page < 2) {
        self.current_page = 2;
    }
    
    [PPNetworkHelper GET:[NSString stringWithFormat:@"%@%@&orderby=%@&page=%ld",GetCategoryList,@"?comic_sort=baihe",@"click",_current_page] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *ary = [dic valueForKey:@"data"];
        
        NSString *total_page = dic[@"page"][@"total_page"];
        
        if (_current_page <= [total_page integerValue]) {
            _current_page ++;
        }

        NSSet *set = [NSSet setWithArray:ary];
        ary = set.allObjects;
        
        for (NSDictionary *dic in ary) {
            @autoreleasepool{
                ComicRecommend *model = [[ComicRecommend alloc]initWithDictionary:dic error:nil];
                [self.comicDataAry addObject:model];
            }
        }
        
        if (callBack) {
            callBack(self.comicDataAry, self.comicDataAry.count > 0,ary.count <= 0);
        }
        
    } failure:^(NSError *error) {
        
        if (callBack) {
            callBack(nil, NO, NO);
        }
        
    }];
    
}

#pragma mark -- lazyLoad

-(NSMutableArray *)comicDataAry{
    if (!_comicDataAry) {
        _comicDataAry = [[NSMutableArray alloc] init];
    }
    return _comicDataAry;
}

@end
