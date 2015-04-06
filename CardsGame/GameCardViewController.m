//
//  GameCardViewController.m
//  CardsGame
//
//  Created by JETS on 4/4/15.
//  Copyright (c) 2015 JETS. All rights reserved.
//

#import "GameCardViewController.h"
#import "Card.h"

@interface GameCardViewController ()

@end

@implementation GameCardViewController

@synthesize Button1;
@synthesize cardsButton;
NSMutableArray *Images;
NSMutableArray *listToShow;
NSMutableArray *CardArray;

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
    CardArray = [[NSMutableArray alloc] init];
    Images = [[NSMutableArray alloc] initWithObjects:@"pic1.png", @"pic2.png",@"pic3.png",@"pic4.png",@"pic5.png",@"pic6.png",@"pic7.png",@"pic8.png",@"pic1.png",@"pic2.png",@"pic3.png",@"pic4.png",@"pic5.png",@"pic6.png",@"pic7.png",@"pic8.png",nil];
    
    
    for(UIButton *button in cardsButton ){
        button.layer.borderWidth = 0.9f;
        button.layer.borderColor =[ [UIColor grayColor]CGColor];
        button.layer.cornerRadius = 10;
        printf("%ld",(long)[button tag]);
    }
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FlipCard:(UIButton *)sender {
    
    if(sender.isEnabled){
        [UIView transitionWithView:sender duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{[sender setImage:[UIImage imageNamed:[listToShow objectAtIndex:[sender tag]]] forState:UIControlStateNormal];}   completion:nil];
        [[CardArray objectAtIndex:[sender tag]] setFaceUp:YES];
        //[self performSelector:@selector(matchUp:) withObject:sender afterDelay:3.0];
        [self matchUp:sender];
        
    }
    //    [UIView transitionWithView:sender duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:nil
    //                    completion:nil];
    
    
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
                printf("\n %s",[[[CardArray objectAtIndex:index] imageName] UTF8String]);
            }
            else{
                
                [[CardArray objectAtIndex:[buttonPressed tag]] setFaceUp:NO];
                [[CardArray objectAtIndex:index] setFaceUp:NO];
                printf("\n inside else");
                printf("\n %s",[[[CardArray objectAtIndex:index] imageName] UTF8String]);
                
                //[NSThread sleepForTimeInterval:1.06];
                [buttonPressed setImage:[UIImage imageNamed:@"Help_mark_query_question_support_talk-128.png"] forState:UIControlStateNormal];
                printf("\n index = %d", index);
                
                [UIView transitionWithView:[cardsButton objectAtIndex:index] duration:0.5 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{[[cardsButton objectAtIndex:index] setImage:[UIImage imageNamed:@"Help_mark_query_question_support_talk-128.png"] forState:UIControlStateNormal];}   completion:nil];
                
                
                //
            }
        }
        
        index++;
    }
}


@end
