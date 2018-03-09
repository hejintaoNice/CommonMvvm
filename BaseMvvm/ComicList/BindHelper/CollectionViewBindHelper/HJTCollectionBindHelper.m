//
//  HJTCollectionBindHelper.m
//  PatientTools
//
//  Created by 何锦涛 on 2017/11/3.
//  Copyright © 2017年 HappyCloud. All rights reserved.
//

#import "HJTCollectionBindHelper.h"
#import "HJTBindViewDelegate.h"

@interface HJTCollectionBindHelper ()

@property (nonatomic, strong) NSString * cellIdentifier;

@end

@implementation HJTCollectionBindHelper

//Normal
+ (instancetype)bindingForCollectionView:(UICollectionView *)collectionView sourceList:(NSArray *)source didSelectionBlock:(collectionSelectionBlock)block templateCell:(UINib *)templateCellNib {
    return [[self alloc] initForCollectionView:collectionView sourceList:source didSelectionBlock:block templateCell:templateCellNib];
}

+ (instancetype)bindingForCollectionView:(UICollectionView *)collectionView sourceList:(NSArray *)source didSelectionBlock:(collectionSelectionBlock)block templateCellClassName:(NSString *)templateCellClass {
    return [[self alloc] initForCollectionView:collectionView sourceList:source didSelectionBlock:block templateCellClassName:templateCellClass];
}

- (instancetype)initForCollectionView:(UICollectionView *)collectionView sourceList:(NSArray *)source didSelectionBlock:(collectionSelectionBlock)block {
    NSParameterAssert(collectionView);
    NSParameterAssert(source);
    
    self = [super init];
    if (!self) return nil;
    
    _collectionView = collectionView;
    _data = [NSMutableArray arrayWithArray:source];
    _selectBlock = [block copy];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    return self;
}

- (instancetype)initForCollectionView:(UICollectionView *)collectionView sourceList:(NSArray *)source didSelectionBlock:(collectionSelectionBlock)block templateCell:(UINib *)templateCellNib {
    self = [self initForCollectionView:collectionView sourceList:source didSelectionBlock:block];
    if (!self) return nil;
    _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
    _cellIdentifier = _templateCell.reuseIdentifier;
    [_collectionView registerNib:templateCellNib forCellWithReuseIdentifier:_cellIdentifier];
    
    [self customInitialization];
    return self;
}

- (instancetype)initForCollectionView:(UICollectionView *)collectionView sourceList:(NSArray *)source didSelectionBlock:(collectionSelectionBlock)block templateCellClassName:(NSString *)templateCellClass {
    self = [self initForCollectionView:collectionView sourceList:source didSelectionBlock:block];
    if (!self) return nil;
    self.cellIdentifier = templateCellClass;
    [_collectionView registerClass:NSClassFromString(templateCellClass) forCellWithReuseIdentifier:templateCellClass];
    
    [self customInitialization];
    return self;
}

- (void)customInitialization {
    //abstract...
}

#pragma mark - DataSource and Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueCellAndBindInCollectionView:collectionView indexPath:indexPath];
}

- (UICollectionViewCell *)dequeueCellAndBindInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    id<HJTBindViewDelegate> cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    [cell bindModel:_data[indexPath.row]];
    return (UICollectionViewCell *)cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectBlock) {
        _selectBlock(_data[indexPath.row],indexPath);
    }
}

#pragma mark - Custon Action
- (void)reloadDataWithSourceList:(NSArray *)source{
    if (source) {
        _data = [NSMutableArray arrayWithArray:source];
    }
    [_collectionView reloadData];
}

@end
