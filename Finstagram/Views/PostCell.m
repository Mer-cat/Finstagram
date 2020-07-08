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

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)refreshPost {
    // Set labels
    self.captionLabel.text = self.post.caption;
    self.usernameLabel.text = self.post.author.username;
    // Format date to show time since posting
    NSDate *timeCreated = self.post.createdAt;
    self.timeAgoLabel.text = [NSString stringWithFormat:@"%@ ago", timeCreated.shortTimeAgoSinceNow];

    // Set image
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
            [self.postImage setImage: placeholderImage];
        } else {
            [self.postImage setImage: [UIImage imageWithData:data]];
        }
    }];
     
}

@end
