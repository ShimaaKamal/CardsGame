#import "EditProfileViewController.h"
#import "Constants.h"
#import "Utilities.h"
#import "User.h"

UIImage* selectedImage;
NSString* response;

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

@synthesize imageView, textField_name;

-(void)changeImage:(id)sender {
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePickerController animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [imageView setImage:image];
    selectedImage = image;
}

-(void)save:(id)sender {
    [Utilities sendRequest:[Constants getUpdateUserURL] :[self addParameters] :self];
    response = @"";
}

-(void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)addParameters {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [defaults stringForKey:[Constants getUsernameKey]];
    NSString* password = [defaults stringForKey:[Constants getPasswordKey]];
    
    NSString* usernameParameter = [[[Constants getusernameParameter] stringByAppendingString:@"="] stringByAppendingString:username];
    NSString* passwordParameter = [[[Constants getPasswordParameter] stringByAppendingString:@"="] stringByAppendingString:password];
    NSString* nameParameter = [[[Constants getNameParameter] stringByAppendingString:@"="] stringByAppendingString:textField_name.text];
    
    //    NSString* score = [NSString stringWithFormat:@"%d", [defaults integerForKey:[Constants getScoreKey]]];
    //    NSString* scoreParameter = [[[Constants getScoreParameter] stringByAppendingString:@"="] stringByAppendingString:score];
    
    NSString* parameters = [[[[usernameParameter stringByAppendingString:@"&"] stringByAppendingString:passwordParameter] stringByAppendingString:@"&"] stringByAppendingString:nameParameter];
    
    parameters = [parameters stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    if (selectedImage != nil) {
        int width = selectedImage.size.width;
        //    int height = image.size.height;
        
        CGImageRef imageRef = selectedImage.CGImage;
        NSData* data = (NSData*) CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(imageRef)));
        int length = [data length];
        char* bytes = (char*) [data bytes];
        
        NSMutableString* imageString = [NSMutableString new];
        for (int i = 0; i < length; i+= 4) {
            NSString* byte = [NSString stringWithFormat:@"%X", (unsigned char) bytes[i + 3]];
            if ([byte length] == 1) {
                byte = [@"0" stringByAppendingString:byte];
            }
            [imageString appendString:byte];
            
            for (int j = 0; j < 3; j++) {
                byte = [NSString stringWithFormat:@"%X", (unsigned char) bytes[i + j]];
                if ([byte length] == 1) {
                    byte = [@"0" stringByAppendingString:byte];
                }
                [imageString appendString:byte];
            }
            if (i != length - 4) {
                [imageString appendString:@" "];
            }
        }
        
        NSString* imageWidthParameter = [[[Constants getImageWidthParameter] stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%d", width]];
        
        NSString* imageParameter = [[[Constants getImageParameter] stringByAppendingString:@"="] stringByAppendingString:imageString];
        
        parameters = [[[[parameters stringByAppendingString:@"&"] stringByAppendingString:imageWidthParameter] stringByAppendingString:@"&"] stringByAppendingString:imageParameter];
    }
    
    return parameters;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSString* status = [dictionary objectForKey:[Constants getStatusProperty]];
    NSString* message = [dictionary objectForKey:[Constants getMessageProperty]];
    
    if ([status isEqualToString:[Constants getSuccessStatus]]) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:textField_name.text forKey:[Constants getNameKey]];
        if (selectedImage != nil) {
            [defaults setObject:UIImagePNGRepresentation(selectedImage) forKey:[Constants getImageKey]];
        }
        
        [defaults synchronize];
    }
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:status message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
    if ([status isEqualToString:[Constants getSuccessStatus]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* name = [defaults stringForKey:[Constants getNameKey]];
    
    textField_name.text = name;
    
    NSData* imageData = [defaults objectForKey:[Constants getImageKey]];
    selectedImage = [UIImage imageWithData:imageData];
    if (selectedImage != nil) {
        [imageView setImage:selectedImage];
    } else {
        UIImage* image = [UIImage imageNamed:@"default.jpg"];
        [imageView setImage:image];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
