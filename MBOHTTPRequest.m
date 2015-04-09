//
//  MBOHTTPRequestTest.m
//  duobao
//
//  Created by kt on 15/3/27.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOHTTPRequest.h"

@implementation MBOHTTPRequest

+ (MBOHTTPRequest *)share {
    static dispatch_once_t predicate;
    static MBOHTTPRequest *singleton;
    dispatch_once(&predicate, ^{
    singleton = [[MBOHTTPRequest alloc] init];
    
    });
    return singleton;
}

- (id)init {
    if(self = [super init]) {
       
    }
    return self;
}

//重写了父类该方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    MBOURLConnection *conn = (MBOURLConnection *)connection;
    NSLog(@"httpFinishLoading: identifer:%@ - statusCode:%ld ",conn.MBOHTTPConnectionIdentifer,conn.MBOStatusCode);
    switch (conn.MBOStatusCode) {
        case 200:{
            [self MBOHTTPSuccess:conn];
            break;
        }
        case 304:{
            break;
        }
        case 400:{
            [self MBOSyntaxError:conn];
            break;
        }
        case 401:{
            break;
        }
        
    }
}

- (void)MBOHTTPSuccess:(MBOURLConnection *)connection {
// NSLog(@"%@ - %@",connection.MBOHTTPConnectionIdentifer,[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding]);
    if(self.httpSuccess) {
       self.httpSuccess(receiveData,connection.MBOHTTPConnectionIdentifer);
    }
    [URLConnectionsDictionary removeObjectForKey:connection.MBOHTTPConnectionIdentifer];
    URLConnections = URLConnectionsDictionary.allValues;
    [responsesDictionary removeObjectForKey:connection.MBOHTTPConnectionIdentifer];
    responses = responsesDictionary.allValues;

}

- (void)MBOSyntaxError:(MBOURLConnection *)connection {
    NSString *message = [MBOBaseModel parseSyntaxError:receiveData identifer:connection.MBOHTTPConnectionIdentifer];
    NSLog(@"message:%@",message);
    [ShowAlertView showToastViewWithText:message];
    if(self.httpSyntaxError) {
    self.httpSyntaxError(receiveData,connection.MBOHTTPConnectionIdentifer);
    }
}




@end
