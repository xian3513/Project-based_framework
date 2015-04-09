//
//  PaomaView.m
//  duobao
//
//  Created by kt on 15/3/21.
//  Copyright (c) 2015年 Duobao. All rights reserved.
//

#import "PaomaView.h"
@implementation PaomaView {
    CGFloat ratio;
    CGFloat textWidth;
    UILabel *labelShow;
}
@synthesize ratio;

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        labelShow = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:labelShow];
        _direction = moveToleft;
    }
    return self;
}

- (void)showInView:(UIView *)view {//注意先后顺序
    //width:5272  ratio:27.657143  width/ratio:190.619834

    labelShow.text = (self.showText!=nil?self.showText:@"据洪磊介绍，亚美尼亚总统萨尔基相、奥地利总统菲舍尔、印尼总统佐科、尼泊尔总统亚达夫、斯里兰卡总统西里塞纳、乌干达总统穆塞韦尼、赞比亚总统伦古、澳大利亚总督科斯格罗夫、哈萨克斯坦总理马西莫夫、马来西亚总理纳吉布、荷兰首相吕特、卡塔尔首相阿卜杜拉、瑞典首相勒文、俄罗斯第一副总理舒瓦洛夫、泰国副总理兼外长塔纳萨等外国领导人将应邀来华出席年会。博鳌亚洲论坛秘书长周文重17日也向媒体透露，出席本届年会的其他国家领导人规模将超过历届年会。这充分显示了各国领导人对此次论坛的重视程度。那么今年习近平发表主旨演讲将涉及哪些内容，这次博鳌论坛将有哪些看点？将会给亚洲乃至世界经济发展带来哪些新的契机？为此，人民网记者今日采访了相关专家。");
    ratio = (ratio==0.0f?27.657143:ratio);
    labelShow.textColor = (_textColor==nil?[UIColor colorWithRed:0.7 green:0.5 blue:0.5 alpha:1]:_textColor);
    [labelShow sizeToFit];
    NSInteger width = labelShow.frame.size.width;
    textWidth = width;
    CGRect frame = labelShow.frame;
    frame.origin.x = (_direction == moveToleft?screenWidth:-width);
    labelShow.frame = frame;
    [view addSubview:self];
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:width/ratio];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    frame = labelShow.frame;
    frame.origin.x = _direction == moveToleft?-width:width;
    labelShow.frame = frame;
    [UIView commitAnimations];
    
}

- (void)stopShow {
    self.hidden = YES;
    NSInteger width = labelShow.frame.size.width;
    textWidth = width;
    CGRect frame = labelShow.frame;
    frame.origin.x = (_direction == moveToleft?screenWidth:-width);
    labelShow.frame = frame;
    self.hidden = NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
