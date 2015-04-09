//
//  GlobalModel+write.h
//  duobao
//
//  Created by kt on 15/3/19.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "Global.h"

@interface Global (write)
- (void)globalOriginalData:(NSData *)data identifer:(NSString *)identifer;
- (BOOL)globalDataWithLotteryDate:(NSDictionary *)dictionary;
- (BOOL)globalDataWithMenuList:(NSDictionary *)dictionary;
@end
