#import <UIKit/UIKit.h>

@interface LoginRegisterViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UIImageView* imageView;

@property (strong, nonatomic) IBOutlet UITextField* textField_username;
@property (strong, nonatomic) IBOutlet UITextField* textField_password;

@property (strong, nonatomic) IBOutlet UILabel* label_usernameErrors;
@property (strong, nonatomic) IBOutlet UILabel* label_passwordErrors;

-(IBAction)login:(id)sender;
-(IBAction)register:(id)sender;

@end
