//
//  GlobalModel+write.m
//  duobao
//
//  Created by kt on 15/3/19.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "Global+write.h"

@implementation Global (write)

- (void)globalOriginalData:(NSData *)data identifer:(NSString *)identifer {
    if(!originalDictionary) {
        originalDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    [originalDictionary setObject:data forKey:identifer];
//    NSLog(@"originalDictionary:%@",originalDictionary);
}
- (BOOL)globalDataWithLotteryDate:(NSDictionary *)dictionary {
    lotteryDateData = dictionary;
    self.lotteryDateDataIsHave = YES;
    return self.lotteryDateDataIsHave;
}

- (BOOL)globalDataWithMenuList:(NSDictionary *)dictionary {
    menuListDictionary = dictionary;
    self.menuListDictionaryIsHave = YES;
    return self.menuListDictionaryIsHave;
    
}


@end
