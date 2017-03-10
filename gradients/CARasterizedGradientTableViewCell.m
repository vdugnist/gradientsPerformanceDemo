//
//  CARasterizedGradientTableViewCell.m
//  gradients
//
//  Created by Vladislav Dugnist on 3/14/17.
//  Copyright © 2017 vdugnist. All rights reserved.
//

#import "CARasterizedGradientTableViewCell.h"

@implementation CARasterizedGradientTableViewCell {
    __weak CAGradientLayer *_gradientLayer;
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
    [_gradientLayer removeFromSuperlayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[ (id)[UIColor clearColor].CGColor, (id)[UIColor greenColor].CGColor ];
    gradientLayer.shouldRasterize = YES;
    gradientLayer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.contentView.layer addSublayer:gradientLayer];
    _gradientLayer = gradientLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _gradientLayer.frame = _gradientLayer.superlayer.bounds;
}

@end
