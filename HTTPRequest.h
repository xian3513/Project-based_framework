//
//  MBOHTTPRequest.h
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////


//                      该类实现了 http get和post基本请求

//             如果想要实现 状态码 等其他功能可以继承该类 重写相关方法即可

//*****     NSOperation是个抽象类，使用它必须用它的子类，
//*****    可以实现它或者使用它定义好的两个子类：NSInvocationOperation 和 NSBlockOperation。
////////////////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>
#import "MBOURLConnection.h"
#import "MBOBaseModel.h"
#import "ShowAlertView.h"

typedef void (^MBOHTTPRequestFinishDataBlock)(NSData *data, NSString *identifer);
typedef void (^MBOHTTPRequestFailBlock)(NSInteger statusCode, NSString *identifer);

@interface HTTPRequest : NSObject {
    NSArray *responses;
    NSArray *URLConnections;
    NSMutableData *receiveData;
    NSMutableURLRequest *currentResponse;
    MBOURLConnection *currentURLConnection;
    NSMutableDictionary *URLConnectionsDictionary;
    NSMutableDictionary *responsesDictionary;
}
@property (nonatomic,copy)MBOHTTPRequestFinishDataBlock httpSuccess;
@property (nonatomic,copy)MBOHTTPRequestFailBlock httpFail;
@property (nonatomic,assign,readonly) CGFloat loadProgressing;
//@property (nonatomic,readonly) NSArray *URLConnections;//保存了所有http请求中的connection，还需要进一步测试
//@property (nonatomic,readonly) NSArray *responses;//保存了所有http请求中的connection，还需要进一步测试

/*
 *  异步请求
 */
- (void)HTTPGetWithModel:(MBOBaseModel *)model Identifer:(NSString *)identifer;
- (void)HTTPPostWithModel:(MBOBaseModel *)model Identifer:(NSString *)identifer;

/*
 *  同步请求
 */
- (void)HTTPSyncGetWithURL:(NSString *)urlStr identifer:(NSString *)identifer seccess:(void(^)(NSData *data))seccess fail:(void(^)(NSError *error))fail;


/*
 *  网络请求过程中,随时中断请求
 */
- (void)cancelHTTPConnectioning:(NSString *)identifer;
@end
@interface HTTPRequest(MBOHTTPRequestConnection)

@end