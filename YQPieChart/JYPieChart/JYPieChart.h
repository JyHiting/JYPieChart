//
//  JYPieChart.h
//  YQPieChart
//
//  Created by YunQue on 2017/9/4.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYPieChartItem.h"


typedef NS_ENUM(NSInteger,PieChartType){

    PieChartTypeNormal,//普通饼状图
    PieChartTypeNightingale//南丁格尔图
};


@interface JYPieChart : UIView

@property(nonatomic,assign)PieChartType pieChartType;

//是否展示中心圆
@property(nonatomic,assign)BOOL isShowCenterCircle;
//中心圆展示文档(在isShowCenterCircle为true的情况下有效)
@property(nonatomic,copy)NSString *centerCircleTitle;
//中心圆文档字体样式
@property(nonatomic,strong)NSDictionary *centerTitleAttributesDic;
//中心圆的半径
@property(nonatomic,assign)CGFloat centerCircleRadius;
//中心圆的背景色
@property(nonatomic,strong)UIColor *centerCircleBgColor;
//饼状图数据
@property(nonatomic,strong)NSArray<JYPieChartItem *> *valueArr;

//每一项标题点击事件
@property(nonatomic,copy)void(^itemTitleClick)(JYPieChartItem *pieChartItem);
//每一个扇形点击触发的事件
@property(nonatomic,copy)void(^sectorClick)(JYPieChartItem *pieChartItem);

@end
