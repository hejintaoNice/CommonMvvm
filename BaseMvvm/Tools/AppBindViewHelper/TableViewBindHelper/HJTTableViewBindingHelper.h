//
//  HJTTableViewBindingHelper.h
//  PatientTools
//
//  Created by 何锦涛 on 2017/11/3.
//  Copyright © 2017年 HappyCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^tableSelectionBlock)(id model,NSIndexPath *indexPath);

@interface HJTTableViewBindingHelper : NSObject<UITableViewDataSource, UITableViewDelegate>
{
    UITableView             *_tableView;
    NSArray                 *_data;
    UITableViewCell         *_templateCell;
    tableSelectionBlock      _selectionBlock;
}


/**
 将xib绘制的cell、数据、绑定到制定的tableView上

 @param tableView 需要绑定的tableView
 @param source 数据源
 @param block 事件绑定
 @param templateCellNib 待绑定的nib文件
 @return 组装好的tableView
 */
+ (instancetype)bindingForTableView:(UITableView *)tableView
                         sourceList:(NSArray *)source
                  didSelectionBlock:(tableSelectionBlock)block
                       templateCell:(UINib *)templateCellNib;


/**
 将代码绘制的cell、数据、绑定到制定的tableView上

 @param tableView 需要绑定的tableView
 @param source 数据源
 @param block 事件绑定
 @param templateCellClass 待绑定的cell文件名
 @return 组装好的tableView
 */
+ (instancetype)bindingForTableView:(UITableView *)tableView
                         sourceList:(NSArray *)source
                  didSelectionBlock:(tableSelectionBlock)block
              templateCellClassName:(NSString *)templateCellClass;

- (void)customInitialization;
- (void)reloadDataWithSourceList:(NSArray *)source;
- (UITableViewCell *)dequeueCellAndBindInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
