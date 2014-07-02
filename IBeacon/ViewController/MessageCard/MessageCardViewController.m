//
//  MessageCardViewController.m
//  IBeacon
//
//  Created by MacBook on 14-6-19.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "MessageCardViewController.h"
#import "MessageCardBottomView.h"
#import "MessageCardmidleView.h"
#import "MessageCardDetailView.h"
#import "MessageCardPayView.h"

@interface MessageCardViewController ()

/**
 *  底部view，上面有点赞，收藏，分享，评论
 */
@property (strong, nonatomic) MessageCardBottomView *bottomView;

/**
 *  显示标题得view （ 当点击这个view或者向上划的手势得时候，出现详情view，而这个view就隐藏 ）
 */
@property (strong, nonatomic) MessageCardmidleView *midView;

/**
 *  详情view
 */
@property (strong, nonatomic) MessageCardDetailView *detailView;


@property (strong, nonatomic) MessageCardPayView *payView;

@end

@implementation MessageCardViewController

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
    
    /**
     *  底部 功能 赞，分享等功能
     */
    self.bottomView = [MessageCardBottomView getMessageCardBottomView];
    self.bottomView.dataModel = self.dataModel;
    
    self.bottomView.frame = CGRectMake(0, kScreenHeight-self.bottomView.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
    [self.view addSubview:self.bottomView];
    
    if (self.cardType==MessageCardTypeProduct)
    {
        [self setUpProductView];
        
    }else if(self.cardType==MessageCardTypeBusness)
    {
        [self setUpBusnessView];
        
    }else if(self.cardType==MessageCardTypePay)
    {
        [self setUpPayView];
        
    }else if(self.cardType==MessageCardTypeOutsideURL)
    {
        [self setUpOutSideURL];
    }
        
    [self.view bringSubviewToFront:self.bottomView];

    [self addAlertViewNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.bottomView setUpNumber];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - 初始化产品消息卡

- (void)setUpProductView
{
    self.midView = [MessageCardmidleView getMessageCardmidleView];
    self.midView.frame = CGRectMake(0, kScreenHeight-self.bottomView.frame.size.height-self.midView.frame.size.height-2, self.midView.frame.size.width, self.midView.frame.size.height);
    [self.midView.midButton addTarget:self action:@selector(appearDetailView:) forControlEvents:UIControlEventTouchUpInside];
    [self.midView setData:self.dataModel];
    [self.view addSubview:self.midView];
    
    self.detailView = [MessageCardDetailView getMessageCardDetailView];
    self.detailView.frame = CGRectMake(0, self.midView.frame.origin.y, self.detailView.frame.size.width, self.detailView.frame.size.height);
    self.detailView.hidden = YES;
    [self.detailView.dismissButton addTarget:self action:@selector(swipeDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView setData:self.dataModel];
    [self.view addSubview:self.detailView];
    
    self.alertView = [AlertView getAlertView];
    self.alertView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    self.alertView.hidden = YES;
    [self.view addSubview:self.alertView];
    
    UISwipeGestureRecognizer *gestureUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(appearDetailView:)];
    [gestureUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:gestureUp];
    
    UISwipeGestureRecognizer *gestureDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    [gestureDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:gestureDown];
    
    [self.view addSubview:self.closeImageView];
    [self.view addSubview:self.closeButton];
    self.closeImageView.frame = CGRectMake(self.closeImageView.frame.origin.x,40, self.closeImageView.frame.size.width, self.closeImageView.frame.size.height);
    [self.view bringSubviewToFront:self.closeImageView];
    [self.view bringSubviewToFront:self.closeButton];
}

- (void)appearDetailView:(id)sender
{
    self.midView.hidden = YES;
    self.detailView.hidden = NO;

    [UIView animateWithDuration:0.5 animations:^{
        self.detailView.frame = CGRectMake(0, 20, self.detailView.frame.size.width, self.detailView.frame.size.height);
    } completion:^(BOOL finished) {

        
        
    }];
    
}

- (void)swipeDown:(id)downGesture
{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.detailView.frame = CGRectMake(0, self.midView.frame.origin.y, self.detailView.frame.size.width, self.detailView.frame.size.height);
    } completion:^(BOOL finished) {
        self.midView.hidden = NO;
        self.detailView.hidden = YES;
        self.detailView.frame = CGRectMake(0, self.midView.frame.origin.y, self.detailView.frame.size.width, self.detailView.frame.size.height);

    }];
    
}

- (void)addAlertViewNotification
{
    [[NSNotificationCenter defaultCenter] addObserverForName:@"appearAlertView" object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSDictionary *dic = [note userInfo];
        if (![dic[@"title"] isEqualToString:@""]) {
            self.alertView.title.hidden = NO;
            self.alertView.title.text = dic[@"title"];

        }
        self.alertView.backImage.image = [UIImage imageNamed:dic[@"backImage"]];
        self.alertView.hidden = NO;
        [self.view bringSubviewToFront:self.alertView];
        [self performSelector:@selector(hideAlertView) withObject:nil afterDelay:1.5f];
    }];
    
}

- (void)hideAlertView
{
    self.alertView.hidden = YES;
    self.alertView.title.hidden = YES;
}

#pragma mark - 初始化商家消息卡

- (void)setUpBusnessView
{
    
    
}

#pragma mark - 初始化支付消息卡

- (void)setUpPayView
{
    self.payView = [MessageCardPayView getMessageCardPayView];
    [self.payView.backButton addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    [self.payView.submitButton addTarget:self action:@selector(submitPay:) forControlEvents:UIControlEventTouchUpInside];
    self.payView.numberTextfield.delegate = self.payView;
    self.payView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    self.payView.titleLabel.text = self.title;
    self.payView.shouKuanFang.text = self.shouKuanFang;
    self.payView.numberTextfield.text = self.price;
    [self.view addSubview:self.payView];
}

- (void)submitPay:(id)sender
{
    if (self.payView.isZhiFuBao) {
        NSLog(@"zhi fu bao");
    }else
    {
        NSLog(@"wei xin");
    }
    

}


#pragma mark - 初始化外部URL页面

- (void)setUpOutSideURL
{
    self.webView = [MessageWebView getMessageWebView];
    [self.view addSubview:self.webView];
    
    
}






@end
