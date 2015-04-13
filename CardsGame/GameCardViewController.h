#import <UIKit/UIKit.h>

@interface GameCardViewController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *Button1;
@property (strong, nonatomic) IBOutlet UISwitch* switch_sound;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButton;

@property (strong, nonatomic) IBOutlet UILabel *Timer;

@property (strong, nonatomic) IBOutlet UILabel *TextScore;
@property (strong, nonatomic) IBOutlet UILabel* label_highestScore;

- (IBAction)FlipCard:(UIButton *)sender;
-(UIImage *) drawRandomCard;
-(IBAction)changeSwitch:(id)sender;

-(IBAction)back:(id)sender;

@end
