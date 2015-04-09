//
//  MBOHTTPRequestTest.h
//  duobao
//
//  Created by kt on 15/3/27.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "HTTPRequest.h"
@interface MBOHTTPRequest : HTTPRequest
@property (nonatomic,copy)MBOHTTPRequestFinishDataBlock httpSyntaxError;

+ (MBOHTTPRequest *)share;
@end
