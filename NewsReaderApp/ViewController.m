//
//  ViewController.m
//  NewsReaderApp
//
//  Created by Sankaranarayana Settyvari on 23/01/24.
//

#import "ViewController.h"
#import "News.h"

@interface ViewController () 


@end

@implementation ViewController
@synthesize  newsListArray;
@synthesize  newsDisplayTableView;
@synthesize searchNews;
@synthesize searchNewsListArray;
@synthesize  news;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    newsListArray = [[NSMutableArray alloc] init];
    searchNewsListArray = [[NSMutableArray alloc] init];
    [self doSomethingWithTheJson];
    newsDisplayTableView.delegate = self;
    newsDisplayTableView.dataSource = self;
    
}

#pragma mark - UITableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseId = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.section,(long)indexPath.row];
    NewsCell *cell = (NewsCell *)[newsDisplayTableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    
    News *news = [newsListArray objectAtIndex:indexPath.row];
    cell.newsTitle.text =  news.title;
    cell.newsdate.text = news.date;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.imageURL]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.newsImage.image = [UIImage imageWithData: data];
        });
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"title of cell %@", [newsListArray objectAtIndex:indexPath.row]);
}


- (void)doSomethingWithTheJson
{
    NSDictionary *dict = [self JSONFromFile];
    
    NSArray *articles = [dict objectForKey:@"articles"];
    
    for (NSDictionary *article in articles) {
        NSString *title = [article objectForKey:@"title"];
        NSString *date = [article objectForKey:@"publishedAt"];
        NSString *imageURL = [article objectForKey:@"urlToImage"];
        News *news = [[News alloc]init];
        news.title = title;
        news.date = date;
        news.imageURL = imageURL;
        [newsListArray addObject:news];
        [searchNewsListArray addObject:news];
        
    }
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                               ascending:YES];
    NSArray *sortedArray = [newsListArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    newsListArray = [sortedArray mutableCopy];
}

// The return value is either NSArray * or NSDictionary *
- (id)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"json"];

    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}




#pragma mark - SearchBar Delegate Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
  @try
  {
    [newsListArray removeAllObjects];
    NSString *title = @"";
    if ([searchText length] > 0)
    {
        for (int i = 0; i < [searchNewsListArray count] ; i++)
        {
            News *news = [searchNewsListArray objectAtIndex:i];
            title = news.title;
            if (title.length >= searchText.length)
            {
                NSRange titleResultsRange = [title rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResultsRange.length > 0)
                {
                    [newsListArray addObject:[searchNewsListArray objectAtIndex:i]];
                }
            }
        }
    }
    else
    {
        [newsListArray addObjectsFromArray:searchNewsListArray];
    }
    [newsDisplayTableView reloadData];
}
@catch (NSException *exception) {
}
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)SearchBar
{
  SearchBar.showsCancelButton=YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar
{
  [theSearchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)SearchBar
{
  @try
  {
    SearchBar.showsCancelButton=NO;
    [SearchBar resignFirstResponder];
    [newsDisplayTableView reloadData];
  }
  @catch (NSException *exception) {
  }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)SearchBar
{
  [SearchBar resignFirstResponder];
}


#pragma mark - Memory warning methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [newsListArray removeAllObjects];
    [searchNewsListArray removeAllObjects];
}
@end
