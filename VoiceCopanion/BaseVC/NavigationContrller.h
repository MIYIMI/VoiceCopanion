//
//  NavigationContrller.h
//  VoiceCopanion
//
//  Created by 米翊米 on 15/4/8.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (APSafeTransition)

@property(nonatomic, assign, getter = isTransitionInProgress) BOOL transitionInProgress;

@end

@protocol NavigationContrllerDelegate <NSObject>

@optional
- (void)leftBarItemClick;

@end

@interface NavigationContrller : UINavigationController

//- (void)leftBarItemClick;
- (void)addLeftBarItem;

@property(nonatomic,strong)id <NavigationContrllerDelegate>navDelegate;

@end
