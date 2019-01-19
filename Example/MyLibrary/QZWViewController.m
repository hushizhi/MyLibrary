//
//  QZWViewController.m
//  MyLibrary
//
//  Created by hushizhi on 01/18/2019.
//  Copyright (c) 2019 hushizhi. All rights reserved.
//

/// Masonry 和 布局优先级约束
/// https://www.jianshu.com/p/63e9765feb3f
/// https://github.com/lichory/Hug-Compress/blob/master/Hug%E5%92%8CCompress/Hug%E5%92%8CCompress/ViewController.m
///

#import "QZWViewController.h"
#import <Masonry/Masonry.h>

@interface QZWViewController ()

@property (nonatomic) UILabel *label1;
@property (nonatomic) UILabel *label2;

@end

@implementation QZWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUIByTestTheMasonry];
    [self contentHuggingByTestTheMasonry];
    [self contentCompressionResistanceByTestTheMasonry];
    NSLog(@"viewDidLoad时间");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear时间");
}

- (void)initUIByTestTheMasonry
{
    self.label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label1.backgroundColor = [UIColor redColor];
    self.label1.text = @"我是标题你好";
    [self.view addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(@(12));
        /// 最少为多少
        make.width.greaterThanOrEqualTo(@(170));
        /// 多少为多少
//        make.width.lessThanOrEqualTo(@(170));
    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.backgroundColor = [UIColor redColor];
    label2.text = @"我是描述我是描述我是描述我是描述";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label1);
        make.left.equalTo(self.label1.mas_right).offset(8);
        make.right.equalTo(self.view).offset(-12);
    }];
    self.label2 = label2;
}

/*
 * intrinsicContentSize: 这个是label 的真实的 大小size
 * 抗拉伸 和 抗压缩 都是相对于intrinsicContentSize 值来说的
 * 用法1：取值：self.photoCountLabel.intrinsicContentSize.width；
 * 用法2：方法：
    - (CGSize)intrinsicContentSize
    {
        return CGSizeMake(SCREEN_WIDTH, 67);
    }
 **/

// 抗拉伸
/* 适用场景
 * eg: label1 label2 设置约束限制后，‘还有’空余空间，这个时候就需要决定拉伸谁，才能满足我们的限制
 * setContentHuggingPriority（数值范围：1000-0，值越大，越不容易被拉伸，所以取名“抗拉伸”）
 **/
- (void)contentHuggingByTestTheMasonry
{
    [self.label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.label2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

// 抗压缩
/* 适用场景
 * eg: label1 label2 设置约束限制后，‘没有’空余空间了，此时就只能压缩其中某一个label，才能满足我们的限制
 * setContentCompressionResistancePriority（数值范围：1000-0，值越大，越不容易被压缩，所以取名“抗压缩”）
 **/
- (void)contentCompressionResistanceByTestTheMasonry
{
    [self.label1 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

/*
    那如果label1和lebel2非常长呢，不管设置谁的优先级，其中一个都会被挤没了怎么办？
    make.width.greaterThanOrEqualTo 可以设置宽度‘最少’为多少
    make.width.lessThanOrEqualTo    可以设置宽度‘最多’为多少
 **/


@end
