//
//  MyRedEnvelopesProcc.h
//  WeChatDemoDylib
//
//  Created by Mac on 2020/6/21.
//  Copyright © 2020 maimai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeChatDemoDylib/Header.h"
#import "WeChatDemoDylib/Comm.h"
#import <objc/message.h>
#import "NSMutableDictionary+Safe.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyRedEnvelopesProcc : NSObject
+(void) onNewSyncAddMessageProcc:(id)arg1;
+(void) OnWCToHongbaoCommonResponseProcc:(id)hongBaoRes Request:(id)hongBaoReq;

@end

NS_ASSUME_NONNULL_END
