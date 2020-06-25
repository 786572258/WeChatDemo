//
//  MyRedEnvelopesProcc.m
//  WeChatDemoDylib
//
//  Created by Mac on 2020/6/21.
//  Copyright © 2020 maimai. All rights reserved.
//

#import "MyRedEnvelopesProcc.h"


@interface SPRedParameter : NSObject
@property (copy, nonatomic) NSString *sendId;
@property (copy, nonatomic) NSString *timingIdentifier;
@property (strong, nonatomic) NSMutableDictionary *params;
@end
@implementation SPRedParameter
- (NSString *)sendId{
    return self.params[@"sendId"];
}

- (void)setTimingIdentifier:(NSString *)timingIdentifier{
    [self.params safeSetObject:timingIdentifier forKey: @"timingIdentifier"];
}
@end

@interface SPRedManager: NSObject
@property (nonatomic, strong) NSMutableArray *array;

+ (instancetype) sharedInstance;
- (void)addParams:(SPRedParameter *) params;
- (SPRedParameter *) getParams:(NSString *) sendId;
@end

@implementation SPRedManager
+ (instancetype) sharedInstance{
    static SPRedManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SPRedManager alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    if (self = [super init]){
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

//添加对象
- (void)addParams:(SPRedParameter *) params{
    @synchronized(self) {
        [_array addObject:params];
    }
}
//获得对象
- (SPRedParameter *) getParams:(NSString *) sendId{
    @synchronized(self) {
        NSInteger resultIndex = -1;
        for (NSInteger index = 0 ; index < self.array.count ; index++) {
            SPRedParameter *params = self.array[index];
            if ([params.sendId isEqualToString:sendId]){ //找到了
                resultIndex = index;
                break;
            }
        }
        if (resultIndex != -1 ){
            SPRedParameter *params = self.array[resultIndex];
            [self.array removeObjectAtIndex:resultIndex];
            return params;
        }
        return nil;
    }
}

@end



// 红包处理类
@implementation MyRedEnvelopesProcc
+(void) onNewSyncAddMessageProcc:(id)arg1 {
    //arg1 = (NSObject)arg1;
    CMessageWrap * wrap = arg1;

    NSLog(@"红包==========%@\n%@",arg1,[arg1 class]);
    NSLog(@"类型==========%d\n",wrap.m_uiMessageType);
    if (wrap.m_uiMessageType != 49) {
        NSLog(@"不是红包消息");
    }
    if (![Comm confIsRedEnvelopeSwitchEnable]) {
        NSLog(@"不启用抢红包功能");
        return;
    }
    //收到红包消息
    NSString *nsFromUsr = [wrap m_nsFromUsr];
    // 只有是红包消息类型才会有m_oWCPayInfoItem
    WCPayInfoItem *payInfoItem = [wrap m_oWCPayInfoItem];
    NSLog(@"payInfoItem==========%@\n",payInfoItem);
    if (payInfoItem == nil){
        return;
    }
    NSString * m_c2cNativeUrl = [payInfoItem m_c2cNativeUrl];
    if (m_c2cNativeUrl == nil){
        NSLog(@"m_c2cNativeUrl是nil !!!!!!!!!");
        return;
    }
    NSInteger length = [@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length];
    NSString *subString = [m_c2cNativeUrl substringFromIndex: length];
    NSDictionary *dict =  [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:subString separator:@"&"];
    NSMutableDictionary *mutableDict =  [NSMutableDictionary dictionary];
    [mutableDict setObject:@"1" forKey:@"msgType"];
    NSString *sendId = dict[@"sendid"];
    [mutableDict safeSetObject:sendId forKey:@"sendId"];
    NSString *channelId = dict[@"channelid"];
    [mutableDict safeSetObject:channelId forKey:@"channelId"];
    
    CContactMgr *service =  [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *contact =  [service getSelfContact];
    NSString *displayName = [contact getContactDisplayName];
    [mutableDict safeSetObject:displayName forKey:@"nickName"];
    NSString *headerImg =  [contact m_nsHeadImgUrl];
    [mutableDict safeSetObject:headerImg forKey:@"headImg"];
    id nativeUrl = [payInfoItem m_c2cNativeUrl];
    [mutableDict safeSetObject:nativeUrl forKey:@"nativeUrl"];
    
    // 之前获取m_nsUsrName的方式只有在聊天窗口才有能获得变量，不人性的做法，改
    /*MMMsgLogicManager *logicManager =  [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("MMMsgLogicManager") class]];
    BaseMsgContentLogicController *logicController = [logicManager GetCurrentLogicController];
    id m_contact = [logicController m_contact];
    id sessionUserName = [m_contact m_nsUsrName];
    //wxid_wps5gzsp30an32
     */
    NSString *sessionUserName = [wrap m_nsFromUsr];
    [mutableDict safeSetObject:sessionUserName forKey:@"sessionUserName"];
    
    if ([nsFromUsr hasSuffix:@"@chatroom"]){
        //群红包
        [mutableDict safeSetObject:@"0" forKey:@"inWay"]; //0:群聊，1：单聊
    }else {
        //个人红包
        [mutableDict safeSetObject:@"1" forKey:@"inWay"]; //0:群聊，1：单聊
    }
    
    [mutableDict safeSetObject:@"0" forKey:@"agreeDuty"];
    
    if (sendId.length > 0)   {
        SPRedParameter *redParameter = [[SPRedParameter alloc] init];
        redParameter.params = mutableDict;
        [[SPRedManager sharedInstance] addParams:redParameter];
    }
    NSLog(@"SPRedManager------mutableDict=%@",mutableDict);
    WCRedEnvelopesLogicMgr *redEnvelopesLogicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("WCRedEnvelopesLogicMgr") class]];
    [redEnvelopesLogicMgr ReceiverQueryRedEnvelopesRequest:mutableDict];
    
}

+(void) OnWCToHongbaoCommonResponseProcc:(id)hongBaoRes Request:(id)hongBaoReq {
    
    
    HongBaoRes * response = hongBaoRes;
    HongBaoReq * request = hongBaoReq;
    NSLog(@"request------=%@",request);

    NSLog(@"response------=%@",response);


    NSError *err;
    NSDictionary *bufferDic = [NSJSONSerialization JSONObjectWithData:response.retText.buffer options:NSJSONReadingMutableContainers error:&err];
    NSLog(@"bufferDic------=%@",bufferDic);
    

    if (response == nil || bufferDic == nil){
        return;
    }
    if (request == nil){
        return;
    }
    if (request.cgiCmd == 3){
        int receiveStatus = [bufferDic[@"receiveStatus"] intValue];
        int hbStatus = [bufferDic[@"hbStatus"] intValue];
        /*
        可抢状态：cgiCmdid = 3 自己可抢 ， cgiCmdid = 5 自己已抢过
        红包状态：hbStatus = 2 可抢红包， hbStatus = 4 自己抢过 ，hbStatus=5 过期红包
        是否自己发的：“isSender”:0 别人发的，“isSender”:1 自己发的
        是否群红包：“hbType”:1 群红包，“hbType”:0 个人红包
        自己是否抢过：“receiveStatus”:0 未抢过 ， “receiveStatus”:2 已抢过
         */
        if (receiveStatus == 0 && hbStatus == 2){
            // 没有timingIdentifier字段会被判定为使用外挂
            NSString *timingIdentifier = bufferDic[@"timingIdentifier"];
            NSString *sendId = bufferDic[@"sendId"];
            if (sendId.length > 0 && timingIdentifier.length > 0){
                SPRedParameter *redParameter = [[SPRedManager sharedInstance] getParams:sendId];
                if (redParameter != nil){
                    redParameter.timingIdentifier = timingIdentifier;
                    // 抢的太快也会被判定为使用外挂
                    sleep(1);
                    WCRedEnvelopesLogicMgr *redEnvelopesLogicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("WCRedEnvelopesLogicMgr") class]];
                    if (nil != redEnvelopesLogicMgr){
                        // 真正抢红包的请求
                        NSLog(@"redParameter------=%@",redParameter.params);

                        [redEnvelopesLogicMgr OpenRedEnvelopesRequest:redParameter.params];
                    }

                }
            }
        }
    }
}

@end
 
