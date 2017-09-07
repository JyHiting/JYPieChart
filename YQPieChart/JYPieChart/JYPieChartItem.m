//
//  PieChartItem.m
//  YQPieChart
//
//  Created by YunQue on 2017/9/5.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import "JYPieChartItem.h"

@implementation JYPieChartItem

-(instancetype)init{

    if (self = [super init]) {
        
        _line1_lenght = 10;
        _line2_lenght = 15;
        _line_width = 0.5;
        _line1BgColor = [UIColor darkTextColor];
        _line2BgColor = [UIColor darkTextColor];
        _itemTitleAttributesDic = [NSDictionary dictionaryWithObjects:@[[UIFont systemFontOfSize:13],[UIColor lightGrayColor]] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]];
    }
    return self;
}
    
@end
