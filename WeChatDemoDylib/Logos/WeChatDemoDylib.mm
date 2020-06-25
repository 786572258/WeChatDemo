#line 1 "/Users/mac/Documents/xcodeProject/WeChatDemo/WeChatDemoDylib/Logos/WeChatDemoDylib.xm"
#import <UIKit/UIKit.h>
#import "WeChatDemoDylib/Header.h"
#import "WeChatDemoDylib/Comm.h"
#import "WeChatDemoDylib/MyMoreViewController.h"
#import "WeChatDemoDylib/MyRedEnvelopesProcc.h"


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class CMessageMgr; @class MoreViewController; @class WCRedEnvelopesLogicMgr; @class WCTableViewManager; @class WCDeviceStepObject; 
static void _logos_method$_ungrouped$WCTableViewManager$redEnvelopeSwitchChange$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$WCTableViewManager$tableView$cellForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id, NSIndexPath*); static id _logos_method$_ungrouped$WCTableViewManager$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id, NSIndexPath*); static long long (*_logos_orig$_ungrouped$WCTableViewManager$tableView$numberOfRowsInSection$)(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id, long long); static long long _logos_method$_ungrouped$WCTableViewManager$tableView$numberOfRowsInSection$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id, long long); static long long (*_logos_orig$_ungrouped$WCTableViewManager$numberOfSectionsInTableView$)(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id); static long long _logos_method$_ungrouped$WCTableViewManager$numberOfSectionsInTableView$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id); static double (*_logos_orig$_ungrouped$WCTableViewManager$tableView$heightForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id, NSIndexPath*); static double _logos_method$_ungrouped$WCTableViewManager$tableView$heightForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST, SEL, id, NSIndexPath*); static void (*_logos_orig$_ungrouped$CMessageMgr$onNewSyncAddMessage$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$CMessageMgr$onNewSyncAddMessage$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$)(_LOGOS_SELF_TYPE_NORMAL WCRedEnvelopesLogicMgr* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(_LOGOS_SELF_TYPE_NORMAL WCRedEnvelopesLogicMgr* _LOGOS_SELF_CONST, SEL, id, id); static unsigned int (*_logos_orig$_ungrouped$WCDeviceStepObject$m7StepCount)(_LOGOS_SELF_TYPE_NORMAL WCDeviceStepObject* _LOGOS_SELF_CONST, SEL); static unsigned int _logos_method$_ungrouped$WCDeviceStepObject$m7StepCount(_LOGOS_SELF_TYPE_NORMAL WCDeviceStepObject* _LOGOS_SELF_CONST, SEL); static unsigned int (*_logos_orig$_ungrouped$WCDeviceStepObject$hkStepCount)(_LOGOS_SELF_TYPE_NORMAL WCDeviceStepObject* _LOGOS_SELF_CONST, SEL); static unsigned int _logos_method$_ungrouped$WCDeviceStepObject$hkStepCount(_LOGOS_SELF_TYPE_NORMAL WCDeviceStepObject* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$MoreViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("MoreViewController"); } return _klass; }
#line 7 "/Users/mac/Documents/xcodeProject/WeChatDemo/WeChatDemoDylib/Logos/WeChatDemoDylib.xm"




static void _logos_method$_ungrouped$WCTableViewManager$redEnvelopeSwitchChange$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id sender) {
    [MyMoreViewController redEnvelopeSwitchChange:sender];
}

static id _logos_method$_ungrouped$WCTableViewManager$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, NSIndexPath* arg2) {
    NSLog(@"indexPath===%@", arg2);
    
    if ([[[[arg1 nextResponder] nextResponder] nextResponder] isKindOfClass:_logos_static_class_lookup$MoreViewController()]) {
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
    return _logos_orig$_ungrouped$WCTableViewManager$tableView$cellForRowAtIndexPath$(self, _cmd, arg1, arg2);
}


static long long _logos_method$_ungrouped$WCTableViewManager$tableView$numberOfRowsInSection$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, long long arg2) {
    NSLog(@"num===%lld", arg2);
    
    if ([[[[arg1 nextResponder] nextResponder] nextResponder] isKindOfClass:_logos_static_class_lookup$MoreViewController()]) {
        NSLog(@"红包section的行数");
        if (arg2 == 4) {
            return 1;
        } else if (arg2 == 5) {
            
            return 1;
        }

    }
    return _logos_orig$_ungrouped$WCTableViewManager$tableView$numberOfRowsInSection$(self, _cmd, arg1, arg2);

}


static long long _logos_method$_ungrouped$WCTableViewManager$numberOfSectionsInTableView$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    NSLog(@"num2===%@", arg1);
    if ([[[[arg1 nextResponder] nextResponder] nextResponder] isKindOfClass:_logos_static_class_lookup$MoreViewController()]) {
        NSLog(@"这是设置页面");
        return _logos_orig$_ungrouped$WCTableViewManager$numberOfSectionsInTableView$(self, _cmd, arg1)+2;
    }
    return _logos_orig$_ungrouped$WCTableViewManager$numberOfSectionsInTableView$(self, _cmd, arg1);

}



static double _logos_method$_ungrouped$WCTableViewManager$tableView$heightForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL WCTableViewManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, NSIndexPath* arg2) {
    if (arg2.section == 4 or arg2.section == 5) {
        return 50;
    }
    return _logos_orig$_ungrouped$WCTableViewManager$tableView$heightForRowAtIndexPath$(self, _cmd, arg1, arg2);
}





static void _logos_method$_ungrouped$CMessageMgr$onNewSyncAddMessage$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    _logos_orig$_ungrouped$CMessageMgr$onNewSyncAddMessage$(self, _cmd, arg1);
    [MyRedEnvelopesProcc onNewSyncAddMessageProcc:arg1];
}






static void _logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(_LOGOS_SELF_TYPE_NORMAL WCRedEnvelopesLogicMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id hongBaoRes, id hongBaoReq) {
    _logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(self, _cmd, hongBaoRes, hongBaoReq);
    [MyRedEnvelopesProcc OnWCToHongbaoCommonResponseProcc:hongBaoRes Request:hongBaoReq];


}







static unsigned int _logos_method$_ungrouped$WCDeviceStepObject$m7StepCount(_LOGOS_SELF_TYPE_NORMAL WCDeviceStepObject* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    int count = [[Comm confWcWalkNumberString] intValue];
    NSLog(@"步数：%d", count);
    if (count) {
        return count;
    }
    return _logos_orig$_ungrouped$WCDeviceStepObject$m7StepCount(self, _cmd);
}


static unsigned int _logos_method$_ungrouped$WCDeviceStepObject$hkStepCount(_LOGOS_SELF_TYPE_NORMAL WCDeviceStepObject* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    int count = [[Comm confWcWalkNumberString] intValue];
    NSLog(@"步数：%d", count);
    if (count) {
       return count;
    }
    return _logos_orig$_ungrouped$WCDeviceStepObject$hkStepCount(self, _cmd);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$WCTableViewManager = objc_getClass("WCTableViewManager"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$WCTableViewManager, @selector(redEnvelopeSwitchChange:), (IMP)&_logos_method$_ungrouped$WCTableViewManager$redEnvelopeSwitchChange$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$WCTableViewManager, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$WCTableViewManager$tableView$cellForRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$WCTableViewManager$tableView$cellForRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$WCTableViewManager, @selector(tableView:numberOfRowsInSection:), (IMP)&_logos_method$_ungrouped$WCTableViewManager$tableView$numberOfRowsInSection$, (IMP*)&_logos_orig$_ungrouped$WCTableViewManager$tableView$numberOfRowsInSection$);MSHookMessageEx(_logos_class$_ungrouped$WCTableViewManager, @selector(numberOfSectionsInTableView:), (IMP)&_logos_method$_ungrouped$WCTableViewManager$numberOfSectionsInTableView$, (IMP*)&_logos_orig$_ungrouped$WCTableViewManager$numberOfSectionsInTableView$);MSHookMessageEx(_logos_class$_ungrouped$WCTableViewManager, @selector(tableView:heightForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$WCTableViewManager$tableView$heightForRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$WCTableViewManager$tableView$heightForRowAtIndexPath$);Class _logos_class$_ungrouped$CMessageMgr = objc_getClass("CMessageMgr"); MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(onNewSyncAddMessage:), (IMP)&_logos_method$_ungrouped$CMessageMgr$onNewSyncAddMessage$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$onNewSyncAddMessage$);Class _logos_class$_ungrouped$WCRedEnvelopesLogicMgr = objc_getClass("WCRedEnvelopesLogicMgr"); MSHookMessageEx(_logos_class$_ungrouped$WCRedEnvelopesLogicMgr, @selector(OnWCToHongbaoCommonResponse:Request:), (IMP)&_logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$, (IMP*)&_logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$);Class _logos_class$_ungrouped$WCDeviceStepObject = objc_getClass("WCDeviceStepObject"); MSHookMessageEx(_logos_class$_ungrouped$WCDeviceStepObject, @selector(m7StepCount), (IMP)&_logos_method$_ungrouped$WCDeviceStepObject$m7StepCount, (IMP*)&_logos_orig$_ungrouped$WCDeviceStepObject$m7StepCount);MSHookMessageEx(_logos_class$_ungrouped$WCDeviceStepObject, @selector(hkStepCount), (IMP)&_logos_method$_ungrouped$WCDeviceStepObject$hkStepCount, (IMP*)&_logos_orig$_ungrouped$WCDeviceStepObject$hkStepCount);} }
#line 125 "/Users/mac/Documents/xcodeProject/WeChatDemo/WeChatDemoDylib/Logos/WeChatDemoDylib.xm"
