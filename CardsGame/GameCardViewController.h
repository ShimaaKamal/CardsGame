#import <UIKit/UIKit.h>

@interface GameCardViewController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *Button1;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButton;

@property (strong, nonatomic) IBOutlet UILabel *Timer;

@property (strong, nonatomic) IBOutlet UILabel *TextScore;
@property (strong, nonatomic) IBOutlet UILabel* label_highestScore;

@property (strong, nonatomic) IBOutlet UIButton* button_sound;

- (IBAction)FlipCard:(UIButton *)sender;
-(UIImage *) drawRandomCard;

-(IBAction)soundToggled:(id)sender;
-(IBAction)back:(id)sender;

@end
