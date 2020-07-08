//
//  PostCell.h
//  Finstagram
//
//  Created by Mercy Bickell on 7/7/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (nonatomic, strong) Post *post;

- (void)refreshPost;

@end

NS_ASSUME_NONNULL_END
