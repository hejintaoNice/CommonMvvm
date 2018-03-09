//
//  HJTTableViewBindingHelper.m
//  PatientTools
//
//  Created by 何锦涛 on 2017/11/3.
//  Copyright © 2017年 HappyCloud. All rights reserved.
//

#import "HJTTableViewBindingHelper.h"
#import "HJTBindViewDelegate.h"

@interface HJTTableViewBindingHelper ()

@property (nonatomic, strong) NSString * cellIdentifier;

@end

@implementation HJTTableViewBindingHelper

//Normal
+ (instancetype)bindingForTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(tableSelectionBlock)block templateCell:(UINib *)templateCellNib {
    return [[self alloc] initWithTableView:tableView sourceList:source didSelectionBlock:block templateCell:templateCellNib];
}

+ (instancetype)bindingForTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(tableSelectionBlock)block templateCellClassName:(NSString *)templateCellClass {
    return [[self alloc] initWithTableView:tableView sourceList:source didSelectionBlock:block templateCellClassName:templateCellClass];
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(tableSelectionBlock)block {
    NSParameterAssert(tableView);
    NSParameterAssert(source);
    self = [super init];
    if (self) {
        _tableView = tableView;
        _data = source;
        _selectionBlock = [block copy];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(tableSelectionBlock)block templateCell:(UINib *)templateCellNib {
    self = [self initWithTableView:tableView sourceList:source didSelectionBlock:block];
    if (self) {
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        [_tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        [self customInitialization];
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView sourceList:(NSArray *)source didSelectionBlock:(tableSelectionBlock)block templateCellClassName:(NSString *)templateCellClass {
    self = [self initWithTableView:tableView sourceList:source didSelectionBlock:block];
    if (self) {
        self.cellIdentifier = templateCellClass;
        [tableView registerClass:NSClassFromString(templateCellClass) forCellReuseIdentifier:templateCellClass];
        
        [self customInitialization];
    }
    return self;
}

- (void)customInitialization {
    //abstract...
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueCellAndBindInTable:tableView indexPath:indexPath];
}

- (UITableViewCell *)dequeueCellAndBindInTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    id<HJTBindViewDelegate> cell = [tableView dequeueReusableCellWithIdentifier:_templateCell.reuseIdentifier];
    [cell bindModel:_data[indexPath.row]];
    return (UITableViewCell *)cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectionBlock) {
        _selectionBlock(_data[indexPath.row]);
    }
}

#pragma mark - Action
- (void)reloadDataWithSourceList:(NSArray *)source {
    if (source) {
        _data = source;
    }
    [_tableView reloadData];
}

@end
