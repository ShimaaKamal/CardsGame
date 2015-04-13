#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView* table;

-(IBAction)updateList:(id)sender;
-(IBAction)done:(id)sender;

@end
