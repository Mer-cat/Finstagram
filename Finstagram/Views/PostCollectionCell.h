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
@property (nonatomic, strong) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;

- (void)refreshPost;

@end

NS_ASSUME_NONNULL_END
