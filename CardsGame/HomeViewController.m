#import "HomeViewController.h"
#import "Constants.h"
#import "RankingViewController.h"
#import "EditProfileViewController.h"
#import "LoginRegisterViewController.h"

@interface HomeViewController () {
    NSMutableData *responseData;
    NSMutableArray *theNames;
    NSMutableArray *theScores;
}

@end

@implementation HomeViewController

@synthesize imageView;

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
//    responseData = [[NSMutableData alloc]init];
//    theNames = [NSMutableArray array];
//    theScores = [NSMutableArray array];
//    NSURL *url = [[NSURL alloc ]initWithString:[Constants getTopUsersURL]];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    UIImage* image = [UIImage imageNamed:@"logo.png"];
    [imageView setImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startGame:(id)sender {
    
}

-(void)editProfile:(id)sender {
    EditProfileViewController* editProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
    [self presentViewController:editProfileViewController animated:YES completion:nil];
}

-(void)settings:(id)sender {
    
}

-(void)signOut:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:[Constants getUsernameKey]];
    [defaults removeObjectForKey:[Constants getPasswordKey]];
    [defaults removeObjectForKey:[Constants getNameKey]];
    [defaults removeObjectForKey:[Constants getScoreKey]];
    
    [defaults synchronize];
    
    LoginRegisterViewController* loginRegisterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegisterViewController"];
    [self presentViewController:loginRegisterViewController animated:YES completion:nil];
}

-(IBAction)showRanks:(id)sender{
    printf("Ranks\n");
//    NSURL *url = [[NSURL alloc ]initWithString:[Constants getTopUsersURL]];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString* newStr = [NSString stringWithUTF8String:[responseData bytes]];
    printf("%s\n",[newStr UTF8String]);
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    NSArray *topUsersArray = [parsedObject  objectForKey:@"Top Users"];
    
    for (int i = 0 ; i < [topUsersArray count]; i++) {
        NSDictionary *dictObject  = [topUsersArray objectAtIndex:i];
        [theNames addObject:[dictObject objectForKey:@"name"]];
        [theScores addObject:[NSString stringWithFormat:@"%@",[dictObject objectForKey:@"score"] ]];
       // printf("%s\n" , [[dictObject objectForKey:@"name"] UTF8String]);
       //printf("%s\n",[[NSString stringWithFormat:@"%@",[dictObject objectForKey:@"score"] ]UTF8String]);
   }

}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqualToString:@"ranksSegue"]) {
        
        RankingViewController *ranksView = segue.destinationViewController;
        
        ranksView.namesF = theNames;
        ranksView.scoresF = theScores;
    }
}

@end
