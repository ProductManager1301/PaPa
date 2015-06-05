//
//  UsersModel.h
//  DGWeiBo
//
//  Created by 蔡思敏 on 15/6/3.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "JSONModel.h"

@class UserInfoModel;

@protocol UserInfoModel

@end


@interface UsersModel : JSONModel

@property (strong , nonatomic)NSArray <UserInfoModel>* users;

@end
