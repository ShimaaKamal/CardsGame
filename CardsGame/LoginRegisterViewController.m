#import "LoginRegisterViewController.h"
#import "HomeViewController.h"
#import "Constants.h"
#import "Utilities.h"
#import "User.h"

static const int USERNAME_MIN_LENGTH = 4;
static const int PASSWORD_MIN_LENGTH = 6;

static const NSString* ERROR_USERNAME_MIN_LENGTH = @"At least 4 characters";
static const NSString* ERROR_PASSWORD_MIN_LENGTH = @"At least 6 characters";

BOOL isRegistering;
NSString* response;

@interface LoginRegisterViewController ()

@end

@implementation LoginRegisterViewController

@synthesize imageView, textField_username, textField_password, label_usernameErrors, label_passwordErrors;

-(void)login:(id)sender {
    if ([self validate]) {
        [Utilities sendRequest:[Constants getLoginURL] :[self addParameters] :self];
        isRegistering = NO;
        response = @"";
    }
}

-(void)register:(id)sender {
    if ([self validate]) {
        [Utilities sendRequest:[Constants getRegisterURL] :[self addParameters] :self];
        isRegistering = YES;
        response = @"";
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

-(NSString *)addParameters {
    NSString* usernameParameter = [[[Constants getusernameParameter] stringByAppendingString:@"="] stringByAppendingString:[textField_username.text lowercaseString]];
    NSString* passwordParameter = [[[Constants getPasswordParameter] stringByAppendingString:@"="] stringByAppendingString:textField_password.text];
    
    NSString* parameters = [[usernameParameter stringByAppendingString:@"&"] stringByAppendingString:passwordParameter];
    
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
    
    if ([status isEqualToString:[Constants getSuccessStatus]]) {
        [self saveUser:[dictionary objectForKey:[Constants getUserProperty]]];
        [Utilities saveTopUsers:[dictionary objectForKey:[Constants getTopUsersProperty]]];
        
        HomeViewController* homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:homeViewController animated:YES completion:nil];
    }
    
    if (isRegistering || [status isEqualToString:[Constants getFailingStatus]]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:status message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    printf("---------------------------------------\n");
    printf("Status: %s\n", [status UTF8String]);
    printf("Message: %s\n", [message UTF8String]);
}

-(void) saveUser: (NSDictionary*) user {
    NSString* username = textField_username.text;
    NSString* password = textField_password.text;
    NSString* name = [user objectForKey:[Constants getNameProperty]];
    int score = [[user objectForKey:[Constants getScoreProperty]] integerValue];
    NSString* imageURL = [user objectForKey:[Constants getImageURLProperty]];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:[Constants getUsernameKey]];
    [defaults setObject:password forKey:[Constants getPasswordKey]];
    [defaults setInteger:score forKey:[Constants getScoreKey]];
    
    if (name != nil) {
        [defaults setObject:name forKey:[Constants getNameKey]];
    } else {
        [defaults removeObjectForKey:[Constants getNameKey]];
    }
    
    if (imageURL != nil) {
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        UIImage* image = [UIImage imageWithData:data];
        
        [defaults setObject:UIImagePNGRepresentation(image) forKey:[Constants getImageKey]];
    } else {
        [defaults removeObjectForKey:[Constants getImageKey]];
    }
    
    [defaults synchronize];
    
    printf("---------------------------------------\n");
    printf("Name = %s\n", [name UTF8String]);
    printf("Score = %d\n", score);
    printf("Image URL = %s\n", [imageURL UTF8String]);
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
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wood_icon.jpg"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
//    
//    UIImage* image = [UIImage imageNamed:@"logo.png"];
//    [imageView setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
