//
//  ImageGradientTableViewCell.m
//  gradients
//
//  Created by Vladislav Dugnist on 3/10/17.
//  Copyright © 2017 vdugnist. All rights reserved.
//

#import "ImageGradientTableViewCell.h"

@implementation ImageGradientTableViewCell {
    __weak UIImageView *_gradientImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self redrawGradient];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self redrawGradient];
}

- (void)redrawGradient {
    [_gradientImageView removeFromSuperview];
    
    UIImageView *gradientImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gradient"]];
    gradientImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:gradientImageView];
    _gradientImageView = gradientImageView;    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _gradientImageView.frame = _gradientImageView.superview.bounds;
}

@end
