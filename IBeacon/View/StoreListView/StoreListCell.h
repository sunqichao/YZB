//
//  StoreListCell.h
//  IBeacon
//
//  Created by MacBook on 14-6-9.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreListCell : UITableViewCell

- (void)setDataSource:(id)data;

+ (StoreListCell *)getSotreListCell;

@end
