//
//  Utilities.m
//  CardsGame
//
//  Created by JETS on 4/3/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "Utilities.h"

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

@end
