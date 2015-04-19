//
//  Constants.h
//  CardsGame
//
//  Created by JETS on 3/31/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString* URL_LOGIN_SERVICE;
static const NSString* URL_REGISTER_SERVICE;
static const NSString* URL_TOP_SCORES_SERVICE;
static const NSString* URL_UPDATE_USER_SERVICE;

@interface Constants : NSObject

+(NSString*) getLoginURL;
+(NSString*) getRegisterURL;
+(NSString*) getTopScoresURL;
+(NSString*) getUpdateUserURL;

+(NSString*) getusernameParameter;
+(NSString*) getPasswordParameter;
+(NSString*) getNameParameter;
+(NSString*) getScoreParameter;
+(NSString*) getImageWidthParameter;
+(NSString*) getImageParameter;

+(NSString*) getUsernameKey;
+(NSString*) getPasswordKey;
+(NSString*) getNameKey;
+(NSString*) getScoreKey;
+(NSString*) getImageKey;
+(NSString*) getImageURLKey;
+(NSString*) getSoundEnabledKey;

+(NSString*) getStatusProperty;
+(NSString*) getMessageProperty;

+(NSString*) getSuccessStatus;
+(NSString*) getFailingStatus;

+(NSString*) getUserProperty;
+(NSString*) getNameProperty;
+(NSString*) getScoreProperty;
+(NSString*) getImageWidthProperty;
+(NSString*) getImageURLProperty;
+(NSString*) getTopUsersProperty;

@end
