//
//  YZBMenuViewController.m
//  IBeacon
//
//  Created by MacBook on 14-6-4.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "YZBMenuViewController.h"

@interface YZBMenuViewController ()

@end

@implementation YZBMenuViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 是否接受推送

- (IBAction)isPushNotification:(id)sender {
    UISwitch *sw = (UISwitch *)sender;
    if (sw.on) {
        /**
         *  接受推送
         */
        NSLog(@"1");
        
    }else
    {
        /**
         *  不接受推送
         */

        NSLog(@"0");
    }
    
}

#pragma mark - 意见反馈

- (IBAction)gotoFeedBack:(id)sender {
    
    
}

#pragma mark - 更新版本

- (IBAction)updateVersion:(id)sender {
    
    
}

#pragma mark - 关于

- (IBAction)about:(id)sender {
    
    
}

#pragma mark - 推出登录

- (IBAction)logout:(id)sender {
    
    
}






@end
