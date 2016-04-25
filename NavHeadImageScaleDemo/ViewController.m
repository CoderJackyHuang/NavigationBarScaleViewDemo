//
//  ViewController.m
//  NavHeadImageScaleDemo
//
//  Created by huangyibiao on 16/4/25.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *headerImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:tableView];
  tableView.dataSource = self;
  tableView.delegate = self;
  [tableView registerClass:[UITableViewCell class]
    forCellReuseIdentifier:@"UITableViewCell"];
  
  UIView *titleView = [[UIView alloc] init];
  self.navigationItem.titleView = titleView;

  self.headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head.jpg"]];
  self.headerImageView.layer.cornerRadius = 35;
  self.headerImageView.layer.masksToBounds = YES;
  self.headerImageView.frame = CGRectMake(0, 0, 70, 70);
  self.headerImageView.center = CGPointMake(titleView.center.x, 0);
  [titleView addSubview:self.headerImageView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
  
  CGFloat scale = 1.0;
  // 放大
  if (offsetY < 0) {
    // 允许下拉放大的最大距离为300
    // 1.5是放大的最大倍数，当达到最大时，大小为：1.5 * 70 = 105
    // 这个值可以自由调整
    scale = MIN(1.5, 1 - offsetY / 300);
  } else if (offsetY > 0) { // 缩小
    // 允许向上超过导航条缩小的最大距离为300
    // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
    // 头像最小是31.5像素
    scale = MAX(0.45, 1 - offsetY / 300);
  }
  
  self.headerImageView.transform = CGAffineTransformMakeScale(scale, scale);

  // 保证缩放后y坐标不变
  CGRect frame = self.headerImageView.frame;
  frame.origin.y = -self.headerImageView.layer.cornerRadius / 2;
  self.headerImageView.frame = frame;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
  
  cell.textLabel.text = [NSString stringWithFormat:@"标哥出品：如何在导航条缩放头像"];
  
  return cell;
}

@end
