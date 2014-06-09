//
//  StoreListView.m
//  IBeacon
//
//  Created by MacBook on 14-6-9.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "StoreListView.h"
#import "StoreListCell.h"
@interface StoreListView ()




@end

@implementation StoreListView

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (IBAction)choseNewInformation:(id)sender {
    
    
    
}

- (IBAction)choseHistory:(id)sender {
    
    
}


#pragma mark - 隐藏 商户列表

- (IBAction)tapTheView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disappearStoreList" object:nil];
    
}



#pragma mark - UITableview datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _storeListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"StoreListCell";
    StoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [StoreListCell getSotreListCell];
    }
    [cell setDataSource:_storeListArray[indexPath.row]];
    return cell;
}





@end
