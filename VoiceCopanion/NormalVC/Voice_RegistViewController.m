//
//  Voice_RegistViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/26.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_RegistViewController.h"

@interface Voice_RegistViewController ()
{
    UITextField *aField;
    UITextField *pField;
    UITextField *cField;
}

@end

@implementation Voice_RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"注册";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController addLeftBarItem];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI{
    CGFloat frameH = 30.0;
    
    UIImageView *aImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCRW/8, 40, frameH, frameH)];
    aImgView.image = LOAD_LOCALIMG(@"phone");
    [self.view addSubview:aImgView];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aImgView.frame)+2, CGRectGetMinY(aImgView.frame), 75, frameH)];
    aLabel.font = LMH_FONT_16;
    aLabel.textColor = LMH_COLOR_LGTGRAYTEXT;
    aLabel.text = @"手机号：";
    [self.view addSubview:aLabel];
    
    aField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(aLabel.frame), CGRectGetMinY(aLabel.frame), SCRW - CGRectGetMaxX(aLabel.frame)-SCRW/8, frameH)];
    aField.font = LMH_FONT_15;
    aField.layer.borderWidth = 0.5;
    aField.layer.borderColor = LMH_COLOR_LINE.CGColor;
    aField.textColor = LMH_COLOR_LGTGRAYTEXT;
    aField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:aField];
    
    UIButton *authBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCRW/8, CGRectGetMaxY(aField.frame)+10, 65+frameH, frameH)];
    authBtn.layer.cornerRadius = 3.0;
    authBtn.backgroundColor = LMH_COLOR_ORANGE;
    [authBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [authBtn.titleLabel setFont:LMH_FONT_15];
    [authBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [authBtn addTarget:self action:@selector(authClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:authBtn];
    
    cField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(authBtn.frame)+12, CGRectGetMinY(authBtn.frame), SCRW - CGRectGetMaxX(authBtn.frame)-SCRW/8-12, frameH)];
    cField.font = LMH_FONT_15;
    cField.layer.borderWidth = 0.5;
    cField.layer.borderColor = LMH_COLOR_LINE.CGColor;
    cField.textColor = LMH_COLOR_LGTGRAYTEXT;
    cField.placeholder = @"请输入验证码";
    cField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:cField];

    UIImageView *pImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCRW/8, CGRectGetMaxY(cField.frame)+10, frameH, frameH)];
    pImgView.image = LOAD_LOCALIMG(@"phone");
    [self.view addSubview:pImgView];
    
    UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pImgView.frame)+2, CGRectGetMinY(pImgView.frame), 75, frameH)];
    pLabel.font = LMH_FONT_16;
    pLabel.textColor = LMH_COLOR_LGTGRAYTEXT;
    pLabel.text = @"密   码：";
    [self.view addSubview:pLabel];
    
    pField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pLabel.frame), CGRectGetMinY(pLabel.frame), SCRW - CGRectGetMaxX(pLabel.frame)-SCRW/8, frameH)];
    pField.font = LMH_FONT_16;
    pField.layer.borderWidth = 0.5;
    pField.layer.borderColor = LMH_COLOR_LINE.CGColor;
    pField.textColor = LMH_COLOR_LGTGRAYTEXT;
    pField.clearsOnBeginEditing = YES;
    pField.secureTextEntry = YES;
    [self.view addSubview:pField];
    
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCRW/16, CGRectGetMaxY(pField.frame)+30, SCRW/8*7, 40)];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn setTitle:@"注    册" forState:UIControlStateNormal];
    [registBtn.titleLabel setFont:LMH_FONT_20];
    [registBtn setBackgroundColor:[UIColor greenColor]];
    registBtn.layer.cornerRadius = 3.0;
    [registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

- (void)registClick:(UIButton *)sender{
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
    [[NSUserDefaults standardUserDefaults] setObject:aField.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:pField.text forKey:@"password"];
    
    if (_buttonBlock) {
        _buttonBlock(sender);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)authClick{
    [self textStateHUD:@"验证码已发送"];
}

- (void)setButtonBlock:(ButtonBlock)block{
    _buttonBlock = block;
}

@end
