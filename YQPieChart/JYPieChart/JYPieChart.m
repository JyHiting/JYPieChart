//
//  JYPieChart.m
//  YQPieChart
//
//  Created by YunQue on 2017/9/4.
//  Copyright © 2017年 YunQue. All rights reserved.
//

#import "JYPieChart.h"
#import "UILabel+SizeToFit.h"

@interface SectorItem : NSObject

@property(nonatomic,assign)CGFloat itemRadius;
@property(nonatomic,assign)CGFloat startAngle;
@property(nonatomic,assign)CGFloat endAngle;
@property(nonatomic,weak)JYPieChartItem *currentClickedItem;

@end

@implementation SectorItem
@end

@interface JYPieChart()

@property(nonatomic,strong)NSMutableArray *sectorItemArr;
@property(nonatomic,strong)NSMutableArray *titlesRectArr;

@end

@implementation JYPieChart

-(instancetype)init{

    self = [super init];
    if (self) {
        
        [self setupDefaultConfiguration];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
      
        [self setupDefaultConfiguration];
    }
    return self;
}


-(void)setupDefaultConfiguration{

    self.backgroundColor = [UIColor whiteColor];
    _sectorItemArr = [NSMutableArray array];
    _titlesRectArr = [NSMutableArray array];
    

    _centerCircleRadius = 20;
    _centerCircleBgColor = [UIColor whiteColor];
    _centerTitleAttributesDic = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor darkTextColor]};
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    CGFloat selfWidth = CGRectGetWidth(rect);
    CGFloat selfHeight = CGRectGetHeight(rect);
    CGFloat minWidth = selfWidth > selfHeight ?selfHeight:selfWidth;
    CGFloat radius = (minWidth / 2) * 0.8;

    //逆时针绘图
    NSMutableArray *itemValueArr = [NSMutableArray array];
    [_valueArr enumerateObjectsUsingBlock:^(JYPieChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [itemValueArr addObject:@(obj.value)];
    }];
    
    CGFloat sumTotal = [[itemValueArr valueForKeyPath:@"@sum.floatValue"] floatValue];
//    CGFloat maxItemValue = [[itemValueArr valueForKeyPath:@"@max.floatValue"] floatValue];
//    CGFloat minItemValue = [[itemValueArr valueForKeyPath:@"@min.floatValue"] floatValue];    
    __block CGFloat stepSize = 0;
    if (sumTotal != 0.0) {
        [_valueArr enumerateObjectsUsingBlock:^(JYPieChartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JYPieChartItem *pieCharItem = [_valueArr objectAtIndex:idx];
            
            CGFloat itemRadius = 0;
            //绘制扇形
            CGContextSetLineWidth(ctx, 0);
            CGContextMoveToPoint(ctx, centerX, centerY);
            CGFloat piePercent = obj.value / sumTotal;
            itemRadius = radius * pieCharItem.radiusRate;
            
            CGContextAddArc(ctx, centerX, centerY, itemRadius,stepSize,stepSize + 2 * M_PI * piePercent, 0);
            SectorItem *sectorItem = [SectorItem new];
            sectorItem.itemRadius = itemRadius;
            sectorItem.startAngle = stepSize;
            sectorItem.endAngle = stepSize + 2 * M_PI * piePercent;
            sectorItem.currentClickedItem = [_valueArr objectAtIndex:idx];
            [_sectorItemArr addObject:sectorItem];
            
            CGContextSetFillColorWithColor(ctx, [_valueArr objectAtIndex:idx].sectorBgColor.CGColor);
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            
            //绘制折线
            CGPoint lineBeginPoint = CGPointMake(centerX + itemRadius *cosf(stepSize + 2 * M_PI * piePercent / 2), centerY + itemRadius *sinf(stepSize + 2 * M_PI * piePercent / 2));
            CGPoint lineMiddlePoint = CGPointMake(centerX + (itemRadius + pieCharItem.line1_lenght) *cosf(stepSize + 2 * M_PI * piePercent / 2), centerY + (itemRadius + pieCharItem.line1_lenght) *sinf(stepSize + 2 * M_PI * piePercent / 2));
            CGPoint lineEndPoint;
            CGRect titleRect;
            if (lineMiddlePoint.x > centerX) {
                
                //折线在中心轴右边
                lineEndPoint = CGPointMake(lineMiddlePoint.x + pieCharItem.line2_lenght, lineMiddlePoint.y);
                
                UILabel *title = [UILabel new];
                title.font = [UIFont systemFontOfSize:15];
                title.text = pieCharItem.name;
                CGFloat titleWidth = [title widthOfSizeToFit];
                CGFloat titleHeight = [title heightOfSizeToFitWith:titleWidth];
                titleRect = CGRectMake(lineEndPoint.x, lineEndPoint.y - titleHeight / 2, titleWidth, titleHeight);
            }else{
                
                //折线在中心轴左边
                lineEndPoint = CGPointMake(lineMiddlePoint.x - pieCharItem.line2_lenght, lineMiddlePoint.y);
                
                UILabel *title = [UILabel new];
                title.font = [UIFont systemFontOfSize:15];
                title.text = pieCharItem.name;
                CGFloat titleWidth = [title widthOfSizeToFit];
                CGFloat titleHeight = [title heightOfSizeToFitWith:titleWidth];
                titleRect = CGRectMake(lineEndPoint.x - titleWidth, lineEndPoint.y - titleHeight / 2, titleWidth, titleHeight);
            }
            
            [pieCharItem.line1BgColor setStroke];
            CGContextSetLineWidth(ctx, pieCharItem.line_width);
            CGContextMoveToPoint(ctx,lineBeginPoint.x,lineBeginPoint.y);
            CGContextAddLineToPoint(ctx,lineMiddlePoint.x,lineMiddlePoint.y);
            
            CGContextDrawPath(ctx, kCGPathStroke);
            [pieCharItem.line2BgColor setStroke];
            CGContextSetLineWidth(ctx, pieCharItem.line_width);
            CGContextMoveToPoint(ctx,lineMiddlePoint.x,lineMiddlePoint.y);
            CGContextAddLineToPoint(ctx,lineEndPoint.x,lineEndPoint.y);
            CGContextDrawPath(ctx, kCGPathStroke);
            
            //item标题
            [pieCharItem.name drawInRect:titleRect withAttributes:pieCharItem.itemTitleAttributesDic];
            [_titlesRectArr addObject:[NSValue valueWithCGRect:titleRect]];
            
            //是否展示中心圆
            CGContextSetLineWidth(ctx, 0);
            [_centerCircleBgColor setFill];
            if (_isShowCenterCircle) {
                
                switch (_pieChartType) {
                    case PieChartTypeNormal:{
                        
                        //普通饼状图
                        if (_centerCircleRadius >= radius * pieCharItem.radiusRate) {
                            
                            CGContextAddArc(ctx, centerX, centerY, radius - 10, 0, 2 *M_PI, 0);
                            
                        }else{
                            
                            CGContextAddArc(ctx, centerX, centerY, _centerCircleRadius, 0, 2 *M_PI, 0);
                        }
                    }
                        break;
                    case PieChartTypeNightingale:{
                        
                        //南丁格尔饼状图
                        if (_centerCircleRadius >= radius * pieCharItem.radiusRate) {
                            
                            CGContextAddArc(ctx, centerX, centerY, radius * pieCharItem.radiusRate - 10, 0, 2 *M_PI, 0);
                            
                        }else{
                            
                            CGContextAddArc(ctx, centerX, centerY, _centerCircleRadius, 0, 2 *M_PI, 0);
                        }
                    }
                        break;
                    default:
                        break;
                }
                
                CGContextDrawPath(ctx, kCGPathFill);
                CGSize textSize = [self.centerCircleTitle sizeWithAttributes:self.centerTitleAttributesDic];
                [self.centerCircleTitle drawInRect:CGRectMake(centerX - textSize.width / 2, centerY - textSize.height / 2, textSize.width, textSize.height) withAttributes:self.centerTitleAttributesDic];
                
            }
            
            stepSize += 2 * M_PI * piePercent;
            
        }];
    }
}

-(void)setCenterTitleAttributesDic:(NSDictionary *)centerTitleAttributesDic{
    
    _centerTitleAttributesDic = centerTitleAttributesDic;
    [self setNeedsDisplay];
}

-(void)setCenterCircleTitle:(NSString *)centerCircleTitle{
    
    _centerCircleTitle = centerCircleTitle;
    [self setNeedsDisplay];
}

-(void)setCenterCircleRadius:(CGFloat)centerCircleRadius{

    _centerCircleRadius = centerCircleRadius;
    [self setNeedsDisplay];
}

-(void)setIsShowCenterCircle:(BOOL)isShowCenterCircle{

    _isShowCenterCircle = isShowCenterCircle;
    [self setNeedsDisplay];
}

-(void)setValueArr:(NSArray *)valueArr{

    _valueArr = valueArr;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    [_titlesRectArr enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectContainsPoint([obj CGRectValue], location)) {
            
            if (self.itemTitleClick) {
               
                self.itemTitleClick([_valueArr objectAtIndex:idx]);
            }
        }
    }];
    //计算触摸点到中心点距离
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    CGFloat toCenterDistance = sqrt(pow((location.x - centerX), 2) + pow((location.y - centerY), 2));
    NSMutableArray *maybeClickedRegion = [NSMutableArray array];
    [_sectorItemArr enumerateObjectsUsingBlock:^(SectorItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (toCenterDistance <= obj.itemRadius) {
            [maybeClickedRegion addObject:obj];
        }
    }];
    //计算触摸点和中心点连线的角度
    CGFloat rads = acos((location.x - centerX) / toCenterDistance);
    if (location.y < centerY) {
        
        rads = 2 * M_PI - rads;
    }
    [maybeClickedRegion enumerateObjectsUsingBlock:^(SectorItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (rads >= obj.startAngle && rads < obj.endAngle) {
            //所点击的扇形
            if (self.sectorClick) {
              
                self.sectorClick(obj.currentClickedItem);
            }
        }
    }];
    
}
@end
