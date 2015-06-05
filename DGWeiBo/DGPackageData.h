//
//  DGPackageData.h
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/27.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^failureError)(NSError *error );

typedef void(^requestData)(id responseObject);


@interface DGPackageData : NSObject

/*!
 * @function 获取微博
 *
 * @abstract
 *  刷新最新公共微博
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  count :   单页返回的记录条数，默认为50。
 
 *  page  :   返回结果的页码，默认为1。
 
 *  baseApp : 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 */
+ (void)newestPublicWeiboWithCount:(NSString *)count page:(NSString *)page baseApp:(NSString *)baseApp responseObject:(requestData)blockObject failure:(failureError)failure;


/*! @function 获取指定人发布过的微博
 *
 *  @abstract
 *  拿到用户发布的微博
 *
 *  @discussion
 *  ID:指定发布人的ID
 *  page:返回结果的页码 默认为1
 */
+(void)userSendedWeiBoWithID:(NSString *)ID page:(NSString *)page responseObject:(requestData)blockObject failure:(failureError)failure;

/*!
 * @function 获取当前登录用户及其所关注用户的最新微博
 *
 * @abstract
 *  刷新首页关注人的微博
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  count :   单页返回的记录条数，默认为50。
 
 *  page  :   返回结果的页码，默认为1。
 */

+(void)home_timelineWithCount:(NSString *)count page:(NSString *)page responseObject:(requestData)blockObject failure:(failureError)failure;

/*!
 * @function 获取用户的关注列表
 *
 * @abstract
 *  关注的人
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  count :   单页返回的记录条数，默认为50。
 
 *  page  :   返回结果的页码，默认为1。
 
 *  ID:指定用户的ID
 */

+(void)friendshipsWithID:(NSString *)ID count:(NSString *)count responseObject:(requestData)blockObject failure:(failureError)failure;

/*!
 * @function 获取单条微博评论列表
 *
 * @abstract
 *  评论列表
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  ID:指定微博的ID
 */

+(void)weiboCommentsListWithID:(NSString *)ID responseObject:(requestData)blockObject failure:(failureError)failure;

/*!
 * @function 发布一条新微博
 *
 * @abstract
 *  发布微博
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  ID:用户的ID
 
 *  rip:开发者上报的操作用户真实IP，形如：211.156.0.1
 
 *  status: 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字
 */
+(void)publishWeiboWithID:(NSString *)ID status:(NSString *)status rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure;


/*!
 * @function 发布一条评论
 *
 * @abstract
 *  发布评论
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  ID:微博的ID
 
 *  rip:开发者上报的操作用户真实IP，形如：211.156.0.1
 
 *  comment: 要评论的文本内容，必须做URLencode，内容不超过140个汉字
 */

+(void)commentWeiboWithID:(NSString *)ID comment:(NSString *)comment rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure;


/*!
 * @function 发布一条带一张照片的微博
 *
 * @abstract
 * 发布微博带一张照片
 *
 * @discussion
 *  appkey : 采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 
 *  token : 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 
 *  ID:用户的ID
 
 *  rip:开发者上报的操作用户真实IP，形如：211.156.0.1
 
 *  status: 要评论的文本内容，必须做URLencode，内容不超过140个汉字
 
 *  picture: 照片的数据
 */
+(void)publishWeiBoWithPicture:(NSData *)picture ID:(NSString *)ID status:(NSString *)status rip:(NSString *)rip responseObject:(requestData)blockObject failure:(failureError)failure;
@end
