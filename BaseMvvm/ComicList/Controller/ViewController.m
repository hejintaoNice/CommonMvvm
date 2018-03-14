//
//  ViewController.m
//  BaseMvvm
//
//  Created by 何锦涛 on 2018/3/8.
//  Copyright © 2018年 hither. All rights reserved.
//

#import "ViewController.h"
#import "VTGridViewCell.h"
#import "ComicListViewModel.h"
#import "ComicRecommend.h"

DefineCellID(VTGridViewCell_re_id,@"VTGridViewCell")

@interface ViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ComicListViewModel *viewModel;
@property (nonatomic, strong) HJTCollectionBindHelper *bindHelper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    //配置刷新
    [self configHeaderRefresh];
    //从服务器获取数据
    [self getNewDataFromServer];
    
}

- (void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    AdjustsScrollViewInsetNever(self, self.collectionView);
    [self.view addSubview:self.collectionView];
    
}

- (void)configHeaderRefresh{
    W_S
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf getNewDataFromServer];
    }];
    
}

- (void)configFooterRefresh{
    W_S
    self.collectionView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [weakSelf getMoreDataFromServer];
    }];
}

- (void)getNewDataFromServer{
    W_S
    [self.viewModel getNewDataFromServer:^(NSArray *resultArray, BOOL suc) {
        [weakSelf.collectionView.mj_footer resetNoMoreData];
        
        [weakSelf.collectionView.mj_header endRefreshing];
        
        if (suc) {
            [weakSelf configUIWithData:resultArray];
            [weakSelf configFooterRefresh];
        }
    }];
}

- (void)getMoreDataFromServer{
    W_S
    [self.viewModel getMoreDataFromServer:^(NSArray *resultArray, BOOL suc, BOOL showNoMoreState) {
        
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (showNoMoreState) {
            [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
        if (suc) {
            [weakSelf configUIWithData:resultArray];
        }
        
    }];
}

-(void)configUIWithData:(NSArray *)array{
    W_S
    self.bindHelper = [HJTCollectionBindHelper bindingForCollectionView:self.collectionView sourceList:array didSelectionBlock:^(ComicRecommend *model, NSIndexPath *indexPath) {
        
        NSLog(@"indexPath == %@", indexPath);
        [weakSelf.viewModel goDetailPageWithModel:model WithViewController:self];
        
    } templateCellClassName:VTGridViewCell_re_id];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- lazyLoad

-(ComicListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ComicListViewModel alloc] init];
    }
    return _viewModel;
}

-(HJTCollectionBindHelper *)bindHelper{
    if (!_bindHelper) {
        _bindHelper = [[HJTCollectionBindHelper alloc] init];
    }
    return _bindHelper;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/3, (4 *(SCREEN_WIDTH - 60) / 9.0 + 34));
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        CollectionViewNOXIBRegisterCell(_collectionView,VTGridViewCell,VTGridViewCell_re_id);
    }
    return _collectionView;
}


@end
