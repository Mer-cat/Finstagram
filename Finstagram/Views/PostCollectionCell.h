//
//  PostCollectionCell.h
//  Finstagram
//
//  Created by Mercy Bickell on 7/9/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionCell : UICollectionViewCell

- (void)refreshPost:(Post*) post;

@end

NS_ASSUME_NONNULL_END
