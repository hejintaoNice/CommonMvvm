//
//  DJNavgationController.m
//  WonderfulDJ
//
//  Created by 何锦涛 on 2017/11/6.
//  Copyright © 2017年 hither. All rights reserved.
//

#import "DJNavgationController.h"

@interface DJNavgationController ()

@end

@implementation DJNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
}

// 重写push方法,方便统一处理返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self) {
        // 判断下是否是根控制器
        if (self.childViewControllers.count != 0) { // 非根控制器
            viewController.hidesBottomBarWhenPushed = YES;
            // 设置导航条左边的按钮
            UIBarButtonItem *flexBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            flexBtn.width = -8;
            UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_red_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
            viewController.navigationItem.leftBarButtonItems = @[flexBtn,backBtn];
        }else{
            viewController.hidesBottomBarWhenPushed = NO;
        }
        [super pushViewController:viewController animated:animated];
    }
}

// 返回到上一个界面
- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
