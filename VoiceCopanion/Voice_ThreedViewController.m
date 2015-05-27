//
//  Voice_ThreedViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/27.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_ThreedViewController.h"
#import "Voice_ResetViewController.h"

@interface Voice_ThreedViewController ()

@end

@implementation Voice_ThreedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"短信设置";
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI{
    UILabel *phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, SCRW-80, 20)];
    phoneNumLabel.textColor = LMH_COLOR_BLACKTEXT;
    phoneNumLabel.font = LMH_FONT_15;
    phoneNumLabel.text = @"15872378907";
    [self.view  addSubview:phoneNumLabel];
    
    NSString *str = @"可用短信3000条\n已用短信1000条";
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:LMH_COLOR_SKIN range:NSMakeRange(4, 4)];
    
    UILabel *smsNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(phoneNumLabel.frame), CGRectGetMaxY(phoneNumLabel.frame)+5, SCRW/3, 50)];
    smsNumLabel.numberOfLines = 0;
    smsNumLabel.font = LMH_FONT_15;
    smsNumLabel.attributedText = attrStr;
    [self.view addSubview:smsNumLabel];
    
    UIButton *rechargeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCRW-100, CGRectGetMaxY(smsNumLabel.frame)-30, 60, 30)];
    rechargeBtn.layer.cornerRadius = 3.0;
    [rechargeBtn.titleLabel setFont:LMH_FONT_15];
    [rechargeBtn setBackgroundColor:LMH_COLOR_ORANGE];
    [rechargeBtn setTitle:@"充 值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeBtn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rechargeBtn];
    
    UITextView *contenView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(smsNumLabel.frame), CGRectGetMaxY(rechargeBtn.frame)+5, SCRW-80, SCRW-80)];
    contenView.font = LMH_FONT_15;
    contenView.textColor = LMH_COLOR_BLACKTEXT;
    contenView.layer.borderColor = LMH_COLOR_GRAYTEXT.CGColor;
    contenView.layer.borderWidth = 0.5;
    [self.view addSubview:contenView];
    
    UIButton *resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(contenView.frame)+10, SCRW-100, 40)];
    resetBtn.layer.cornerRadius = 3.0;
    [resetBtn.titleLabel setFont:LMH_FONT_15];
    [resetBtn setBackgroundColor:[UIColor greenColor]];
    [resetBtn setTitle:@"内容重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
    
}

- (void)rechargeClick{
    
}

- (void)resetClick{
    Voice_ResetViewController *resetVC = [[Voice_ResetViewController alloc] initWithNibName:nil bundle:nil];
    resetVC.hidesBottomBarWhenPushed = YES;
    resetVC.navigationController = self.navigationController;
    [self.navigationController pushViewController:resetVC animated:YES];
}

@end
