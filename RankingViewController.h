//
//  RankingViewController.h
//  CardsGame
//
//  Created by JETS on 4/3/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong , nonatomic) NSArray *names;
@property (strong , nonatomic) NSArray *scores;
@property (strong , nonatomic) NSArray *namesF;
@property (strong , nonatomic) NSArray *scoresF;

@end