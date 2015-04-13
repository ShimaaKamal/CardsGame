#import "GameCardViewController.h"
#import "Card.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"
#import "Utilities.h"

static const int SCORE_MATCH_UNIT = 10000;
static const int SCORE_REDUCE_UNIT = 10;

@interface GameCardViewController ()

@end

@implementation GameCardViewController

@synthesize Button1;
@synthesize cardsButton;
@synthesize Timer;
@synthesize TextScore;
@synthesize label_highestScore;
@synthesize switch_sound;

BOOL soundEnabled;

NSMutableArray *Images;
NSMutableArray *listToShow;
NSMutableArray *CardArray;
UIButton *FirstButton;

int indexRequired;
int score;
int highestScore;
int numberOfMatches;
BOOL soundEnabled;
bool flag = YES;

SystemSoundID soundId;
NSTimer* timer;

int hours;
int minutes;
int seconds;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    indexRequired = 0;
    score = 0;
    numberOfMatches = 0;
    
    // Set sound
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    soundEnabled = [defaults boolForKey:[Constants getSoundEnabledKey]];
    [switch_sound setOn:soundEnabled];
    
    // Set background image
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wood_icon.jpg"]];
    backgroundImage.alpha = 0.75;
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    // Initialize array of images
    CardArray = [[NSMutableArray alloc] init];
    Images = [[NSMutableArray alloc] initWithObjects:@"pic1.png", @"pic2.png",@"pic3.png",@"pic4.png",@"pic5.png",@"pic6.png",@"pic7.png",@"pic8.png",@"pic1.png",@"pic2.png",@"pic3.png",@"pic4.png",@"pic5.png",@"pic6.png",@"pic7.png",@"pic8.png",nil];
    
    // Make buttons rounded
    for(UIButton *button in cardsButton ){
        button.layer.borderWidth = 0.8f;
        button.layer.borderColor =[ [UIColor grayColor]CGColor];
        button.layer.cornerRadius = 10;
        printf("%ld",(long)[button tag]);
    }
    // Initialize timer
    hours = 0;
    minutes = 0;
    seconds = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
    [Timer setText:@"00:00:00"];
    
    // Initialize Highest Score
    highestScore = [defaults integerForKey:[Constants getScoreKey]];
    label_highestScore.text = [NSString stringWithFormat:@"%d", highestScore];
    
    // Generate random images
    [self listFill];
}

-(void)viewDidDisappear:(BOOL)animated {
    [timer invalidate];
}

-(void)listFill{
    listToShow = [[NSMutableArray alloc] init];
    
    for(int i =0 ; i < 16;i++ ){
        [listToShow addObject:self.drawRandomCard];
    }
    for(int i =0; i<16;i++ ){
        Card *card = [[Card alloc] init];
        //printf("\n %s",[[listToShow objectAtIndex:index] UTF8String]);
        [card setImageName:[listToShow objectAtIndex:i]];
        [card setFaceUp:NO];
        [card setPlayble:YES];
        [CardArray addObject:card];
    }
    
    printf("list to show count = %lu",(unsigned long)listToShow.count);
}

-(NSString *) drawRandomCard{
    NSString *image = nil;
    /// printf("images count = %lu",(unsigned long)Images.count);
    unsigned index = arc4random() % Images.count;
    //printf("\n index = %lu",(unsigned long)index);
    if(Images.count){
        image =[Images objectAtIndex:index];
        [Images removeObjectAtIndex:index];
        //printf("\ninside draw");
        //printf("%s",[[Images objectAtIndex:index] UTF8String]);
    }
    //printf("inside draw");
    return image;
}

-(void) count {
    if (seconds == 59) {
        seconds = 0;
        if (minutes == 59) {
            minutes = 0;
            hours++;
        } else {
            minutes++;
        }
    } else {
        seconds++;
    }
    
    NSString* hoursString = [NSString stringWithFormat:@"%d", hours];
    if ([hoursString length] == 1) {
        hoursString = [@"0" stringByAppendingString:hoursString];
    }
    
    NSString* minutesString = [NSString stringWithFormat:@"%d", minutes];
    if ([minutesString length] == 1) {
        minutesString = [@"0" stringByAppendingString:minutesString];
    }
    
    NSString* secondsString = [NSString stringWithFormat:@"%d", seconds];
    if ([secondsString length] == 1) {
        secondsString = [@"0" stringByAppendingString:secondsString];
    }
    Timer.text = [[[[hoursString stringByAppendingString:@":"] stringByAppendingString:minutesString] stringByAppendingString:@":"] stringByAppendingString:secondsString];
}

- (IBAction)FlipCard:(UIButton *)sender {
    if(sender.isEnabled && flag == YES){
        if(soundEnabled){
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Button" ofType:@"mp3"];
            NSURL *soundUrl = [NSURL fileURLWithPath:path];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundUrl, &soundId);
            AudioServicesPlaySystemSound(soundId);
        }
        
        [UIView transitionWithView:sender duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{[sender setImage:[UIImage imageNamed:[listToShow objectAtIndex:[sender tag]]] forState:UIControlStateNormal];}   completion:nil];
        [[CardArray objectAtIndex:[sender tag]] setFaceUp:YES];
        
        //sound
        
        [self matchUp:sender];
    }
}

-(void) matchUp:(UIButton *) buttonPressed{
    int index = 0;
    
    for(Card *card in CardArray){
        //printf("\n %s",[[card imageName] UTF8String]);
        
        if(card.faceUp && card.playble && index != [buttonPressed tag]){
            printf("%s",[[[CardArray objectAtIndex:[buttonPressed tag]] imageName] UTF8String]);
            printf("%s",[[card imageName] UTF8String]);
            
            flag = NO;
            
            if([[card imageName] isEqualToString:[[CardArray objectAtIndex:[buttonPressed tag]] imageName]] ){
                //printf("hello from other world");
                [[CardArray objectAtIndex:[buttonPressed tag]] setPlayble:NO];
                [[CardArray objectAtIndex:index] setPlayble:NO];
                [buttonPressed setEnabled:NO];
                [[cardsButton objectAtIndex:index] setEnabled:NO];
                
                flag = YES;
                
                int timeInSeconds = hours * 60 * 60 + minutes * 60 + seconds;
                printf("time in second = %d",timeInSeconds);
                score = score + SCORE_MATCH_UNIT - SCORE_REDUCE_UNIT * timeInSeconds;
                NSString *ScoreValue = [[NSString alloc] initWithFormat:@"%d", score];
                
                printf("\n %s",[[[CardArray objectAtIndex:index] imageName] UTF8String]);
                [TextScore setText:ScoreValue];
                
                if (++numberOfMatches == 8) {
                    [self finish];
                }
            } else {
                [[CardArray objectAtIndex:[buttonPressed tag]] setFaceUp:NO];
                [[CardArray objectAtIndex:index] setFaceUp:NO];
                printf("\n inside else");
                printf("\n %s",[[[CardArray objectAtIndex:index] imageName] UTF8String]);
                
                indexRequired = index;
                FirstButton = buttonPressed ;
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(Rotate) userInfo:nil repeats:NO];
            }
        }
        index++;
    }
}

-(void)Rotate{
    [UIView transitionWithView:[cardsButton objectAtIndex:indexRequired] duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{[[cardsButton objectAtIndex:indexRequired] setImage:[UIImage imageNamed:@"green-globe-help-27263.jpg"] forState:UIControlStateNormal];}   completion:nil];
    
    [UIView transitionWithView:FirstButton  duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{[FirstButton setImage:[UIImage imageNamed:@"green-globe-help-27263.jpg"] forState:UIControlStateNormal];}   completion:nil];
    flag = YES;
}

-(void) finish {
    [timer invalidate];
    
    // If the current score is higher than the highest score, save this score in the user defaults
    printf("Score = %s\n", [[NSString stringWithFormat:@"%d", score] UTF8String]);
    printf("Highest Score = %s\n", [[NSString stringWithFormat:@"%d", highestScore] UTF8String]);
    if (score > highestScore) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:score forKey:[Constants getScoreKey]];
        
        NSString* username = [defaults stringForKey:[Constants getUsernameKey]];
        NSString* password = [defaults stringForKey:[Constants getPasswordKey]];
        
        NSString* usernameParameter = [[[Constants getusernameParameter] stringByAppendingString:@"="] stringByAppendingString:username];
        NSString* passwordParameter = [[[Constants getPasswordParameter] stringByAppendingString:@"="] stringByAppendingString:password];
        NSString* scoreParameter = [[[Constants getScoreParameter] stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%d", score]];
        
        NSString* parameters = [[[[usernameParameter stringByAppendingString:@"&"] stringByAppendingString:passwordParameter] stringByAppendingString:@"&"] stringByAppendingString:scoreParameter];
        
        parameters = [parameters stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        [Utilities sendRequest:[Constants getUpdateUserURL] :parameters :nil];
    }
    
    NSString* title = @"Share Score";
    NSString* message = @"7ot ya A7mady el dialog bta3 el share hena :D";
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Share", @"Cancel", nil];
    [alert show];
}

-(IBAction)changeSwitch:(id)sender{
    soundEnabled = [sender isOn];
    if(!soundEnabled){
        AudioServicesRemoveSystemSoundCompletion(soundId);
    } else {
        AudioServicesPlayAlertSound(soundId);
    }
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:soundEnabled forKey:[Constants getSoundEnabledKey]];
    [defaults synchronize];
}

-(void)back:(id)sender {
    NSString* title = @"Exit";
    NSString* message = @"Are you sure you want to exit";
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES", @"NO", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    flag = YES;
}

@end
