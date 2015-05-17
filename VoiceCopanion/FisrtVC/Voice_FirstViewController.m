//
//  Voice_FirstViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/10.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_FirstViewController.h"

@interface Voice_FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}

@end

@implementation Voice_FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCRW, 180) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor blackColor];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    
    [self.view addSubview:myTableView];
    
    [self setExtraCellLineHidden:myTableView];
    
    self.title = @"通话记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"RECORD";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor blackColor];
    }
    cell.imageView.image = LOAD_LOCALIMG(@"phone");
    cell.textLabel.text = @"鸡子巴子";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = @"15868007221";
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    UILabel *phoneLbl = (UILabel *)[cell viewWithTag:1000];
    if (!phoneLbl) {
        phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCRW/2, 0, SCRW/2-35, 44)];
        phoneLbl.textColor = [UIColor whiteColor];
        phoneLbl.text = @"2015-05-12 18:56:23";
        phoneLbl.font = LMH_FONT_14;
        [cell.contentView addSubview:phoneLbl];
    }
    
    UIImageView *accessView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    accessView.image = LOAD_LOCALIMG(@"phone");
    cell.accessoryView = accessView;
    
    return cell;
}

@end
