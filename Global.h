//
//  GlobeModel.h
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBOHeaderfile.h"
@interface Global : NSObject  {
    @private
     NSDictionary *lotteryDateData;
    NSDictionary *menuListDictionary;
    NSMutableDictionary *originalDictionary;
}
@property (nonatomic,assign) BOOL lotteryDateDataIsHave;
@property (nonatomic,assign) BOOL menuListDictionaryIsHave;
+ (Global *)share;
- (NSData *)getOriginalDataWithIdentifer:(NSString *)identifer;
- (NSDictionary *)getLotteryDateData;
- (NSString *)getMenuTitleWithLotteryId:(NSString *)lotteryId;


#warning 在view层实现 是不是更合理一点
- (UIImage *)lotteryIconWithLotteryId:(NSUInteger)lotteryId;
@end

@interface Global () {
   
}
@end
