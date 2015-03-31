//
//  Constants.h
//  CardsGame
//
//  Created by JETS on 3/31/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString* URL_LOGIN_REGISTER_SERVLET;
static const NSString* URL_TOP_USER_SERVLET;
static const NSString* URL_UPDATE_USER_SERVLET;

@interface Constants : NSObject

+(NSString*) getLoginRegisterURL;
+(NSString*) getTopUsersURL;
+(NSString*) getUpdateUserURL;

+(NSString*) getUsernameKey;
+(NSString*) getPasswordKey;
+(NSString*) getNameKey;
+(NSString*) getScoreKey;

@end
