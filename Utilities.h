//
//  Utilities.h
//  CardsGame
//
//  Created by JETS on 4/3/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(void) sendRequest: (NSString*) url : (NSString*) parameters : (id) delegate;
+(void) saveTopUsers: (NSArray*) usersDictionary;

@end
