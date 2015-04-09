#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch* switch_sound;

-(IBAction)ok:(id)sender;
-(IBAction)cancel:(id)sender;

@end
