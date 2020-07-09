//
//  PostCollectionCell.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/9/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "PostCollectionCell.h"

@implementation PostCollectionCell

- (void)refreshPost {
    // Set image
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.postImage setImage: placeholderImage];
    [self.post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            [self.postImage setImage: [UIImage imageWithData:data]];
        }
    }];
}

@end
