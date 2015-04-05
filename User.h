//
//  User.h
//  CardsGame
//
//  Created by JETS on 4/5/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property NSString* username;
@property NSString* name;
@property int score;
@property UIImage* image;

-(void) printData;

@end
