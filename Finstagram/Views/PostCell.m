//
//  PostCell.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/7/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "PostCell.h"
#import <Parse/Parse.h>
#import "DateTools.h"

/**
 * Custom table view cell for a post
 */
@interface PostCell ()
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation PostCell

#pragma mark - Init

- (void)refreshPost:(Post *)post {
    // Set labels
    self.captionLabel.text = post.caption;
    self.usernameLabel.text = post.author.username;
    // Format date to show time since posting
    NSDate *timeCreated = post.createdAt;
    self.timeAgoLabel.text = [NSString stringWithFormat:@"%@ ago", timeCreated.shortTimeAgoSinceNow];
    
    // Set post image
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.postImage setImage: placeholderImage];
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            [self.postImage setImage: [UIImage imageWithData:data]];
        }
    }];
    
    // Set profile image
    [self.profileImage setImage: placeholderImage];
    [post.author[@"profileImage"] getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            [self.profileImage setImage: [UIImage imageWithData:data]];
        }
    }];
}

@end
