//
//  ViewController.m
//  YQPieChart
//
//  Created by YunQue on 2017/9/4.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import "ViewController.h"
#import "JYPieChart.h"

#import <Masonry.h>
#import "JYPieChartItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JYPieChart *pieChart1 = [JYPieChart new];
    pieChart1.backgroundColor = [UIColor yellowColor];
    pieChart1.itemTitleClick = ^(JYPieChartItem *pieChartItem) {
      
        NSLog(@"标题点击____________%@",pieChartItem);
    };
    pieChart1.sectorClick = ^(JYPieChartItem *pieChartItem) {
       
        NSLog(@"扇形区域点击____________%@",pieChartItem);
    };
    pieChart1.isShowCenterCircle = YES;
    pieChart1.centerCircleTitle = @"80%";
    pieChart1.pieChartType = PieChartTypeAnnulus;
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int index = 0; index < 5; index ++) {
        
        JYPieChartItem *item = [JYPieChartItem new];
        item.value = 100 + index * 5;
        item.annulus_width = 10 + 10 * index;
        item.name = [NSString stringWithFormat:@"测试%d",index];
        item.sectorBgColor = [self randomColor];
        [itemArr addObject:item];
    }
    pieChart1.valueArr = itemArr;
    [self.view addSubview:pieChart1];
    
    [pieChart1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    
    
    JYPieChart *pieChart2 = [JYPieChart new];
    pieChart2.backgroundColor = [UIColor redColor];
    NSMutableArray *itemArr2 = [NSMutableArray array];
    for (int index = 0; index < 5; index ++) {
        
        JYPieChartItem *item = [JYPieChartItem new];
        item.value = 100 + index * 5;
        item.name = [NSString stringWithFormat:@"测试%d",index];
        item.sectorBgColor = [self randomColor];
        item.radiusRate = 0.5 + 0.1 * index;
        [itemArr2 addObject:item];
    }
    pieChart2.valueArr = itemArr2;
    [self.view addSubview:pieChart2];
    
    [pieChart2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(pieChart1.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
}

-(UIColor*)randomColor{
    CGFloat hue = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
