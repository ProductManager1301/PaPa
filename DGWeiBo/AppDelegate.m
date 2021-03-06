//
//  AppDelegate.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/26.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "DGPackageData.h"
#import "DGJSONModel.h"
#import "GetIPAddress.h"
@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WeiboSDK enableDebugMode:YES];
    
   //注册，激活新浪微博App
   BOOL registerOk =  [WeiboSDK registerApp:kAppKey];
    
    if (registerOk) {
        NSLog(@"注册成功");
    }
    
    //检测本地是否已经有了token，如果有，就不用再去授权获取(token有期限详情请登录新浪微博官网进行查看)
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:[self path]];
    if (dic) {
        self.wbtoken = dic[@"token"];
        self.wbCurrentUserID = dic[@"userID"];
    }else{
        self.wbtoken = @"";
        self.wbCurrentUserID  =@"";
    }
//    [DGPackageData userSendedWeiBoWithID:self.wbCurrentUserID page:@"1" responseObject:^(id responseObject) {
//        NewestWeiBoesModel * news = responseObject;
//        NSArray * array = news.statuses;
//        NewestWeiBoModel * weibo = array[0];
//        
//        
//        [DGPackageData commentWeiboWithID:weibo.id comment:@"你好啊" rip:array1[1] responseObject:^(id responseObject) {
//            NSLog(@"成功了");
//            
//        } failure:^(NSError *error) {
//            NSLog(@"失败了");
//        }];
//    } failure:^(NSError *error) {
//        NSLog(@"");
//    }];
    
    
//    UIImage * image = [UIImage imageNamed:@"img"];
    
NSArray * array1 = [GetIPAddress getIpAddresses];

    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"img" ofType:@"png"]];
    [DGPackageData publishWeiBoWithPicture:data ID:self.wbCurrentUserID status:@"测试中1" rip:array1[1] responseObject:^(id responseObject) {
        NSLog(@"成功了");
    } failure:^(NSError *error) {
        NSLog(@"失败了");
    }];
    return YES;
}


/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{

}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:[WBAuthorizeResponse class]])
    {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        
        NSDictionary * dic = @{@"token" : self.wbtoken,
                               @"userID": self.wbCurrentUserID};
        
        [dic writeToFile:[self path] atomically:YES];
    }
}

//保存路径
- (NSString *)path{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    path = [path stringByAppendingPathComponent:@"userInfo.plist"];
    
    return path;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}

@end
