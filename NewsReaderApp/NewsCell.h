//
//  NewsCell.h
//  NewsReaderApp
//
//  Created by Sankaranarayana Settyvari on 23/01/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsdate;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

@end

NS_ASSUME_NONNULL_END
