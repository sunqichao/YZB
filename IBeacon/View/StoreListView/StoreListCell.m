//
//  StoreListCell.m
//  IBeacon
//
//  Created by MacBook on 14-6-9.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "StoreListCell.h"
#import "StoreModel.h"

@interface StoreListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;


@end

@implementation StoreListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataSource:(id)data
{
    if (data) {
        StoreModel *model = (StoreModel *)data;
        [_coverImage setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:nil];
        _titleLabel.text = model.title;
        _subtitleLabel.text = model.subtitle;
    }
    
}





+ (StoreListCell *)getSotreListCell
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StoreListCell" owner:self options:nil];
    StoreListCell *cell = nib[0];
    return cell;
}



@end
