//
//  GlobeModel.m
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "Global.h"
@implementation Global

#warning 需要补全单例 其他方法,目前已经确保了大部分操作的唯一对象
+ (Global *)share {
    static dispatch_once_t predicate;
    static Global *singleton;
    dispatch_once(&predicate, ^{
        singleton = [[Global alloc] init];
    });
    return singleton;
}

- (NSData *)getOriginalDataWithIdentifer:(NSString *)identifer {
    NSData *data = nil;
    if(originalDictionary) {
        data = [originalDictionary objectForKey:identifer];
    }
    return data;
}

- (NSDictionary *)getLotteryDateData {
    return lotteryDateData;
}

- (NSString *)getMenuTitleWithLotteryId:(NSString *)lotteryId {
    return [menuListDictionary objectForKey:lotteryId];
}

- (UIImage *)lotteryIconWithLotteryId:(NSUInteger)lotteryId {
    NSString * fileName = nil;
    switch (lotteryId) {
        case 1:
            fileName = @"ssc_cq";
            break;
        case 13:
            fileName = @"ssc_tj";
            break;
        case 6:
            fileName = @"ssc_xj";
            break;
        case 4:
            fileName = @"ssl";
            break;
        case 3:
            fileName = @"ssc_jx";
            break;
        case 5:
            fileName = @"115_sd";
            break;
        case 7:
            fileName = @"115_jx";
            break;
        case 10:
            fileName = @"115_cq";
            break;
        case 8:
            fileName = @"115_gd";
            break;
        case 9:
            fileName = @"kl8";
            break;
        case 11:
            fileName = @"3d";
            break;
        case 12:
            fileName = @"p3";
            break;
        case 16:
            fileName = @"ssc_db_1";
            break;
        case 14:
            fileName = @"ssc_db_2";
            break;
        case 15:
            fileName = @"115_db";
            break;
        case 17: fileName = @"lottery17";
            break;
        case 18: fileName = @"lottery18";
            break;
    }
    return [UIImage imageNamed:fileName];
}
@end
