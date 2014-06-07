//
//  YZBMainViewController.m
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "YZBMainViewController.h"
#import "YZBIbeaconManager.h"
#import "StoreModel.h"

@interface YZBMainViewController ()

/**
 *  loading旋转的那个圈
 */
@property (weak, nonatomic) IBOutlet UIImageView *loadingImg;

/**
 *  正在搜索的label
 */
@property (weak, nonatomic) IBOutlet UILabel *searchTitle;

/**
 *  点击直接查看的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *clickToSeeButton;

/**
 *  “条新信息”的label
 */
@property (weak, nonatomic) IBOutlet UILabel *numberOfMessage;

/**
 *  显示数字的label
 */
@property (weak, nonatomic) IBOutlet UILabel *bigNumber;

/**
 *  向下的那个箭头button
 */
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;



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


#pragma mark - ios lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  测试接口的方法
     */
    [self testApi];
    
    /**
     *  设置beacon的一些参数
     */
    [self setUpBeacon];
    
    /**
     *  loading的动画，一期先不做
     */
//    [self startAnimation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     *  初始化应该显示和隐藏的控件
     */
    self.numberOfMessage.hidden = YES;
    self.clickToSeeButton.hidden = YES;
    self.searchTitle.hidden = NO;
    self.arrowButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testApi
{
    [StoreModel getStoreInformationWithId:@"123" block:^(NSArray *data, NSError *error) {
        
    }];
    
}

#pragma mark - 设置扫描的状态和信息，并启动扫描

- (void)setUpBeacon
{
    [[YZBIbeaconManager shareBeaconManager] startMonitoringForBeacons];
    [[YZBIbeaconManager shareBeaconManager] startRangingForBeacons];
    
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

#pragma mark - 点击设置

- (IBAction)settting:(id)sender {
    
    
}

#pragma mark - 点击向下的箭头按钮来显示和隐藏消息列表

- (IBAction)appearArrow:(id)sender {
    
    
    
}












@end
