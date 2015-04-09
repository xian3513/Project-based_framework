//
//  MemoModel.h
//  duobao
//
//  Created by kt on 15/3/19.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//


         /////////////////////////////////////
         //                                 //
         //             备忘录               //
         //                                 //
         /////////////////////////////////////

#import <Foundation/Foundation.h>

@interface MemoModel : NSObject<NSCoding,NSCopying>
@property (nonatomic,copy) NSString *name;
@property (nonatomic) NSInteger age;
@property (nonatomic,strong) NSArray *array;

+ (MemoModel *)share;
@end
