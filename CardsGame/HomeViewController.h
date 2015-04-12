#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UIImageView* imageView;

-(IBAction)signOut:(id)sender;

@end
