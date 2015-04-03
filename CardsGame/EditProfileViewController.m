//
//  EditProfileViewController.m
//  CardsGame
//
//  Created by JETS on 4/1/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Constants.h"
#import "Utilities.h"

NSString* response;

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

@synthesize imageView, textField_name;

-(void)changeImage:(id)sender {
    
}

-(void)save:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:textField_name.text forKey:[Constants getNameKey]];
    [Utilities sendRequest:[Constants getUpdateUserURL] :[self addParameters] :self];
    response = @"";
}

-(void)cancel:(id)sender {
    
}

-(NSString *)addParameters {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [defaults stringForKey:[Constants getUsernameKey]];
    NSString* password = [defaults stringForKey:[Constants getPasswordKey]];
    
    NSString* usernameParameter = [[[Constants getusernameParameter] stringByAppendingString:@"="] stringByAppendingString:username];
    NSString* passwordParameter = [[[Constants getPasswordParameter] stringByAppendingString:@"="] stringByAppendingString:password];
    NSString* nameParameter = [[[Constants getNameParameter] stringByAppendingString:@"="] stringByAppendingString:textField_name.text];
    
    //    NSString* score = [NSString stringWithFormat:@"%d", [defaults integerForKey:[Constants getScoreKey]]];
    //    NSString* scoreParameter = [[[Constants getScoreParameter] stringByAppendingString:@"="] stringByAppendingString:score];
    
    NSString* parameters = [[[[usernameParameter stringByAppendingString:@"&"] stringByAppendingString:passwordParameter] stringByAppendingString:@"&"] stringByAppendingString:nameParameter];
    
    parameters = [parameters stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    return parameters;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSString* status = [dictionary objectForKey:[Constants getStatusProperty]];
    NSString* message = [dictionary objectForKey:[Constants getMessageProperty]];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:status message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
    if ([status isEqualToString:[Constants getSuccessStatus]]) {
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* name = [defaults stringForKey:[Constants getNameKey]];
    
    textField_name.text = name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
