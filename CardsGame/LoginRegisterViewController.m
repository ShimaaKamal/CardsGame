//
//  LoginRegisterViewController.m
//  CardsGame
//
//  Created by JETS on 3/31/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "EditProfileViewController.h"
#import "Constants.h"

static const int USERNAME_MIN_LENGTH = 4;
static const int PASSWORD_MIN_LENGTH = 6;

static const NSString* ERROR_USERNAME_MIN_LENGTH = @"Minimum length for username is 4 characters";
static const NSString* ERROR_PASSWORD_MIN_LENGTH = @"Minimum length for password is 6 characters";

static const NSString* REGISTER_TRUE = @"true";

@interface LoginRegisterViewController ()

@end

@implementation LoginRegisterViewController

@synthesize imageView, textField_username, textField_password, label_usernameErrors, label_passwordErrors;

-(void)login:(id)sender {
    if ([self validate]) {
        NSString* request = [self addParameters];
        NSDictionary* dictionary = [self sendRequest:request];
        
        NSString* status = [dictionary objectForKey:[Constants getStatusProperty]];
        NSString* message = [dictionary objectForKey:[Constants getMessageProperty]];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:status message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        printf("---------------------------------------\n");
        printf("Status:%s\n", [status UTF8String]);
        printf("Message:%s\n", [message UTF8String]);
        
        if ([status isEqualToString:[Constants getSuccessStatus]]) {
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:textField_username.text forKey:[Constants getUsernameKey]];
            [defaults setObject:textField_password.text forKey:[Constants getPasswordKey]];
            
        } else if ([status isEqualToString:[Constants getFailingStatus]]) {
        }
    }
}

-(void)register:(id)sender {
    if ([self validate]) {
        NSString* request = [self addParameters];
        NSString* registerFlag = [[[Constants getRegisterParameter] stringByAppendingString:@"="] stringByAppendingString:REGISTER_TRUE];
        request = [[request stringByAppendingString:@"&"] stringByAppendingString:registerFlag];
        NSDictionary* dictionary = [self sendRequest:request];
        
        NSString* status = [dictionary objectForKey:[Constants getStatusProperty]];
        NSString* message = [dictionary objectForKey:[Constants getMessageProperty]];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:status message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        printf("---------------------------------------\n");
        printf("Status:%s\n", [status UTF8String]);
        printf("Message:%s\n", [message UTF8String]);
        
        if ([status isEqualToString:[Constants getSuccessStatus]]) {
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:textField_username.text forKey:[Constants getUsernameKey]];
            [defaults setObject:textField_password.text forKey:[Constants getPasswordKey]];
            
            printf("True\n");
        } else if ([status isEqualToString:[Constants getFailingStatus]]) {
            printf("False\n");
        }
        
    }
}

-(BOOL)validate {
    BOOL valid = YES;
    if ([textField_username.text length] < USERNAME_MIN_LENGTH) {
        label_usernameErrors.text = ERROR_USERNAME_MIN_LENGTH;
        valid = NO;
    } else {
        label_usernameErrors.text = @"";
    }
    if ([textField_password.text length] < PASSWORD_MIN_LENGTH) {
        label_passwordErrors.text = ERROR_PASSWORD_MIN_LENGTH;
        valid = NO;
    } else {
        label_passwordErrors.text = @"";
    }
    return valid;
}

-(NSString*)addParameters {
    NSString* usernameParameter = [[[Constants getusernameParameter] stringByAppendingString:@"="] stringByAppendingString:textField_username.text];
    NSString* passwordParameter = [[[Constants getPasswordParameter] stringByAppendingString:@"="] stringByAppendingString:textField_password.text];
    NSString* url = [[[[[Constants getLoginRegisterURL] stringByAppendingString:@"?"] stringByAppendingString:usernameParameter] stringByAppendingString:@"&"] stringByAppendingString:passwordParameter];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
