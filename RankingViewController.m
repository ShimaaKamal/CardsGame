#import "RankingViewController.h"
#import "Constants.h"
#import "Utilities.h"
#import "User.h"

NSMutableArray* users;
NSString* response;
UIImage* defaultImage;

@interface RankingViewController ()

@end

@implementation RankingViewController
@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wood_icon.jpg"]];
//    [self.view addSubview:backgroundImage];
//    [self.view sendSubviewToBack:backgroundImage];
    
    [backgroundImage setFrame:table.frame];
    table.backgroundView = backgroundImage;
    
    defaultImage = [UIImage imageNamed:@"default.jpg"];
    
    [self refreshTable];
}

-(void) refreshTable {
    NSString* filePath = [@"/Users/participant/Desktop/CardsGame" stringByAppendingPathComponent:@"Users.plist"];
    NSData* archivedData = [NSData dataWithContentsOfFile:filePath];
    
    users = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    
    [table reloadData];
    
    for (User* user in users) {
        printf("-----------------------------------------\n");
        [user printData];
    }
}

-(void)updateList:(id)sender {
    NSURL* url = [NSURL URLWithString:[Constants getTopUsersURL]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
    response = @"";
}

-(void)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return @"Top Ten";

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    User* user = [users objectAtIndex:indexPath.row];
    NSString* score = [NSString stringWithFormat:@"%d", user.score];
    NSString* name = user.name;
    UIImage* image = user.image;
    
    if (name == nil) {
        name = user.username;
    }
    
    if (image == nil) {
        image = defaultImage;
    }
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = score;
    cell.imageView.image = image;
    
    return cell;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    response = [response stringByAppendingString:dataString];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [Utilities saveTopUsers:[dictionary objectForKey:[Constants getTopUsersProperty]]];
    [self refreshTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
