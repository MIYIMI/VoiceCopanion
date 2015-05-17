//
//  BaseViewController.h
//  VoiceCopanion
//
//  Created by 米翊米 on 15/4/8.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationContrller.h"

@interface BaseViewController : UIViewController

@property(nonatomic,strong) NavigationContrller *navigationController;
@property(nonatomic) BOOL navHiden;
@property(nonatomic) BOOL tabHiden;

@end
