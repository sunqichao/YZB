//
//  YZBMainViewController.m
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "YZBMainViewController.h"
#import "YZBIbeaconManager.h"
@interface YZBMainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *loadingImg;

@property (weak, nonatomic) IBOutlet UILabel *searchTitle;

@end

@implementation YZBMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self startAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置扫描的状态和信息，并启动扫描

- (void)setUpBeacon
{
    [[YZBIbeaconManager shareBeaconManager] searchBeaconSuccess:^(NSArray *arr) {
        _searchTitle.text = [NSString stringWithFormat:@"%d",arr.count];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


#pragma mark - 无限旋转的动画

double angle = 0.0;
- (void)startAnimation
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _loadingImg.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 10; [self startAnimation];
    }];
    
}


#pragma mark - 点击出现左边菜单的方法回调

- (IBAction)clickSideMenu:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(YZBMainViewDidTapMenuButton:)]) {
        [self.delegate YZBMainViewDidTapMenuButton:self];
    }
    
}


#pragma mark - 点击消息列表

- (IBAction)clickInfoList:(id)sender {


}

#pragma mark - 点击收藏夹

- (IBAction)clickFavorite:(id)sender {
    
    
}


@end
