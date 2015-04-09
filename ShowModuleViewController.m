//
//  BaseMenuViewController.m
//  duobao
//
//  Created by kt on 15/3/18.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "ShowModuleViewController.h"
#import "UIImageView+WebCache.h"
@interface ShowModuleViewController ()

@end

@implementation ShowModuleViewController {
 UIImageView *welcomeImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
