//
//  EditProfileViewController.h
//  CardsGame
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView* imageView;
@property (strong, nonatomic) IBOutlet UITextField* textField_name;

-(IBAction)changeImage:(id)sender;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

-(NSString*) addParameters;
-(NSDictionary*) sendRequest: (NSString*) requestURL;

@end
