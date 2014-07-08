//
//  NewMainViewController.m
//  IBeacon
//
//  Created by MacBook on 14-7-7.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "NewMainViewController.h"
#import "YZBIbeaconManager.h"
#import "StoreModel.h"
#import "MessageView.h"
@interface NewMainViewController ()


@property (strong, nonatomic) MessageView *mainView;
@property (strong, nonatomic) NSMutableArray *storeListArray;


@end

@implementation NewMainViewController

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

    self.storeListArray = [[NSMutableArray alloc] init];

    self.mainView = [[MessageView alloc] initWithNibName:@"MessageView" bundle:nil];
    [self.view addSubview:self.mainView.view];
    /**
     *  设置beacon的一些参数
     */
    [self setUpBeacon];
    
    /**
     *  添加更新消息数量的通知
     */
    [self addUpdateStoreInformations];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 设置扫描的状态和信息，并启动扫描

- (void)setUpBeacon
{
    [[YZBIbeaconManager shareBeaconManager] startMonitoringForBeacons];
    [[YZBIbeaconManager shareBeaconManager] startRangingForBeacons];
    
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
                    NSNumber *numberID = obj;
                    [self getStoreDataWithID:[NSString stringWithFormat:@"%@",numberID]];
                    
                }];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            
        }else
        {
            
        }
        
    }];
    
}

#pragma mark - 根据设备id 请求服务端数据

- (void)getStoreDataWithID:(NSString *)idStr
{
    [StoreModel getStoreInformationWithId:idStr block:^(NSArray *data, NSError *error) {
        if (data) {
            [self.storeListArray addObjectsFromArray:[self filterStoreListData:data]];

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

#pragma mark - 点击出现左边菜单的方法回调

- (IBAction)clickSideMenu:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(YZBMainViewDidTapMenuButton:)])
    {
        [self.delegate NewMainViewDidTapMenuButton:self];
    }
    
}

@end
