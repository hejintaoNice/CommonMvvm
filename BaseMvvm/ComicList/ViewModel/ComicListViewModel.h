//
//  ComicListViewModel.h
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/8.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "BaseViewModel.h"
#import "ComicRecommend.h"
//用于下拉
typedef void (^callBack) (NSArray *resultArray,BOOL suc);
//用于上拉
typedef void (^pullUpCallBack) (NSArray *resultArray,BOOL suc, BOOL showNoMoreState);

@interface ComicListViewModel : BaseViewModel

//下拉刷新
- (void)getNewDataFromServer:(callBack) callBack;

//上拉加载
- (void)getMoreDataFromServer:(pullUpCallBack) callBack;


//进入详情页
- (void)goDetailPageWithModel:(ComicRecommend *)model WithViewController: (UIViewController *)superController;

@end
