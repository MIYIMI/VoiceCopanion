//
//  Voice_FirstViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/10.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_FirstViewController.h"

@interface Voice_FirstViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView *numberView;
    UILabel *phoneNumlbl;
    UIWebView *phoneCallWebView;
    
    NSMutableString *numStr;
}

@end

@implementation Voice_FirstViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        numStr = [[NSMutableString alloc] init];
        
        self.navigationItem.title = @"通话记录";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.frame = CGRectMake(0, 0, SCRW, (SCRH-NAVHEIGHT-TABHEIGHT)-95-(SCRW-200)/3*4);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    numberView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableview.frame), SCRW, 95+(SCRW-200)/3*4)];
    numberView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:numberView];
    
    [self layoutNumView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutNumView{
    phoneNumlbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCRW-45, 30)];
    phoneNumlbl.font = LMH_FONT_20;
    phoneNumlbl.textAlignment = NSTextAlignmentCenter;
    phoneNumlbl.lineBreakMode = NSLineBreakByTruncatingHead;
    [numberView addSubview:phoneNumlbl];
    
    UIImageView *rightView = [[UIImageView alloc] initWithImage:LOAD_LOCALIMG(@"phone")];
    rightView.frame = CGRectMake(SCRW - 40, 5, 30, 20);
    rightView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearNum)];
    [rightView addGestureRecognizer:tapZer];
    [numberView addSubview:rightView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, SCRW, 1)];
    line.backgroundColor = LMH_COLOR_BACKGROUND;
    [numberView addSubview:line];
    
    CGFloat offsetY = 0;
    CGFloat btnW = (SCRW-200)/3;
    
    NSArray *letterArray = [NSArray arrayWithObjects:@"ABC", @"DEF", @"GHI", @"JKL", @"MNO", @"PQRS", @"TUV", @"WXYZ", nil];
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnW*(i%3)+35+(i%3)*65, CGRectGetHeight(phoneNumlbl.frame)+i/3*btnW+5*((i/3)+1), btnW, btnW)];
        btn.layer.borderColor = LMH_COLOR_BLACKTEXT.CGColor;
        btn.layer.borderWidth = 0.4;
        btn.layer.cornerRadius = btnW/2;
        
        UILabel *numLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, btnW/5, btnW, btnW/2)];
        numLbl.font = LMH_FONT_25;
        numLbl.textAlignment = NSTextAlignmentCenter;
        numLbl.textColor = LMH_COLOR_GRAYTEXT;
        [btn addSubview:numLbl];
        
        UILabel *letterLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numLbl.frame), btnW, btnW/5)];
        letterLbl.font = LMH_FONT_9;
        letterLbl.textAlignment = NSTextAlignmentCenter;
        letterLbl.textColor = LMH_COLOR_GRAYTEXT;
        [btn addSubview:letterLbl];
        
        if (i == 0) {
            numLbl.text = [NSString stringWithFormat:@"%d",i+1];
        }else if (i < 9) {
            numLbl.text = [NSString stringWithFormat:@"%d",i+1];
        }else if(i == 9){
            numLbl.text = @"﹡";
        }else if(i == 10){
             numLbl.text = @"0";
        }else if(i == 11){
             numLbl.text = @"＃";
        }
        
        if (i != 0 && i <= letterArray.count) {
            letterLbl.text = letterArray[i-1];
        }
        
        [btn setTitleColor:LMH_COLOR_GRAYTEXT forState:UIControlStateNormal];
        [btn.titleLabel setFont:LMH_FONT_30];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(numberClick:) forControlEvents:UIControlEventTouchUpInside];
        [numberView addSubview:btn];
        
        offsetY = CGRectGetMaxY(btn.frame);
    }
    
    UIButton *callBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, offsetY+5, SCRW, 40)];
    callBtn.backgroundColor = [UIColor greenColor];
    [callBtn setBackgroundImage:LOAD_LOCALIMG(@"phone") forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:callBtn];
}

- (void)numberClick:(UIButton *)sender{
    if (sender.tag - 1000 < 9) {
         [numStr appendFormat:@"%zi",sender.tag - 999];
    }else if(sender.tag - 1000 == 9){
        [numStr appendString:@"﹡"];
    }else if (sender.tag - 1000 == 10){
        [numStr appendString:@"0"];
    }else{
        [numStr appendString:@"#"];
    }
    
    phoneNumlbl.text = numStr;
}

- (void)clearNum{
    if (numStr.length > 0) {
        [numStr setString:[numStr substringToIndex:numStr.length-1]];
        phoneNumlbl.text = numStr;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"RECORD";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.imageView.image = LOAD_LOCALIMG(@"phone");
    cell.textLabel.text = @"鸡子巴子";
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    UILabel *phoneLbl = (UILabel *)[cell viewWithTag:1000];
    if (!phoneLbl) {
        phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCRW/3*2-20, 0, SCRW/3, 44)];
        phoneLbl.textColor = [UIColor lightGrayColor];
        phoneLbl.text = @"05-12 18:56";
        phoneLbl.font = LMH_FONT_14;
        [cell.contentView addSubview:phoneLbl];
    }
    
    UIImageView *accessView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    accessView.image = LOAD_LOCALIMG(@"phone");
    cell.accessoryView = accessView;
    
    return cell;
}

- (void)callPhone{
    if (numStr.length <= 0) {
        return;
    }
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",numStr]];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

@end
