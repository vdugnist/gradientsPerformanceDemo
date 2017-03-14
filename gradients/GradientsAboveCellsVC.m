//
//  GradientsAboveCellsVC.m
//  gradients
//
//  Created by Vladislav Dugnist on 3/14/17.
//  Copyright © 2017 vdugnist. All rights reserved.
//

#import "GradientsAboveCellsVC.h"

static NSUInteger const kCellsCount = 100000;
static NSUInteger const kSegmentedControlHeight = 40;
static NSUInteger const kTableViewCellHeight = 40;

typedef NS_ENUM(NSUInteger, kGradientType) {
    kGradientTypeCAGradient,
    kGradientTypeCAGradientRasterized,
    kGradientTypeImageGradient,
};

@interface GradientsAboveCellsVC () <UITableViewDataSource>

@property (nonatomic, weak) UIView *caGradientView;
@property (nonatomic, weak) UIView *caGradientRasterizedView;
@property (nonatomic, weak) UIView *imageGradientView;

@end

@implementation GradientsAboveCellsVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Above cells";
    }
    
    return self;
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat segmentedControlHeight = kSegmentedControlHeight;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"CAGradient", @"CAGradient rasterized", @"ImageGradient"]];
    segmentedControl.frame = CGRectMake(0, statusBarHeight, view.frame.size.width, segmentedControlHeight);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:segmentedControl];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight + segmentedControlHeight, view.frame.size.width, view.frame.size.height - segmentedControlHeight - statusBarHeight)];
    tableView.dataSource = self;
    tableView.rowHeight = kTableViewCellHeight;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [view addSubview:tableView];
    
    UIView *caGradientView = [[UIView alloc] initWithFrame:tableView.frame];
    caGradientView.userInteractionEnabled = NO;
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame = caGradientView.bounds;
    gradientLayer.colors = @[ (id)[UIColor clearColor].CGColor, (id)[UIColor redColor].CGColor ];
    [caGradientView.layer addSublayer:gradientLayer];
    [view addSubview:caGradientView];
    self.caGradientView = caGradientView;
    
    UIView *caRasterizedGradientView = [[UIView alloc] initWithFrame:tableView.frame];
    caRasterizedGradientView.userInteractionEnabled = NO;
    CAGradientLayer *rasterizedGradientLayer = [CAGradientLayer new];
    rasterizedGradientLayer.frame = caRasterizedGradientView.bounds;
    rasterizedGradientLayer.colors = @[ (id)[UIColor clearColor].CGColor, (id)[UIColor greenColor].CGColor ];
    rasterizedGradientLayer.shouldRasterize = YES;
    rasterizedGradientLayer.rasterizationScale = [UIScreen mainScreen].scale;
    [caRasterizedGradientView.layer addSublayer:rasterizedGradientLayer];
    [view addSubview:caRasterizedGradientView];
    self.caGradientRasterizedView = caRasterizedGradientView;
    
    UIImageView *imageGradientView = [[UIImageView alloc] initWithFrame:tableView.frame];
    imageGradientView.image = [UIImage imageNamed:@"gradient"];
    [view addSubview:imageGradientView];
    self.imageGradientView = imageGradientView;
    
    self.view = view;
    [self segmentedControlValueChanged:segmentedControl];
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)control {
    self.caGradientView.hidden = control.selectedSegmentIndex != kGradientTypeCAGradient;
    self.caGradientRasterizedView.hidden = control.selectedSegmentIndex != kGradientTypeCAGradientRasterized;
    self.imageGradientView.hidden = control.selectedSegmentIndex != kGradientTypeImageGradient;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kCellsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

@end
