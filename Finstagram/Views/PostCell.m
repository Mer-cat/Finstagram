//
//  PostCell.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/7/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshPost {
    // Set labels and images
    self.captionLabel = self.post[@"caption"];
    NSURL *imageURL = self.post[@"imageURL"];
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.postImage setImageWithURL:imageURL placeholderImage:placeholderImage];
}

@end
