//
//  Voice_RegistViewController.h
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/26.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^ButtonBlock)(UIButton *button);

@interface Voice_RegistViewController : BaseViewController
{
    ButtonBlock _buttonBlock;
}

- (void)setButtonBlock:(ButtonBlock)block;

@end
