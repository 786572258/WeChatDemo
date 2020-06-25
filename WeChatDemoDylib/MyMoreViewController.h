//
//  MyMoreViewController.h
//  Test2
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 maimai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Comm.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyMoreViewController : NSObject
+(void)redEnvelopeSwitchChange:(id)sender;
+(UITableViewCell*) createWCSportTextField;
+(void)setTableViewObject:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END
