//
//  Voice_LoginViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/24.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_LoginViewController.h"

@interface Voice_LoginViewController ()<NavigationContrllerDelegate>

@end

@implementation Voice_LoginViewController

+ (void)showInViewController:(id<LoginDelegate>)mainVC
{
    Voice_LoginViewController *loginVC = [[Voice_LoginViewController alloc] initWithNibName:nil bundle:nil];

    [loginVC setDelegate:mainVC];
    NavigationContrller *navc = [[NavigationContrller alloc] initWithRootViewController:loginVC];
    loginVC.navigationController = navc;
    [(UIViewController*)mainVC presentViewController:navc animated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.navigationController.navDelegate = self;
    
    [self.navigationController addLeftBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createUI{
    UIImageView *aImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCRW/8, 40, 20, 20)];
    aImgView.image = LOAD_LOCALIMG(@"phone");
    [self.view addSubview:aImgView];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aImgView.frame), CGRectGetMinY(aImgView.frame), 60, 20)];
    aLabel.font = LMH_FONT_18;
    aLabel.textColor = LMH_COLOR_GRAYTEXT;
    aLabel.text = @"手机号：";
    [self.view addSubview:aLabel];
    
    UITextField *aField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxY(aLabel.frame), CGRectGetMaxY(aLabel.frame), SCRW - CGRectGetMaxX(aLabel.frame)-10, 20)];
    aField.font = LMH_FONT_18;
    aField.textColor = LMH_COLOR_GRAYTEXT;
    [self.view addSubview:aField];
    
    UIImageView *pImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCRW/8, CGRectGetMaxY(aLabel.frame)+20, 20, 20)];
    pImgView.image = LOAD_LOCALIMG(@"phone");
    [self.view addSubview:pImgView];
    
    UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pImgView.frame), CGRectGetMinY(pImgView.frame), 60, 20)];
    pLabel.font = LMH_FONT_18;
    pLabel.textColor = LMH_COLOR_GRAYTEXT;
    pLabel.text = @"密  码：";
    [self.view addSubview:pLabel];
    
    UITextField *pField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxY(pLabel.frame), CGRectGetMaxY(pLabel.frame), SCRW - CGRectGetMaxX(pLabel.frame)-10, 20)];
    pField.font = LMH_FONT_18;
    pField.textColor = LMH_COLOR_GRAYTEXT;
    [self.view addSubview:pField];
}

@end
