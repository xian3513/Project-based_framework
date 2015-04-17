//
//  MBOBaseModel.m
//  duobao
//
//  Created by kt on 15/3/13.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MBOBaseModel.h"

@implementation MBOBaseModel {
   NSMutableData *receiveData;
}

- (id)init {
    if(self = [super init]) {
        self.hidesShowViewWhenHTTP = NO;
    }
    return self;
}

- (NSString *)HTTPTheWay {
    return [self validateWay:_HTTPTheWay];
}

- (NSData *)HTTPTestData {
    NSLog(@"/*********   这是测试数据   **********/");
    return nil;
}
#pragma mark--数据解析

+ (id)parseJSON:(NSData *)data identifer:(NSString *)identifier{
    if(!data) {
        return nil;
    }
    NSError * error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if([json isKindOfClass:[NSDictionary class]]) {
#warning 需要进一步处理
//        NSDictionary *dict = (NSDictionary *)json;
//        if([dict.allKeys containsObject:@"servertime"]) {
//            NSLog(@"json = dictionary.key = servertime.   identifer:%@",identifier);
//            return nil;
//        }
    }
    return json;
}

+ (NSString *)parseSyntaxError:(NSData *)data identifer:(NSString *)identifier {
    return [self parsePrompt:data identifer:identifier];
}

+ (NSString *)parsePrompt:(NSData *)data identifer:(NSString *)identifier {
    if(!data) {
        return nil;
    }
    NSError * error = nil;
    NSString *content = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if([json isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)json;
        if([dict.allKeys containsObject:@"message"]) {
            content = [dict objectForKey:@"message"];
        }
    }
    return content;
}

- (void)backgroundDataProcessingWithIdentifer:(char *)identifer process:(void (^)())process finish:(void (^)(NSString *))finish {
        dispatch_queue_t network_queue;
        network_queue = dispatch_queue_create(identifer, nil);
        dispatch_async(network_queue, ^{
            process();
            dispatch_async(dispatch_get_main_queue(), ^{
                finish([[NSString alloc] initWithCString:identifer encoding:NSUTF8StringEncoding]);
            });
        });
}

+ (NSArray *)filterPropertys
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    for (i = 0; i<outCount; i++)
    {
        
        const char* char_f =property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}

- (NSString *)validateWay:(NSString *)way {
    NSString* number=@"^[postPOST]{4}+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return ([numberPre evaluateWithObject:way]?@"post":@"get");
}
//+ (BOOL)resolveInstanceMethod:(SEL)aSEL
//{
//     NSLog(@"please finish the method: [%@]",NSStringFromSelector(aSEL));
//    class_addMethod([self class], aSEL, (IMP)fooMethod, "v@:");
//    return YES;
//}
//void fooMethod(id obj, SEL _cmd)
//{
//    
//}
@end
