//
//  DGPackageData.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/27.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "DGPackageData.h"
#import "HTTPRequest.h"
#import "AppDelegate.h"
#import "DGJSONModel.h"
#import "AFNetworking.h"
#import "UsersModel.h"

#define source_token  [(AppDelegate*)[[UIApplication sharedApplication] delegate] wbtoken]

@implementation DGPackageData

//刷新最新公共微博
+ (void)newestPublicWeiboWithCount:(NSString *)count page:(NSString *)page baseApp:(NSString *)baseApp responseObject:(requestData)blockObject failure:(failureError)failure{
    
    NSDictionary * dic = @{@"source"       : kAppKey,
                           @"access_token" : source_token,
                           @"count"        : count,
                           @"page"         : page,
                           @"base_app"     : baseApp};
    
    NSString * urlType = @"statuses/public_timeline.json";
    
    
    [HTTPRequest packageDatas:dic urlType:urlType httpMethod:HTTPMethodTypeGet  responseObject:^(id responseObject) {
        NSError * err;
        NewestWeiBoesModel* countrys = [[NewestWeiBoesModel alloc] initWithString:responseObject error:&err];
        if (err) {
            failure(err);
        }else{
            blockObject(countrys);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
}


//获取当前用户发布的微博
+(void)userSendedWeiBoWithID:(NSString *)ID page:(NSString *)page  responseObject:(requestData)blockObject failure:(failureError)failure{
    
    //请求消息体
    NSDictionary * dic = @{@"source":kAppKey,
                           @"access_token":source_token,
                           @"uid":ID,
                           @"page":page};
    
    NSString * urlString =@"statuses/user_timeline.json";
    
    [HTTPRequest packageDatas:dic urlType:urlString httpMethod:HTTPMethodTypeGet responseObject:^(id responseObject) {
        NSError * error;
        NewestWeiBoesModel * wbs = [[NewestWeiBoesModel alloc]initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(wbs);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//获取当前登录用户及其所关注用户的最新微博
+(void)home_timelineWithCount:(NSString *)count page:(NSString *)page responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source":kAppKey,
                           @"access_token":source_token,
                           @"page":page,
                           @"count":count};
    
    NSString * urlString =@"statuses/home_timeline.json";
    
    [HTTPRequest packageDatas:dic urlType:urlString httpMethod:HTTPMethodTypeGet responseObject:^(id responseObject) {
        NSError * error;
        NewestWeiBoesModel * pap = [[NewestWeiBoesModel alloc]initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(pap);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取用户的关注列表
+(void)friendshipsWithID:(NSString *)ID count:(NSString *)count responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source":kAppKey,
                           @"access_token":source_token,
                           @"uid":ID,
                           @"count":count};
    
    NSString * urlString =@"friendships/friends.json";
    
    [HTTPRequest packageDatas:dic urlType:urlString httpMethod:HTTPMethodTypeGet responseObject:^(id responseObject) {
        NSError * error;
        UsersModel * user =[[UsersModel alloc]initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(user);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

//获取单条微博评论列表
+(void)weiboCommentsListWithID:(NSString *)ID responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source":kAppKey,
                           @"access_token":source_token,
                           @"id":ID//微博id
                           };
    
    NSString * urlString =@"comments/show.json";
    
    [HTTPRequest packageDatas:dic urlType:urlString httpMethod:HTTPMethodTypeGet responseObject:^(id responseObject) {
        NSError * error;
        CommentsModel * comment = [[CommentsModel alloc]initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(comment);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//发布一条新微博
+(void)publishWeiboWithID:(NSString *)ID status:(NSString *)status rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source":kAppKey,
                           @"access_token":source_token,
                           @"id":ID,
                           @"status":status,
                           @"rip":rip
                           };
    
    NSString * urlString =@"statuses/update.json";
    
    [HTTPRequest packageDatas:dic urlType:urlString httpMethod:HTTPMethodTypePOST responseObject:^(id responseObject) {
        NSError * error;
        NewestWeiBoModel * weibo = [[NewestWeiBoModel alloc]initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(weibo);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//发布一条评论
+(void)commentWeiboWithID:(NSString *)ID comment:(NSString *)comment rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source":kAppKey,
                           @"access_token":source_token,
                           @"id":ID,
                           @"comment":comment,
                           @"rip":rip
                           };
    NSString * urlString = @"comments/create.json";
    
    
    [HTTPRequest packageDatas:dic urlType:urlString httpMethod:HTTPMethodTypePOST responseObject:^(id responseObject) {
        NSError * error;
        CommentModel * weibo = [[CommentModel alloc]initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(weibo);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//发布一条带一张照片的微博

+(void)publishWeiBoWithPicture:(NSData *)picture ID:(NSString *)ID status:(NSString *)status rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure{
    NSDictionary * dic = @{@"source":kAppKey,
                           @"access_token":source_token,
                           @"id":ID,
                           @"pic":picture,
                           @"status":status,
                           @"rip":rip
                           };
    
    NSString * urlString = @"statuses/upload.json";
    
    [HTTPRequest packageDatas:dic urlType:urlString httpMethod:HTTPMethodTypePOST responseObject:^(id responseObject) {
        NSError * error;
        NewestWeiBoModel * weibo = [[NewestWeiBoModel alloc]initWithString:responseObject error:&error];
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        }else{
            blockObject(weibo);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
