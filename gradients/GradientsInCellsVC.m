//
//  ViewController.m
//  gradients
//
//  Created by Vladislav Dugnist on 3/10/17.
//  Copyright © 2017 vdugnist. All rights reserved.
//

#import "GradientsInCellsVC.h"
#import "CAGradientTableViewCell.h"
#import "CARasterizedGradientTableViewCell.h"
#import "ImageGradientTableViewCell.h"

static NSUInteger const kCellsCount = 100000;
static NSUInteger const kSegmentedControlHeight = 40;
static NSUInteger const kTableViewCellHeight = 40;

typedef NS_ENUM(NSUInteger, kTableViewType) {
    kTableViewTypeCAGradient,
    kTableViewTypeCAGradientRasterized,
    kTableViewTypeImageGradient,
};

@interface GradientsInCellsVC () <UITableViewDataSource>

@property (nonatomic, weak) UISegmentedControl *segmentedControl;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation GradientsInCellsVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"In cells";
    }
    
    return self;
}


- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat segmentedControlHeight = kSegmentedControlHeight;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"CAGradient", @"CAGradient rasterized", @"ImageGradient"]];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.frame = CGRectMake(0, statusBarHeight, view.frame.size.width, segmentedControlHeight);
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl = segmentedControl;
    [view addSubview:segmentedControl];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statusBarHeight + segmentedControlHeight, view.frame.size.width, view.frame.size.height - segmentedControlHeight - statusBarHeight)];
    tableView.dataSource = self;
    tableView.rowHeight = kTableViewCellHeight;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [tableView registerClass:[CAGradientTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CAGradientTableViewCell class])];
    [tableView registerClass:[CARasterizedGradientTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CARasterizedGradientTableViewCell class])];
    [tableView registerClass:[ImageGradientTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ImageGradientTableViewCell class])];
    [view addSubview:tableView];
    self.tableView = tableView;
    
    self.view = view;
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)control {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kCellsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cellClass = classForTableViewType(self.segmentedControl.selectedSegmentIndex);
    NSString *identifier = NSStringFromClass(cellClass);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

Class classForTableViewType(kTableViewType type) {
    switch (type) {
        case kTableViewTypeCAGradient: return [CAGradientTableViewCell class];
        case kTableViewTypeCAGradientRasterized: return [CARasterizedGradientTableViewCell class];
        case kTableViewTypeImageGradient: return [ImageGradientTableViewCell class];
    }
    
    assert(false);
    return nil;
}



@end
