//
//  RWTSidebarViewController.m
//  Sidebar
//
//  Created by Main Account on 5/1/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTSidebarViewController.h"

@interface RWTSidebarViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, assign) NSInteger gap;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (assign) BOOL firstTime;

@end

@implementation RWTSidebarViewController

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController mainViewController:(UIViewController *)mainViewController gap:(NSInteger)gap {

  self = [super init];
  if (self) {
  
    _leftViewController = leftViewController;
    _mainViewController = mainViewController;
    _gap = gap;
    _firstTime = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setupScrollView];
    [self setupViewControllers];
    
  }
  return self;

}

- (void)setupScrollView {

  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
  [self.view addSubview:self.scrollView];
  
  NSDictionary *viewsDictionary = @{@"scrollView": self.scrollView};
  
  NSString *format = @"|[scrollView]|";
  NSArray *horzConstraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
  [self.view addConstraints:horzConstraints];
  
  NSArray *vertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:viewsDictionary];
  [self.view addConstraints:vertConstraints];

}

- (void)addViewController:(UIViewController *)viewController {
  viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addSubview:viewController.view];
  [self addChildViewController:viewController];
  [viewController didMoveToParentViewController:self];
}

- (void)setupViewControllers {

  [self addViewController:self.leftViewController];
  [self addViewController:self.mainViewController];
  
  NSDictionary *viewsDictionary = @{@"leftView": self.leftViewController.view, @"mainView": self.mainViewController.view, @"outerView": self.view};
  
  NSArray *horzConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[leftView][mainView(==outerView)]|" options:0 metrics:nil views:viewsDictionary];
  [self.view addConstraints:horzConstraints];
  
  NSLayoutConstraint *leftViewWidth = [NSLayoutConstraint constraintWithItem:self.leftViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-self.gap];
  [self.view addConstraint:leftViewWidth];

  NSArray *leftViewVertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftView(==outerView)]|" options:0 metrics:nil views:viewsDictionary];
  [self.view addConstraints:leftViewVertConstraints];
  
  NSArray *mainViewVertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainView(==outerView)]|" options:0 metrics:nil views:viewsDictionary];
  [self.view addConstraints:mainViewVertConstraints];

}

- (BOOL)isOpen {
  CGPoint contentOffset = self.scrollView.contentOffset;
  return contentOffset.x == 0;
}

- (void)closeMenuAnimated:(BOOL)animated {
  CGPoint contentOffset = self.scrollView.contentOffset;
  contentOffset.x = CGRectGetWidth(self.view.bounds) - self.gap;
  [self.scrollView setContentOffset:contentOffset animated:animated];
}

- (void)openMenuAnimated:(BOOL)animated {
  [self.scrollView setContentOffset:CGPointZero animated:animated];
}

- (void)toggleMenu {
  if ([self isOpen]) {
    [self closeMenuAnimated:YES];
  } else {
    [self openMenuAnimated:YES];
  }
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  if (self.firstTime) {
    self.firstTime = NO;
    [self closeMenuAnimated:NO];
  }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    
    /**
     *  超出范围外的拖动，都设置为 NO
     */
    if (x>270) {
        scrollView.scrollEnabled = NO;
    }else if (x<0)
    {
        scrollView.scrollEnabled = NO;
    }
    else
    {
        scrollView.scrollEnabled = YES;
    }
    
}


@end
