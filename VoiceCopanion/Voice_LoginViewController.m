//
//  Voice_LoginViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/24.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_LoginViewController.h"
#import "Voice_RegistViewController.h"

@interface Voice_LoginViewController ()
{
    UITextField *aField;
    UITextField *pField;
    
    BOOL is_remember;
}

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
        is_remember = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    [self createUI];
    
    [self.navigationController addLeftBarItem];
    [self.navigationController addRightBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarItemClick{
    Voice_RegistViewController *registVC = [[Voice_RegistViewController alloc] initWithNibName:nil bundle:nil];
    registVC.navigationController = self.navigationController;
    registVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registVC animated:YES];
    
    [registVC setButtonBlock:^(UIButton *button) {
        if ([self.delegate respondsToSelector:@selector(didLogin)]) {
            [self.delegate didLogin];
        }
    }];
}

- (void)createUI{
    CGFloat frameH = 30.0;
    
    UIImageView *aImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCRW/8, 40, frameH, frameH)];
    aImgView.image = LOAD_LOCALIMG(@"phone");
    [self.view addSubview:aImgView];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aImgView.frame)+2, CGRectGetMinY(aImgView.frame), 75, frameH)];
    aLabel.font = LMH_FONT_18;
    aLabel.textColor = LMH_COLOR_LGTGRAYTEXT;
    aLabel.text = @"手机号：";
    [self.view addSubview:aLabel];
    
    aField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aLabel.frame), CGRectGetMinY(aLabel.frame), SCRW - CGRectGetMaxX(aLabel.frame)-SCRW/8, frameH)];
    aField.font = LMH_FONT_18;
    aField.layer.borderWidth = 0.5;
    aField.layer.borderColor = LMH_COLOR_LINE.CGColor;
    aField.textColor = LMH_COLOR_LGTGRAYTEXT;
    aField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:aField];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if ([userDef objectForKey:@"username"]) {
        aField.text = [userDef objectForKey:@"username"];
    }
    
    UIImageView *pImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCRW/8, CGRectGetMaxY(aLabel.frame)+20, frameH, frameH)];
    pImgView.image = LOAD_LOCALIMG(@"phone");
    [self.view addSubview:pImgView];
    
    UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pImgView.frame)+2, CGRectGetMinY(pImgView.frame), 75, frameH)];
    pLabel.font = LMH_FONT_18;
    pLabel.textColor = LMH_COLOR_LGTGRAYTEXT;
    pLabel.text = @"密   码：";
    [self.view addSubview:pLabel];
    
    pField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pLabel.frame), CGRectGetMinY(pLabel.frame), SCRW - CGRectGetMaxX(pLabel.frame)-SCRW/8, frameH)];
    pField.font = LMH_FONT_18;
    pField.layer.borderWidth = 0.5;
    pField.layer.borderColor = LMH_COLOR_LINE.CGColor;
    pField.textColor = LMH_COLOR_LGTGRAYTEXT;
    pField.clearsOnBeginEditing = YES;
    pField.secureTextEntry = YES;
    [self.view addSubview:pField];
    
    if ([userDef objectForKey:@"password"]) {
        pField.text = [userDef objectForKey:@"password"];
    }
    
    UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCRW/8, CGRectGetMaxY(pImgView.frame)+40, frameH, frameH)];
    [imgBtn setTitle:@"N" forState:UIControlStateNormal];
    [imgBtn setTitle:@"S" forState:UIControlStateSelected];
    [imgBtn setTitleColor:LMH_COLOR_SKIN forState:UIControlStateNormal];
    [imgBtn setTitleColor:LMH_COLOR_ORANGE forState:UIControlStateSelected];
    [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.selected = YES;
    [self.view addSubview:imgBtn];
    
    UILabel *rLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgBtn.frame)+5, CGRectGetMinY(imgBtn.frame), 80, frameH)];
    rLabel.font = LMH_FONT_16;
    rLabel.textColor = LMH_COLOR_GRAYTEXT;
    rLabel.text = @"记住密码";
    [self.view addSubview:rLabel];
    
    UIButton *findBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCRW-SCRW/8-80, CGRectGetMinY(imgBtn.frame), 80, frameH)];
    [findBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [findBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [findBtn.titleLabel setFont:LMH_FONT_16];
    findBtn.layer.cornerRadius = 3.0;
    [findBtn setBackgroundColor:LMH_COLOR_ORANGE];
    [self.view addSubview:findBtn];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCRW/16, CGRectGetMaxY(findBtn.frame)+10, SCRW/8*7, 40)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登   录" forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:LMH_FONT_20];
    [loginBtn setBackgroundColor:[UIColor greenColor]];
    loginBtn.layer.cornerRadius = 3.0;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)imgBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        is_remember = YES;
    }else{
        is_remember = NO;
    }
}

- (void)loginClick{
    NSString *telephoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *telephoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telephoneRegex];
    
    if (![telephoneTest evaluateWithObject:aField.text] && aField.text.length != 11) {
        [self textStateHUD:@"请输入正确的手机号码"];
        return;
    }
    
    NSString *passRegex = @"^[0-9a-zA-Z_@#$%&*]{6,16}$";
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    
    if (![passTest evaluateWithObject:pField.text]) {
        [self textStateHUD:@"密码为6~16位字符"];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"login"];
    if ([self.delegate respondsToSelector:@selector(didLogin)]) {
        [self.delegate didLogin];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:aField.text forKey:@"username"];
    if (is_remember) {
        [[NSUserDefaults standardUserDefaults] setObject:pField.text forKey:@"password"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
    }
}

@end
