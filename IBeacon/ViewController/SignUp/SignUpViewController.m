//
//  SignUpViewController.m
//  IBeacon
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *keyword;
@property (weak, nonatomic) IBOutlet UITextField *suerKeyword;
@property (weak, nonatomic) IBOutlet UITextField *checkNumber;


@end

@implementation SignUpViewController

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

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)getCheackNumber:(id)sender {
    [UserModel getCheckNumberWithPhone:_phoneNumber.text block:^(NSArray *data, NSError *error) {
        
    }];
    
    
}

- (IBAction)submitForm:(id)sender {
    
    
    
}











@end
