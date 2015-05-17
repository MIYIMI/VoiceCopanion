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

@interface NavigationContrller : UINavigationController

@end
