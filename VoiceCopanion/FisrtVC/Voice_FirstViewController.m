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
    UITableView *myTableView;
    UIView *numberView;
    UILabel *numlbl;
    
    NSMutableString *numStr;
}

@end

@implementation Voice_FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        numStr = [[NSMutableString alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCRW, (SCRH-NAVHEIGHT-TABHEIGHT)/7*2) style:UITableViewStylePlain];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.backgroundColor = [UIColor whiteColor];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
    [self.view addSubview:myTableView];
    
    //设置cell分割线起始位置
    if ([myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    //清除多余分割线
    [self setExtraCellLineHidden:myTableView];
    
    numberView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myTableView.frame), SCRW, (SCRH-NAVHEIGHT-TABHEIGHT)/7*5)];
    numberView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:numberView];
    
    [self layoutNumView];
    
    self.title = @"通话记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutNumView{
    numlbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCRW-10, 40)];
    numlbl.font = LMH_FONT_20;
    [numberView addSubview:numlbl];
    
    UIImageView *rightView = [[UIImageView alloc] initWithImage:LOAD_LOCALIMG(@"phone")];
    rightView.frame = CGRectMake(SCRW - 40, 10, 30, 20);
    rightView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapZer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearNum)];
    [rightView addGestureRecognizer:tapZer];
    [numberView addSubview:rightView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, SCRW, 1)];
    line.backgroundColor = LMH_COLOR_BACKGROUND;
    [numberView addSubview:line];
    
    CGFloat btnW = SCRW/3;
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnW*(i%3), CGRectGetHeight(numlbl.frame)+i/3*(btnW/2)+10, btnW, btnW/2)];
        if (i < 9) {
            [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        }else if(i == 9){
            [btn setTitle:@"﹡" forState:UIControlStateNormal];
        }else if(i == 10){
            [btn setTitle:@"0" forState:UIControlStateNormal];
        }else if(i == 11){
            [btn setTitle:@"#" forState:UIControlStateNormal];
        }
        
        [btn setTitleColor:LMH_COLOR_GRAYTEXT forState:UIControlStateNormal];
        [btn.titleLabel setFont:LMH_FONT_50];
        btn.tag = 1000+i;
        [btn addTarget:self action:@selector(numberClick:) forControlEvents:UIControlEventTouchUpInside];
        [numberView addSubview:btn];
    }
}

- (void)numberClick:(UIButton *)sender{
    [numStr appendFormat:@"%d",sender.tag - 1000 + 1];
    numlbl.text = numStr;
}

- (void)clearNum{
    if (numStr.length > 0) {
        [numStr setString:[numStr substringToIndex:numStr.length-1]];
        numlbl.text = numStr;
    }
}

- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//设置cell分割线起始位置
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

@end
