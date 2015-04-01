//
//  Constants.m
//  CardsGame
//
//  Created by JETS on 3/31/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "Constants.h"

static const NSString* PREFIX = @"http://";
static const NSString* IP = @"10.145.3.221";
//static const NSString* IP = @"192.168.1.5";
static const NSString* PORT = @"8084";

static const NSString* APP_NAME = @"Game";

static const NSString* URL;

static const NSString* LOGIN_REGISTER_SERVLET = @"LoginRegisterServlet";
static const NSString* TOP_USER_SERVLET = @"TopUsersServlet";
static const NSString* UPDATE_USER_SERVLET = @"UpdateUserServlet";

static const NSString* PARAMETER_USERNAME = @"username";
static const NSString* PARAMETER_PASSWORD = @"password";
static const NSString* PARAMETER_NAME = @"name";
static const NSString* PARAMETER_SCORE = @"score";
static const NSString* PARAMETER_REGISTER = @"register";

static const NSString* KEY_USERNAME = @"username";
static const NSString* KEY_PASSWORD = @"password";
static const NSString* KEY_NAME = @"name";
static const NSString* KEY_SCORE = @"score";

static const NSString* PROPERY_STATUS = @"Status";
static const NSString* PROPERY_MESSAGE = @"Message";

static const NSString* STATUS_SUCESS = @"Success";
static const NSString* STATUS_FAILING = @"Failure";

@implementation Constants

+(void)initialize {
    URL = [[[[PREFIX stringByAppendingString:IP] stringByAppendingString:@":"] stringByAppendingString:PORT] stringByAppendingPathComponent:APP_NAME];
    
    URL_LOGIN_REGISTER_SERVLET = [URL stringByAppendingPathComponent:LOGIN_REGISTER_SERVLET];
    
    URL_TOP_USER_SERVLET = [URL stringByAppendingPathComponent:TOP_USER_SERVLET];
    
    URL_UPDATE_USER_SERVLET = [URL stringByAppendingPathComponent:UPDATE_USER_SERVLET];
    
    printf("%s\n", [URL_LOGIN_REGISTER_SERVLET UTF8String]);
    printf("%s\n", [URL_TOP_USER_SERVLET UTF8String]);
    printf("%s\n", [URL_UPDATE_USER_SERVLET UTF8String]);
}

+(NSString *)getLoginRegisterURL {
    return URL_LOGIN_REGISTER_SERVLET;
}

+(NSString *)getTopUsersURL {
    return URL_TOP_USER_SERVLET;
}

+(NSString *)getUpdateUserURL {
    return URL_UPDATE_USER_SERVLET;
}

+(NSString *)getusernameParameter {
    return PARAMETER_USERNAME;
}

+(NSString *)getPasswordParameter {
    return PARAMETER_PASSWORD;
}

+(NSString *)getNameParameter {
    return PARAMETER_NAME;
}

+(NSString *)getScoreParameter {
    return PARAMETER_SCORE;
}

+(NSString *)getRegisterParameter {
    return PARAMETER_REGISTER;
}

+(NSString *)getUsernameKey {
    return KEY_USERNAME;
}

+(NSString *)getPasswordKey {
    return KEY_PASSWORD;
}

+(NSString *)getNameKey {
    return KEY_NAME;
}

+(NSString *)getScoreKey {
    return KEY_SCORE;
}

+(NSString *)getStatusProperty {
    return PROPERY_STATUS;
}

+(NSString *)getMessageProperty {
    return PROPERY_MESSAGE;
}

+(NSString *)getSuccessStatus {
    return STATUS_SUCESS;
}

+(NSString *)getFailingStatus {
    return STATUS_FAILING;
}

@end