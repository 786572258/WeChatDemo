#import <UIKit/UIKit.h>
#import "WeChatDemoDylib/Header.h"
#import "WeChatDemoDylib/Comm.h"
#import "WeChatDemoDylib/MyMoreViewController.h"
#import "WeChatDemoDylib/MyRedEnvelopesProcc.h"

%hook WCTableViewManager

// 自动抢红包开关事件处理
%new
-(void) redEnvelopeSwitchChange:(id)sender {
    [MyMoreViewController redEnvelopeSwitchChange:sender];
}
// 表格每一行的遍历
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(NSIndexPath*)arg2 {
    NSLog(@"indexPath===%@", arg2);
    //arg2 =
    if ([[[[arg1 nextResponder] nextResponder] nextResponder] isKindOfClass:%c(MoreViewController)]) {
        if (arg2.section == 4) {
            NSLog(@"红包的行cell");
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mycell"];
            cell.textLabel.text=@"自动抢红包";
            cell.backgroundColor =[UIColor whiteColor];

            UISwitch *sw = [[UISwitch alloc] init];
            sw.on = [Comm confIsRedEnvelopeSwitchEnable];
            [sw addTarget:self action:@selector(redEnvelopeSwitchChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = sw;

            return cell;
        } else if (arg2.section == 5) {
            [MyMoreViewController setTableViewObject:arg1];
            return [MyMoreViewController createWCSportTextField];
        }
       
    }
    return %orig;
}

// 每组有多少行
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2 {
    NSLog(@"num===%lld", arg2);
    // 红包设置的行
    if ([[[[arg1 nextResponder] nextResponder] nextResponder] isKindOfClass:%c(MoreViewController)]) {
        NSLog(@"红包section的行数");
        if (arg2 == 4) {
            return 1;
        } else if (arg2 == 5) {
            // 微信运动的行数
            return 1;
        }

    }
    return %orig;

}

// 表格有多少组
- (long long)numberOfSectionsInTableView:(id)arg1 {
    NSLog(@"num2===%@", arg1);
    if ([[[[arg1 nextResponder] nextResponder] nextResponder] isKindOfClass:%c(MoreViewController)]) {
        NSLog(@"这是设置页面");
        return %orig+2;
    }
    return %orig;

}


// 每一行的高度控制
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(NSIndexPath*)arg2 {
    if (arg2.section == 4 or arg2.section == 5) {
        return 50;
    }
    return %orig;
}

%end

%hook CMessageMgr
// 收到微信消息
- (void)onNewSyncAddMessage:(id)arg1{
    %orig;
    [MyRedEnvelopesProcc onNewSyncAddMessageProcc:arg1];
}
%end



%hook WCRedEnvelopesLogicMgr
// [redEnvelopesLogicMgr ReceiverQueryRedEnvelopesRequest:mutableDict] 请求后的响应，拆红包请求的回调
- (void)OnWCToHongbaoCommonResponse:(id)hongBaoRes Request:(id)hongBaoReq {
    %orig;
    [MyRedEnvelopesProcc OnWCToHongbaoCommonResponseProcc:hongBaoRes Request:hongBaoReq];


}
%end


// 微信步数
%hook WCDeviceStepObject

- (unsigned int)m7StepCount
{
    int count = [[Comm confWcWalkNumberString] intValue];
    NSLog(@"步数：%d", count);
    if (count) {
        return count;
    }
    return %orig;
}

- (unsigned int)hkStepCount
{
    int count = [[Comm confWcWalkNumberString] intValue];
    NSLog(@"步数：%d", count);
    if (count) {
       return count;
    }
    return %orig;
}
%end

