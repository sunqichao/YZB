//
//  LoginViewController.m
//  IBeacon
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 YZB. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *keyWord;



@end

@implementation LoginViewController

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

- (IBAction)dismissKeyword:(id)sender {
    [self.phoneNumber resignFirstResponder];
    [self.keyWord resignFirstResponder];
    
}

- (IBAction)dismissController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)login:(id)sender {
    NSString *name = self.phoneNumber.text;
    NSString *keyword = self.keyWord.text;
    [UserModel loginWithUserName:name password:keyword block:^(NSArray *data, NSError *error) {
        
    }];
    
}


- (IBAction)forgetKeyword:(id)sender {
    
    
    
}


@end
