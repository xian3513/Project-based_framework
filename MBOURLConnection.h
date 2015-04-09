//
//  MBOURLConnection.h
//  duobao
//
//  Created by kt on 15/3/13.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBOURLConnection : NSURLConnection
@property (nonatomic,assign) NSInteger MBOCurrentConnectionCount;
@property (nonatomic,copy) NSString *MBOHTTPConnectionIdentifer;
@property (nonatomic,assign) NSInteger MBOStatusCode;
@end
