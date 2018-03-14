//
//  BaseViewModel.m
//  PatientTools
//
//  Created by 何锦涛 on 2017/10/30.
//  Copyright © 2017年 HappyCloud. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}

@end
