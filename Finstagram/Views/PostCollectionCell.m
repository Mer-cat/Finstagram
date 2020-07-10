//
//  PostCollectionCell.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/9/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "PostCollectionCell.h"

/**
* Custom collection view cell for a post
*/
@interface PostCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@end

@implementation PostCollectionCell

#pragma mark - Init

- (void)refreshPost:(Post*) post {
    // Set image
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.postImage setImage: placeholderImage];
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            [self.postImage setImage: [UIImage imageWithData:data]];
        }
    }];
}

@end
