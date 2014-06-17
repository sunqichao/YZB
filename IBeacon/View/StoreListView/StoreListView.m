//
//  StoreListView.m
//  IBeacon
//
//  Created by MacBook on 14-6-9.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "StoreListView.h"
#import "StoreListCell.h"
#import "StoreModel.h"

@interface StoreListView ()

@property (strong, nonatomic) UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIImageView *toolBar;

@property (weak, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIImageView *arrowDown;


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
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    self.webView = webView;
    self.closeButton.hidden = YES;
    self.historyArray = @[].mutableCopy;
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

- (void)setStoreListArray:(NSArray *)storeListArray
{
    if (storeListArray) {
        _storeListArray = storeListArray;
        self.dataSource = storeListArray;
    }else
    {
        
        self.dataSource = nil;
    }
}

- (void)setDataSource:(NSArray *)dataSource
{
    if (dataSource) {
        _dataSource = dataSource;
        [self.storeListTable reloadData];
    }else
    {
        [self.storeListTable reloadData];
    }
}

- (IBAction)choseNewInformation:(id)sender {
    self.toolBar.image = [UIImage imageNamed:@"msglist_tab1.png"];
    self.dataSource = self.storeListArray;
    [UIView animateWithDuration:0.5 animations:^{
        self.arrowDown.frame = CGRectMake(50, 246, 22, 12);
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)choseHistory:(id)sender {
    self.toolBar.image = [UIImage imageNamed:@"msglist_tab2.png"];
    self.dataSource = self.historyArray;
    [UIView animateWithDuration:0.5 animations:^{
        self.arrowDown.frame = CGRectMake(260, 246, 22, 12);
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)closeWebView:(id)sender {
    self.closeButton.hidden = YES;
    [self.webView removeFromSuperview];
}

#pragma mark - 隐藏 商户列表

- (IBAction)tapTheView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disappearStoreList" object:nil];
    
}

#pragma mark - UITableview datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"StoreListCell";
    StoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [StoreListCell getSotreListCell];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setDataSource:_dataSource[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view addSubview:self.webView];
    self.closeButton.hidden = NO;
    [self.view bringSubviewToFront:self.webView];
    [self.view bringSubviewToFront:self.closeButton];
    
    StoreModel *model = _dataSource[indexPath.row];
    NSURL* url = [NSURL URLWithString:model.contentURL];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载

    if (![StoreModel isSameHistoryData:self.storeListArray[indexPath.row]]) {
        [self.historyArray addObject:self.storeListArray[indexPath.row]];
        [SingleDataManager shareSingleDataManager].historyArray = self.historyArray;
        
    }
    
}




@end
