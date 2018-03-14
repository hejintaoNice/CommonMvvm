//
//  HJTCollectionBindHelper.h
//  PatientTools
//
//  Created by 何锦涛 on 2017/11/3.
//  Copyright © 2017年 HappyCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^collectionSelectionBlock)(id model,NSIndexPath *indexPath);

@interface HJTCollectionBindHelper : NSObject<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray              *_data;
    UICollectionView            *_collectionView;
    UICollectionViewCell        *_templateCell;
    collectionSelectionBlock     _selectBlock;
}


/**
 将xib绘制的cell、数据、绑定到制定的collectionView上

 @param collectionView 需要绑定的collectionView
 @param source 数据源
 @param block 事件绑定
 @param templateCellNib 待绑定的nib文件
 @return 组装好的collectionView
 */
+ (instancetype)bindingForCollectionView:(UICollectionView *)collectionView
                              sourceList:(NSArray *)source
                       didSelectionBlock:(collectionSelectionBlock)block
                            templateCell:(UINib *)templateCellNib;


/**
 将代码绘制的cell、数据、绑定到制定的collectionView上

 @param collectionView 需要绑定的collectionView
 @param source 数据源
 @param block 事件绑定
 @param templateCellClass 待绑定的cell文件名
 @return 组装好的collectionView
 */
+ (instancetype)bindingForCollectionView:(UICollectionView *)collectionView
                              sourceList:(NSArray *)source
                       didSelectionBlock:(collectionSelectionBlock)block
                   templateCellClassName:(NSString *)templateCellClass;

- (void)customInitialization;
- (void)reloadDataWithSourceList:(NSArray *)source;
- (UICollectionViewCell *)dequeueCellAndBindInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
