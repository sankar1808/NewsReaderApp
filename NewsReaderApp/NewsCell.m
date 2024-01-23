//
//  NewsCell.m
//  NewsReaderApp
//
//  Created by Sankaranarayana Settyvari on 23/01/24.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize newsView;
@synthesize newsTitle;
@synthesize newsdate;
@synthesize newsImage;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [newsView.layer setCornerRadius:10.0f];
//    newsView.layer.borderColor = [UIColor grayColor].CGColor;
//    newsView.layer.borderWidth = 1.0f;
//    [newsView.layer setMasksToBounds:YES];
//    [newsImage.layer setCornerRadius:10.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
