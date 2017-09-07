//
//  PieChartItem.h
//  YQPieChart
//
//  Created by YunQue on 2017/9/5.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYPieChartItem : NSObject

@property(nonatomic,assign)double value;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)UIColor *sectorBgColor;
//折线的宽度
@property(nonatomic,assign)CGFloat line_width;
//折线第一段的长度
@property(nonatomic,assign)CGFloat line1_lenght;
//折线第一段的背景色
@property(nonatomic,strong)UIColor *line1BgColor;
//折线第二段的长度
@property(nonatomic,assign)CGFloat line2_lenght;
//折线第二段的背景色
@property(nonatomic,strong)UIColor *line2BgColor;
//每一项数据展示标题的样式
@property(nonatomic,strong)NSDictionary *itemTitleAttributesDic;
@end
