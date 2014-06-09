//
//  StoreListView.h
//  IBeacon
//
//  Created by MacBook on 14-6-9.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreListView : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *storeListTable;

@property (weak, nonatomic) NSArray *storeListArray;

@end
