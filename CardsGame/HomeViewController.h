#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UIImageView* imageView;

-(IBAction)startGame:(id)sender;
-(IBAction)editProfile:(id)sender;
-(IBAction)settings:(id)sender;
-(IBAction)showRanks:(id)sender;
-(IBAction)signOut:(id)sender;

@end
