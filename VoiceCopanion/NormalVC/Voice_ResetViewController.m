//
//  Voice_ResetViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/28.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_ResetViewController.h"

@interface Voice_ResetViewController ()

@end

@implementation Voice_ResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内容重置";
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI{
    UILabel *helloLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, SCRW-40, 20)];
    helloLabel.font = LMH_FONT_15;
    helloLabel.textColor = LMH_COLOR_BLACKTEXT;
    helloLabel.text = @"您好!我是";
    [self.view addSubview:helloLabel];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(helloLabel.frame), CGRectGetMaxY(helloLabel.frame)+5, SCRW-40, 30)];
    field.backgroundColor = [UIColor whiteColor];
    field.placeholder = @"xx快递小唐";
    field.layer.borderColor = LMH_COLOR_GRAYTEXT.CGColor;
    field.layer.borderWidth = 0.5;
    field.font = LMH_FONT_15;
    field.textColor = LMH_COLOR_GRAYTEXT;
    [self.view addSubview:field];
    
    UILabel *contLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(field.frame)+50, SCRW-40, 20)];
    contLabel.font = LMH_FONT_15;
    contLabel.textColor = LMH_COLOR_BLACKTEXT;
    contLabel.text = @"联系电话:138********";
    [self.view addSubview:contLabel];
    
    UITextView *contview = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(contLabel.frame), CGRectGetMaxY(contLabel.frame)+5, SCRW-40, (SCRW-40)/2)];
    contview.backgroundColor = [UIColor whiteColor];
    contview.layer.borderColor = LMH_COLOR_GRAYTEXT.CGColor;
    contview.layer.borderWidth = 0.5;
    contview.font = LMH_FONT_15;
    contview.textColor = LMH_COLOR_GRAYTEXT;
    [self.view addSubview:contview];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(contview.frame)+10, SCRW-40, 40)];
    sureBtn.layer.cornerRadius = 3.0;
    [sureBtn.titleLabel setFont:LMH_FONT_15];
    [sureBtn setBackgroundColor:[UIColor greenColor]];
    [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

- (void)sureClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
