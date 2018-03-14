//
//  BaseViewModel.h
//  PatientTools
//
//  Created by 何锦涛 on 2017/10/30.
//  Copyright © 2017年 HappyCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();

@interface BaseViewModel : NSObject

@property (nonatomic, strong) ReturnValueBlock returnBlock;
@property (nonatomic, strong) ErrorCodeBlock errorBlock;
@property (nonatomic, strong) FailureBlock failureBlock;

-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

@end
