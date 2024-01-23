//
//  News.h
//  NewsReaderApp
//
//  Created by Sankaranarayana Settyvari on 23/01/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *date;
@property(nonatomic, retain) NSString *imageURL;

@end



NS_ASSUME_NONNULL_END
