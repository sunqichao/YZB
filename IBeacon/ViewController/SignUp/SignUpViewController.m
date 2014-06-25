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
- (void)clear
{
    [self.phoneNumber resignFirstResponder];
    [self.keyword resignFirstResponder];
    [self.suerKeyword resignFirstResponder];
    [self.checkNumber resignFirstResponder];
}

- (IBAction)clearKeyboard:(id)sender {
    [self clear];
    
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)getCheackNumber:(id)sender {
    [UserModel getCheckNumberWithPhone:_phoneNumber.text block:^(NSArray *data, NSError *error) {
        
    }];
    
    
}

- (IBAction)submitForm:(id)sender {
    [self clear];

    NSString *phoneNumber = self.phoneNumber.text;
    NSString *psd = self.keyword.text;
    NSString *suerPsd = self.suerKeyword.text;
    NSString *check = self.checkNumber.text;
    
    if ([psd isEqualToString:suerPsd]) {
        [UserModel signUpWithPhoneNumber:phoneNumber checkMa:check password:psd block:^(NSArray *data, NSError *error) {
            
        }];
    }else
    {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入密码不一样" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
    
}











@end
