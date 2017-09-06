//
//  JYPieChart.h
//  YQPieChart
//
//  Created by YunQue on 2017/9/4.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartItem.h"


typedef NS_ENUM(NSInteger,PieChartType){

    PieChartTypeNormal,//普通饼状图
    PieChartTypeNightingale//南丁格尔图
};


@interface JYPieChart : UIView

@property(nonatomic,assign)PieChartType pieChartType;

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
//是否展示中心圆
@property(nonatomic,assign)BOOL isShowCenterCircle;
//中心圆的半径
@property(nonatomic,assign)CGFloat centerCircleRadius;
//中心圆的背景色
@property(nonatomic,strong)UIColor *centerCircleBgColor;
//饼状图数据
@property(nonatomic,strong)NSArray<PieChartItem *> *valueArr;
//每一项数据展示标题的样式
@property(nonatomic,strong)NSDictionary *itemTitleAttributesDic;
//每一项标题点击事件
@property(nonatomic,copy)void(^itemTitleClick)(PieChartItem *pieChartItem);
//每一个扇形点击触发的事件
@property(nonatomic,copy)void(^sectorClick)(PieChartItem *pieChartItem);


@end
