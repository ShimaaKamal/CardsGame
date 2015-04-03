//
//  LoginRegisterViewController.h
//  CardsGame
//
//  Created by JETS on 3/31/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginRegisterViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UIImageView* imageView;

@property (strong, nonatomic) IBOutlet UITextField* textField_username;
@property (strong, nonatomic) IBOutlet UITextField* textField_password;

@property (strong, nonatomic) IBOutlet UILabel* label_usernameErrors;
@property (strong, nonatomic) IBOutlet UILabel* label_passwordErrors;

-(IBAction)login:(id)sender;
-(IBAction)register:(id)sender;

@end
