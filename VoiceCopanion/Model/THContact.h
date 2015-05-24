//
//  Contact.h
//  upsi
//
//  Created by Mac on 3/24/14.
//  Copyright (c) 2014 Laith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface THContact : NSObject

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
- (NSString *)fullName;

@property (nonatomic, assign) NSInteger recordId;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) NSString *phone;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *dateUpdated;

@end
