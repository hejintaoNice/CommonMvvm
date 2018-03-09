//
//  ComicDetailViewController.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/9.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "ComicDetailViewController.h"

@interface ComicDetailViewController ()

@property (nonatomic, strong) ComicRecommend *comicRecommend;

@end

@implementation ComicDetailViewController

-(instancetype)initWithDataModel:(ComicRecommend *)model{
    self = [super init];
    if (self) {
        _comicRecommend = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.comicRecommend.comic_name;
    NSLog(@"result--->%@", _comicRecommend);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
