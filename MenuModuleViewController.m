//
//  BaseMenuViewController.m
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "MenuModuleViewController.h"
#import "UIImageView+WebCache.h"
@interface MenuModuleViewController ()

@end

@implementation MenuModuleViewController {
    UIImageView *welcomeImageView;
    Reachability *XISReachability;
    XISBaseView *base;
}

- (id)init {
    if(self = [super init]) {
        //reachability
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        if(!XISReachability) {
            XISReachability = [Reachability reachabilityWithHostName:@"www.google.com"];
        }
        [XISReachability startNotifier];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - 欢迎页
- (void)startWolcomePage:(void (^)(UIImageView *))completiocn {
    //欢迎页
        HTTPRequest *request = [[HTTPRequest alloc]init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        welcomeImageView = [[UIImageView alloc]initWithFrame:window.bounds];
        welcomeImageView.backgroundColor = [UIColor whiteColor];
        welcomeImageView.userInteractionEnabled = YES;
        [window addSubview:welcomeImageView];
    [request HTTPSyncGetWithURL:@"controller=uiinfo&action=welcomeurl" identifer:@"welcomePageidentifer" seccess:^(NSData *data){
        NSString *key = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if(imageData) {
            welcomeImageView.image = [UIImage imageWithData:imageData];
        } else {
            [welcomeImageView mbo_setImageWithURL:[NSURL URLWithString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"pic.png"]];
        }
    } fail:^(NSError *eror){
    
    }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(welcomeImageViewPress:)];
        tap.numberOfTapsRequired = 1;
        [welcomeImageView addGestureRecognizer:tap];
       completiocn(welcomeImageView);
}

- (void)welcomeImageViewPress:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:1.0 animations:^{
        CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
        welcomeImageView.layer.transform = transform;
        welcomeImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
    }];
}

#pragma -  网络监测
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    if(reachability == XISReachability) {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus) {
            case NotReachable: {
                [self XISViewControllerNotReachable];
                break;
            }
            case ReachableViaWiFi: {
                [self XISViewControllerReachableViaWiFi];
                break;
            }
            case ReachableViaWWAN: {
                [self XISViewControllerReachableViaWWAN];
                break;
            }
        }
    }
}

- (void)XISViewControllerNotReachable {
    NSLog(@"网络连接中断,请检查网络");
}

- (void)XISViewControllerReachableViaWiFi {
    NSLog(@"当前网络状态为:WIFI");
}

- (void)XISViewControllerReachableViaWWAN {
    NSLog(@"当前网络状态为:蜂窝数据");
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
