//
//  DJMainTabBarVC.m
//  WonderfulDJ
//
//  Created by 何锦涛 on 2017/11/6.
//  Copyright © 2017年 hither. All rights reserved.
//

#import "DJMainTabBarVC.h"
#import "DJNavgationController.h"
#import "ViewController.h"

#define ClassKey   @"rootVCClassString"
#define TitleKey   @"title"
#define ImgKey     @"imageName"
#define SelImgKey  @"selectedImageName"

@interface DJMainTabBarVC ()

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation DJMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [UITabBar appearance].translucent = NO;
    self.tabBar.barTintColor = [UIColor whiteColor];
    [self setUpChildVC];
    
}

-(void)setUpChildVC{
    NSArray *childItemsArray = @[
                                 @{ClassKey  : @"ViewController",
                                   TitleKey  : @"首页",
                                   ImgKey    : @"ic_tab bar_home_no",
                                   SelImgKey : @"ic_tab bar_home_hl"}];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:13.0];
    UIColor *color_act = RGBCOLOR(254,85,38);
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        self.vc = [[NSClassFromString(dict[ClassKey]) alloc]init];
        self.vc.title = dict[TitleKey];
        DJNavgationController *nav = [[DJNavgationController alloc] initWithRootViewController:self.vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[TitleKey];
        item.image = [[UIImage imageNamed:dict[ImgKey]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:dict[SelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : color_act,NSFontAttributeName:font} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSFontAttributeName:font} forState:UIControlStateNormal];
        
        [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
        [self addChildViewController:nav];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
