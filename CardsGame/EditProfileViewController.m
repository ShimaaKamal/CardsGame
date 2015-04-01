//
//  EditProfileViewController.m
//  CardsGame
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Constants.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

@synthesize imageView, textField_name;

-(void)changeImage:(id)sender {
    
}

-(void)save:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:textField_name.text forKey:[Constants getNameKey]];
    
    NSString* request = [self addParameters];
    NSDictionary* dictionary = [self sendRequest:request];
    
    NSString* status = [dictionary objectForKey:[Constants getStatusProperty]];
    NSString* message = [dictionary objectForKey:[Constants getMessageProperty]];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:status message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
    if ([status isEqualToString:[Constants getSuccessStatus]]) {
    }
}

-(void)cancel:(id)sender {
    
}

-(NSString *)addParameters {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [defaults stringForKey:[Constants getUsernameKey]];
    NSString* password = [defaults stringForKey:[Constants getPasswordKey]];
    NSString* name = textField_name.text;
//    NSString* score = [NSString stringWithFormat:@"%d", [defaults integerForKey:[Constants getScoreKey]]];
    
    NSString* usernameParameter = [[[Constants getusernameParameter] stringByAppendingString:@"="] stringByAppendingString:username];
    
    NSString* passwordParameter = [[[Constants getPasswordParameter] stringByAppendingString:@"="] stringByAppendingString:password];
    
    NSString* nameParameter = [[[Constants getNameParameter] stringByAppendingString:@"="] stringByAppendingString:name];
    
//    NSString* scoreParameter = [[[Constants getScoreParameter] stringByAppendingString:@"="] stringByAppendingString:score];
    
    NSString* url = [[[[[[[Constants getUpdateUserURL] stringByAppendingString:@"?"] stringByAppendingString:usernameParameter] stringByAppendingString:@"&"] stringByAppendingString:passwordParameter] stringByAppendingString:@"&"] stringByAppendingString:nameParameter];
    
    return url;
}

-(NSDictionary *)sendRequest:(NSString *)requestURL {
    requestURL = [requestURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL* url = [NSURL URLWithString:requestURL];
    NSString* response = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return dictionary;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* name = [defaults stringForKey:[Constants getNameKey]];
    
    textField_name.text = name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
