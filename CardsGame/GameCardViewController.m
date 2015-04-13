//
//  GameCardViewController.m
//  CardsGame
//
//  Created by JETS on 4/4/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "GameCardViewController.h"
#import "Card.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"


@interface GameCardViewController ()

@end

@implementation GameCardViewController

@synthesize Button1;
@synthesize cardsButton;
@synthesize Timer;
@synthesize TextScore;
@synthesize switch_sound;

BOOL soundEnabled;

NSMutableArray *Images;
NSMutableArray *listToShow;
NSMutableArray *CardArray;
UIButton *FirstButton;
int indexRequired;
int score = 0;
BOOL soundEnabled;
SystemSoundID soundId;

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

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //make userdefault
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    soundEnabled = [defaults boolForKey:[Constants getSoundEnabledKey]];
    [switch_sound setOn:soundEnabled];
    
    //set background image
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wood_icon.jpg"]];
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    
    //initialize array of images
    CardArray = [[NSMutableArray alloc] init];
    Images = [[NSMutableArray alloc] initWithObjects:@"pic1.png", @"pic2.png",@"pic3.png",@"pic4.png",@"pic5.png",@"pic6.png",@"pic7.png",@"pic8.png",@"pic1.png",@"pic2.png",@"pic3.png",@"pic4.png",@"pic5.png",@"pic6.png",@"pic7.png",@"pic8.png",nil];
    
    //make buttons rounded
    for(UIButton *button in cardsButton ){
        button.layer.borderWidth = 0.8f;
        button.layer.borderColor =[ [UIColor grayColor]CGColor];
        button.layer.cornerRadius = 10;
        printf("%ld",(long)[button tag]);
    }
    //initialize timer
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
    [Timer setText:@"00:00:00"];
    
    //generate random images
    [self listFill];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if(sender.isEnabled){
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
            if([[card imageName] isEqualToString:[[CardArray objectAtIndex:[buttonPressed tag]] imageName]] ){
                //printf("hello from other world");
                [[CardArray objectAtIndex:[buttonPressed tag]] setPlayble:NO];
                [[CardArray objectAtIndex:index] setPlayble:NO];
                [buttonPressed setEnabled:NO];
                [[cardsButton objectAtIndex:index] setEnabled:NO];
                int timeInSeconds = hours * 60 *60 + minutes * 60+ seconds;
                printf("time in second = %d",timeInSeconds);
                score = (score + 100) ;
                NSString *ScoreValue = [[NSString alloc] initWithFormat:@"%d",score - (score / timeInSeconds) ];
                
                printf("\n %s",[[[CardArray objectAtIndex:index] imageName] UTF8String]);
                [TextScore setText:ScoreValue];
            } else {
                [[CardArray objectAtIndex:[buttonPressed tag]] setFaceUp:NO];
                [[CardArray objectAtIndex:index] setFaceUp:NO];
                printf("\n inside else");
                printf("\n %s",[[[CardArray objectAtIndex:index] imageName] UTF8String]);
                
                indexRequired = index;
                FirstButton = buttonPressed ;
                [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(Rotate)
                                               userInfo:nil
                                                repeats:NO];
            }
        }
        index++;
    }
}

-(void)Rotate{
    [UIView transitionWithView:[cardsButton objectAtIndex:indexRequired] duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{[[cardsButton objectAtIndex:indexRequired] setImage:[UIImage imageNamed:@"Help.png"] forState:UIControlStateNormal];}   completion:nil];
    
    [UIView transitionWithView:FirstButton  duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{[FirstButton setImage:[UIImage imageNamed:@"Help.png"] forState:UIControlStateNormal];}   completion:nil];
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

@end
