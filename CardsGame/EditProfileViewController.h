#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView* imageView;
@property (strong, nonatomic) IBOutlet UITextField* textField_name;

-(IBAction)changeImage:(id)sender;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

@end
