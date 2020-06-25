//
//  MyMoreViewController.m
//  Test2
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 maimai. All rights reserved.
//

#import "MyMoreViewController.h"

@interface MyMoreViewController ()<UITextFieldDelegate>

@end
// 设置页面的操作类
@implementation MyMoreViewController
UITableView *refTableView;


+(void)setTableViewObject:(UITableView*)tableView {
    refTableView = tableView;
    
}



+(void)boardWillShow:(NSNotification *)sender{
    NSLog(@"dfg===============================d");

    //获得键盘的尺寸
    //CGRect keyBoardRect=[sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //NSLog(@"===============================%d",  keyBoardRect.size.height);
    //当键盘将要显示时，将tableView的下边距增跟改为键盘的高度
    refTableView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0);
}


+(void)boardDidHide:(NSNotification *)sender{
    //当键盘将要消失时，边距还原初始状态
    refTableView.contentInset = UIEdgeInsetsZero;
}

+(void)redEnvelopeSwitchChange:(UISwitch*)sender {
//    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [sender isOn];
    [Comm saveHookConfig:[NSNumber numberWithBool:isButtonOn] forKey:@"isRedEnvelopeSwitchEnable"];
}

// 创建微信运动输入框控件
+(UITableViewCell*) createWCSportTextField {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mycell"];

    cell.textLabel.text = @"微信步数";
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0,0,200,40)];
    textField.placeholder = @"不填则不启用";
    // 数字键盘
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.text = [Comm confWcWalkNumberString];
    cell.backgroundColor =[UIColor whiteColor];
    cell.accessoryView = textField;
    //监听键盘输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:textField];
    
    //键盘将要显示时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘将要结束时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    textField.delegate = self;
    return cell;
}



+(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if( ![self validateNumber:string]) {
        return NO;
    }
    return YES;
}

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


+ (void)textFieldDidChangeValue:(NSNotification *)notification{
    UITextField *sender = (UITextField *)[notification object];
    int wcWalkNumber = [sender.text intValue];
    //NSLog(@"=====%d", wcWalkNumber);

    if (wcWalkNumber > 66666) {
        wcWalkNumber = 66666;
        sender.text = @"66666";
    }
    [Comm saveHookConfig:sender.text forKey:@"wcWalkNumberString"];
}

@end
