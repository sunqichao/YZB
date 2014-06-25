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
#import "StoreListView.h"



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

/**
 *  商户列表的视图
 */
@property (strong, nonatomic) StoreListView *storeListView;

@property (strong, nonatomic) NSMutableArray *storeListArray;

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
    
    self.storeListArray = [[NSMutableArray alloc] init];
    
    /**
     *  添加商户列表视图到本控制器
     */
    [self addStoreListView];
    
    /**
     *  添加隐藏商户消息列表的通知
     */
    [self addDisappearNotification];
    
    /**
     *  添加更新消息数量的labels
     */
    [self addUpdateStoreInformations];
    
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

#pragma mark - 根据设备id 请求服务端数据

- (void)getStoreDataWithID:(NSString *)idStr
{
    [StoreModel getStoreInformationWithId:idStr block:^(NSArray *data, NSError *error) {
        if (data) {
            [self.storeListArray addObjectsFromArray:[self filterStoreListData:data]];
            self.storeListView.storeListArray = _storeListArray;
        }
    }];
    
}

- (NSArray *)filterStoreListData:(NSArray *)arr
{
    if (self.storeListArray.count==0||self.storeListArray==nil) {
        return arr;
    }else
    {
        NSArray *originData = self.storeListArray;
        NSArray *targetData = arr;
        NSMutableArray *results = @[].mutableCopy;
        [targetData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            __block BOOL isSame = NO;
            StoreModel *target = (StoreModel *)obj;

            [originData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                StoreModel *origin = (StoreModel *)obj;
                if ([target.sid isEqualToString:origin.sid]) {
                    isSame = YES;
                    *stop = YES;
                }
            }];
            
            if (!isSame) {
                [results addObject:obj];

            }
        }];
        
        return results.copy;
    }
    
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
        angle += 10;
        [self startAnimation];
    }];
    
}

- (void)addStoreListView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.storeListView = [storyboard instantiateViewControllerWithIdentifier:@"StoreListView"];
    self.storeListView.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [self addChildViewController:self.storeListView];
    [self.view addSubview:self.storeListView.view];
}

#pragma mark - 出现和隐藏商户消息列表的动画

- (void)appearStoreList
{
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.storeListView.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);

    } completion:^(BOOL finished) {
        [self.storeListView didMoveToParentViewController:self];
        self.arrowButton.hidden = NO;

    }];

    
}

- (void)disappearStoreList
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.storeListView.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        
    } completion:^(BOOL finished) {
        [self.storeListView removeFromParentViewController];
        self.arrowButton.hidden = YES;
    }];
    
}

#pragma mark - 隐藏商户列表 通知

- (void)addDisappearNotification
{
    [[NSNotificationCenter defaultCenter] addObserverForName:@"disappearStoreList" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self disappearStoreList];
        
    }];

}

#pragma mark - 更新商家信息数量 通知

- (void)addUpdateStoreInformations
{
    [[NSNotificationCenter defaultCenter] addObserverForName:@"updateStoreInformations" object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        NSDictionary *numberDic = [note userInfo];
        
        NSString *number = [NSString stringWithFormat:@"%@",numberDic[@"number"]];
        if (![number isEqual:@"0"]) {
            NSMutableArray *majorId = [[YZBIbeaconManager shareBeaconManager] majorArray];
            if (majorId) {
                [majorId enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSNumber *number = obj;
                    [self getStoreDataWithID:[NSString stringWithFormat:@"%@",number]];
                    
                }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _bigNumber.text = number;
                _searchTitle.hidden = YES;
                _clickToSeeButton.hidden = NO;
                _numberOfMessage.hidden = NO;
            });
            
        }else
        {
            _bigNumber.text = @"0";
            self.storeListArray = @[].mutableCopy;
            self.storeListView.storeListArray = _storeListArray;
            self.numberOfMessage.hidden = YES;
            self.clickToSeeButton.hidden = YES;
            self.searchTitle.hidden = YES;
            self.arrowButton.hidden = YES;
            [self performSelector:@selector(changeDisconnect) withObject:nil afterDelay:0.5];

        }
        
        
    }];
    
}

/**
 *  改变beacon的检测状态，延迟设置为NO，表示为可链接蓝牙状态 
 */
- (void)changeDisconnect
{
    [[YZBIbeaconManager shareBeaconManager] setIsDisconnect:NO];

}

#pragma mark - 点击出现左边菜单的方法回调

- (IBAction)clickSideMenu:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(YZBMainViewDidTapMenuButton:)])
    {
        [self.delegate YZBMainViewDidTapMenuButton:self];
    }
    
}

#pragma mark - 点击消息列表

- (IBAction)clickInfoList:(id)sender
{
    [self appearStoreList];
    self.storeListView.storeListArray = _storeListArray;
    [self.storeListView.storeListTable reloadData];
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
