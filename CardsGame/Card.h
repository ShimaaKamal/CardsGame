//
//  Card.h
//  CardsGame
//
//  Created by JETS on 4/5/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic,getter=isfaceUp) BOOL faceUp;
@property (nonatomic,getter=isfPlayable) BOOL playble;
@property (strong,nonatomic) NSString *imageName;

@end
