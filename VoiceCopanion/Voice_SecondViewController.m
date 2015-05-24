//
//  Voice_SecondViewController.m
//  VoiceCopanion
//
//  Created by 米翊米 on 15/5/21.
//  Copyright (c) 2015年 米翊米. All rights reserved.
//

#import "Voice_SecondViewController.h"
#import <AddressBook/AddressBook.h>
#import "THContact.h"
#import "pinyin.h"
#import "ChineseString.h"
#import <AddressBookUI/AddressBookUI.h>

@interface Voice_SecondViewController ()<ABNewPersonViewControllerDelegate,ABPersonViewControllerDelegate>
{
    NSArray *addressBookArray;
    NSMutableArray *seachArray;
    NSMutableArray *resultArray;
    ABAddressBookRef addressBookRef;
}

@end

@implementation Voice_SecondViewController

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"联系人";
        self.edgeInsetsZero = NO;
        
        seachArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断是否开启权限
    ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getContactsFromAddressBook];
            });
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在系统设置-隐私-通讯录打开权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    });
    
    for (int i = 0; i < 27; i++){
        NSString *cstr = @"";
        if (i == 26) {
            cstr = @"#";
        }else{
            cstr = [NSString stringWithFormat:@"%c", 'A'+i];
        }
        
        [seachArray addObject:cstr];
    }
    
    self.tableview.bounces = YES;
    self.tableview.sectionIndexColor = LMH_COLOR_GRAYTEXT;
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setBackgroundImage:LOAD_LOCALIMG(@"phone") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UINavigationItem * navItem = self.navigationController.topViewController.navigationItem;
    [navItem setRightBarButtonItem:rightItem animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshContacts];
    });
}

- (void)addAddress{
    ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
    picker.newPersonViewDelegate = self;
    
    NavigationContrller *navigation = [[NavigationContrller alloc] initWithRootViewController:picker];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)compositor{
    resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 27; i++) {
        [resultArray addObject:[NSArray array]];
    }
    for (THContact *cont in addressBookArray) {
        ChineseString *chineseString=[[ChineseString alloc]init];
        
        chineseString.string = [NSString stringWithString:cont.fullName];
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<chineseString.string.length;j++){
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin = pinYinResult;
        }else{
            chineseString.pinYin = @"";
        }
        
        NSString *oneC = @"";
        if (chineseString.pinYin.length > 0) {
            oneC = [chineseString.pinYin substringToIndex:1];
        }
        
        BOOL isP = YES;
        for (int i = 0; i < seachArray.count-1; i++) {
            NSString *cp = seachArray[i];
            if (![cp compare:oneC options:NSCaseInsensitiveSearch | NSNumericSearch]) {
                isP = NO;
                
                NSMutableArray *array = [NSMutableArray arrayWithArray:resultArray[i]];
                [array addObject:cont];
                [resultArray replaceObjectAtIndex:i withObject:array];
                break;
            }
        }
        if (isP) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:resultArray[resultArray.count-1]];
            [array addObject:cont];
            [resultArray replaceObjectAtIndex:seachArray.count-1 withObject:array];
        }
    }
}

- (void) refreshContacts
{
    [self getContactsFromAddressBook];
    
    [self.tableview reloadData];
}

-(void)getContactsFromAddressBook
{
    CFErrorRef error = NULL;
    addressBookArray = [[NSMutableArray alloc]init];
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (addressBook) {
        NSArray *allContacts = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *mutableContacts = [NSMutableArray arrayWithCapacity:allContacts.count];
        
        NSUInteger i = 0;
        for (i = 0; i<[allContacts count]; i++)
        {
            THContact *contact = [[THContact alloc] init];
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            contact.recordId = ABRecordGetRecordID(contactPerson);
            
            // Get first and last names
            NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            
            // Set Contact properties
            contact.firstName = firstName;
            contact.lastName = lastName;
            
            // Get mobile number
            ABMultiValueRef phonesRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty);
            contact.phone = [self getMobilePhoneProperty:phonesRef];
            if(phonesRef) {
                CFRelease(phonesRef);
            }
            
            // Get image if it exists
            NSData  *imgData = (__bridge_transfer NSData *)ABPersonCopyImageData(contactPerson);
            contact.image = [UIImage imageWithData:imgData];
            if (!contact.image) {
                contact.image = [UIImage imageNamed:@"phone"];
            }
            
            [mutableContacts addObject:contact];
        }
        
        if(addressBook) {
            CFRelease(addressBook);
        }
        
        addressBookArray = [NSArray arrayWithArray:mutableContacts];
        [self compositor];
        
        [self.tableview reloadData];
    }else{
        NSLog(@"Error");
        
    }
}

- (NSString *)getMobilePhoneProperty:(ABMultiValueRef)phonesRef
{
    for (int i=0; i < ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        
        if(currentPhoneLabel) {
            if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
            
            if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
        }
        if(currentPhoneLabel) {
            CFRelease(currentPhoneLabel);
        }
        if(currentPhoneValue) {
            CFRelease(currentPhoneValue);
        }
    }
    
    return nil;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return seachArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return seachArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (seachArray.count > section) {
        return seachArray[section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (resultArray.count > section) {
        return [resultArray[section] count]?20:0;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (resultArray.count > section) {
        return [resultArray[section] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Get the desired contact from the filteredContacts array
    THContact *contact = [resultArray[indexPath.section] objectAtIndex:indexPath.row];
    
    // Initialize the table view cell
    NSString *cellIdentifier = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    UIImageView *imgIcon = (UIImageView *)[cell viewWithTag:100];
    if (!imgIcon) {
        imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 34, 34)];
        imgIcon.layer.cornerRadius = 17;
        imgIcon.layer.masksToBounds=YES;
        imgIcon.tag = 100;
        [cell.contentView addSubview:imgIcon];
    }
    
    UILabel *textLabel = (UILabel *)[cell viewWithTag:101];
    if (!textLabel) {
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgIcon.frame)+10,0,SCRW-CGRectGetMaxX(imgIcon.frame)-20,22)];
        textLabel.font = LMH_FONT_15;
        textLabel.textColor = LMH_COLOR_BLACKTEXT;
        textLabel.tag = 101;
        [cell.contentView addSubview:textLabel];
    }
    textLabel.text = contact.fullName;
    
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:102];
    if (!detailLabel) {
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgIcon.frame)+10,CGRectGetMaxY(textLabel.frame),SCRW-CGRectGetMaxX(imgIcon.frame)-20,22)];
        detailLabel.font = LMH_FONT_13;
        detailLabel.textColor = LMH_COLOR_GRAYTEXT;
        detailLabel.tag = 102;
        [cell.contentView addSubview:detailLabel];
    }
    detailLabel.text = contact.phone;
    
    if (contact.image) {
        imgIcon.image = contact.image;
    }else{
        imgIcon.image = LOAD_LOCALIMG(@"phone");
    }
    
    return cell;
}

#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller.
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person
                    property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
    return NO;
}

@end
