//
//  User.m
//  CardsGame
//
//  Created by JETS on 4/5/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "User.h"
#import "Constants.h"

@implementation User

@synthesize username, name, score, image;

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:username forKey:[Constants getUsernameKey]];
    [aCoder encodeObject:name forKey:[Constants getNameKey]];
    [aCoder encodeInteger:score forKey:[Constants getScoreKey]];
    [aCoder encodeObject:image forKey:[Constants getImageKey]];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        username = [aDecoder decodeObjectForKey:[Constants getUsernameKey]];
        name = [aDecoder decodeObjectForKey:[Constants getNameKey]];
        score = [aDecoder decodeIntegerForKey:[Constants getScoreKey]];
        image = [aDecoder decodeObjectForKey:[Constants getImageKey]];
    }
    return self;
}

-(void)printData {
    printf("Username: %s\n", [username UTF8String]);
    printf("Name: %s\n", [name UTF8String]);
    printf("Score: %d\n", score);
}

@end
