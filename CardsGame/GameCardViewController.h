//
//  GameCardViewController.h
//  CardsGame
//
//  Created by JETS on 4/4/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCardViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UISwitch* switch_sound;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButton;

@property (strong, nonatomic) IBOutlet UILabel *Timer;

@property (strong, nonatomic) IBOutlet UILabel *TextScore;

- (IBAction)FlipCard:(UIButton *)sender;
-(UIImage *) drawRandomCard;
-(IBAction)changeSwitch:(id)sender;


@end
