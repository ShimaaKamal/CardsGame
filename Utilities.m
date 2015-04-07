//
//  Utilities.m
//  CardsGame
//
//  Created by JETS on 4/3/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "Utilities.h"
#import "Constants.h"
#import "User.h"

@implementation Utilities

+(void)sendRequest:(NSString *)url :(NSString *)parameters :(id)delegate {
    NSData* postData = [parameters dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString* postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];
    [connection start];
}

+(void)saveTopUsers:(NSArray *)usersDictionary {
    NSMutableArray* users = [NSMutableArray new];
    for (NSDictionary* userDictionary in usersDictionary) {
        User* user = [User new];
        user.username = [userDictionary objectForKey:[Constants getUsernameKey]];
        user.name = [userDictionary objectForKey:[Constants getNameKey]];
        user.score = [[userDictionary objectForKey:[Constants getScoreKey]] intValue];
        
        NSString* imageURL = [userDictionary objectForKey:[Constants getImageURLKey]];
        if (imageURL != nil) {
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            UIImage* image = [UIImage imageWithData:data];
            user.image = image;
        }
        [users addObject:user];
        
        printf("------------------------------------------\n");
        [user printData];
    }
    
    NSString* filePath = [@"/Users/participant/Desktop/CardsGame" stringByAppendingPathComponent:@"Users.plist"];
    NSData* archivedData = [NSKeyedArchiver archivedDataWithRootObject:users];
    [archivedData writeToFile:filePath atomically:YES];
}

@end
