//
//  ViewController.h
//  NewsReaderApp
//
//  Created by Sankaranarayana Settyvari on 23/01/24.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsCell.h"
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *newsDisplayTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchNews;
@property (strong, nonatomic) IBOutlet NSMutableArray *newsListArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *searchNewsListArray;
@property (nonatomic, retain) News *news;

@end

