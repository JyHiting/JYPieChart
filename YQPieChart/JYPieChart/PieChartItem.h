//
//  PieChartItem.h
//  YQPieChart
//
//  Created by YunQue on 2017/9/5.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PieChartItem : NSObject

@property(nonatomic,assign)double value;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)UIColor *sectorBgColor;

@end
