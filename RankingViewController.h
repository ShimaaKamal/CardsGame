#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView* table;

@property (strong , nonatomic) NSArray *names;
@property (strong , nonatomic) NSArray *scores;
@property (strong , nonatomic) NSArray *namesF;
@property (strong , nonatomic) NSArray *scoresF;

-(IBAction)updateList:(id)sender;
-(IBAction)done:(id)sender;

@end
