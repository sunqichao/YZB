//
//  MessageView.m
//  IBeacon
//
//  Created by MacBook on 14-7-7.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "MessageView.h"
#import "iCarousel.h"
#import "CardView.h"

#define NUMBER_OF_ITEMS (IS_IPAD? 19: 12)
#define NUMBER_OF_VISIBLE_ITEMS 25
#define ITEM_SPACING 150.0f
#define INCLUDE_PLACEHOLDERS YES

@interface MessageView ()

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) NSMutableArray *items;

@end

@implementation MessageView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.carousel.decelerationRate = 0.5;
    self.carousel.type = iCarouselTypeTimeMachine;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUp
{
	//set up data

	self.items = [NSMutableArray array];
	for (int i = 0; i < 12; i++)
	{
		[_items addObject:[NSNumber numberWithInt:i]];
	}
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_items count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    //this also affects the appearance of circular-type carousels
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 90.0;
}
- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
	//set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UILabel *label = nil;
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
        view = [CardView getCardView];

//		view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardBackground.png"]];
//        view.frame = CGRectMake(10, 20, kScreenWidth-20, kScreenHeight-40);
		label = [[UILabel alloc] initWithFrame:view.bounds];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		label.font = [label.font fontWithSize:50];
		[view addSubview:label];
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
	label.text = [[_items objectAtIndex:index] stringValue];
	
	return view;
}


@end
