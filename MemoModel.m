//
//  MemoModel.m
//  duobao
//
//  Created by kt on 15/3/19.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MemoModel.h"
#import "Global.h"
@implementation MemoModel

+ (MemoModel *)share {
    static dispatch_once_t predicate;
    static MemoModel *singleton;
    dispatch_once(&predicate, ^{
        singleton = [[MemoModel alloc] init];
    });
    return singleton;
}

- (id)init {
    if(self = [super init]) {
        Global *model = [Global share];
        [model addObserver:self forKeyPath:@"lotteryDateDataIsHave" options:
          NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)dealloc {
    Global *model = [Global share];
    [model removeObserver:self forKeyPath:@"lotteryDateDataIsHave" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"lotteryDateDataIsHave"]) {
        NSLog(@"%@",keyPath);
    }
}

#pragma mark-NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntForKey:@"age"];
        _array = [aDecoder decodeObjectForKey:@"array"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_array forKey:@"array"];
}

#pragma mark-NSCopying
-(id)copyWithZone:(NSZone *)zone{
    MemoModel *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.age = self.age;
    copy.array = [self.array copyWithZone:zone];
    return copy;
}

//保存路径
//-(NSString *) getFilePath{
//    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    return [[array objectAtIndex:0] stringByAppendingPathComponent:@"testData"];
//}


//获得数据
//if ([[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]]) {
//    NSLog(@"filePAth:%@",[self getFilePath]);
//    NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFilePath]];
//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    //解档出数据模型Student
//    MemoModel *mStudent = [unarchiver decodeObjectForKey:@"save"];
//    [unarchiver finishDecoding];//一定不要忘记finishDecoding，否则会报错
//    
//    //接档后就可以直接使用了（赋值到相应的组件属性上）
//    NSLog(@"%@,%ld,%@",mStudent.name,(long)mStudent.age,mStudent.array);
//}


//保存数据
//MemoModel *saveStudent = [[MemoModel alloc] init];
//saveStudent.name = @"zhangsan";
//saveStudent.age = 11;
//saveStudent.array = [[NSArray alloc]initWithObjects:@"a",@"b", nil];
//NSMutableData *data = [[NSMutableData alloc] init];
//NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//[archiver encodeObject:saveStudent forKey:@"save"];
//[archiver finishEncoding];
//[data writeToFile:[self getFilePath] atomically:YES];


@end
