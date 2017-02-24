//
//  KSMoneyLoding.m
//  KSMoneyLoding
//
//  Created by 康帅 on 17/2/23.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "KSMoneyLoding.h"
#import "KSCoin.h"

#define KSSpeed self.bounds.size.width/60.0f

@interface KSMoneyLoding()
@property(nonatomic,strong)NSMutableArray *coins;
@property(nonatomic,strong)CADisplayLink *displaylink;
@end
@implementation KSMoneyLoding
/*
 ** 构造方法
 */
-(instancetype)init{
    self=[super init];
    if (self) {
        [self commonInit];
        [self InitState];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self InitState];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        [self InitState];
    }
    return self;
}
/*
 ** 初始化参数
 */
-(void)commonInit{
    _coins=[NSMutableArray array];
    NSArray *coinBackGroundColors = @[[self R:255 G:218 B:134 A:1],[self R:245 G:229 B:216 A:1]];
    NSArray *textColors = @[[self R:255 G:197 B:44 A:1],[self R:237 G:215 B:199 A:1]];
    
    for (int roop=0; roop<textColors.count; roop++) {
        //靠左靠右各放置一枚硬币
        CGFloat coinX = roop==0?0:self.bounds.size.width-[self coinWidth];
        KSCoinDirection direction = roop==0?KSCoinDirectionToRight:KSCoinDirectionToLeft;
        KSCoin *coin=[[KSCoin alloc]initWithFrame:CGRectMake(coinX, 0, [self coinWidth], [self coinWidth])];
        coin.center=CGPointMake(coin.center.x, self.bounds.size.height/2.0f);
        coin.layer.cornerRadius=coin.bounds.size.width/2;
        coin.coinbackcolor=coinBackGroundColors[roop];
        coin.cointitlecolor=textColors[roop];
        coin.cointitle=@"发";
        coin.direction=direction;
        [self addSubview:coin];
        [_coins addObject:coin];
    }
    
    
}
-(void)InitState{
    /*
     ** 按帧为单位刷新
     */
    _displaylink=[CADisplayLink displayLinkWithTarget:self selector:@selector(refreshPosition)];
}

/*
 ** 按帧为单位刷新硬币位置
 */
-(void)refreshPosition{
    //取出硬币
    KSCoin *coin1=[_coins firstObject];
    KSCoin *coin2=[_coins lastObject];
    
    //移动到最右边
    if (coin1.center.x>=self.bounds.size.width-[self coinWidth]/2.0f) {
        CGPoint center=coin1.center;
        center.x=self.bounds.size.width-[self coinWidth]/2.0f;
        coin1.center=center;
        coin1.direction=KSCoinDirectionToLeft;
        coin2.direction=KSCoinDirectionToRight;
        [self bringSubviewToFront:coin1];
    }
    
    //移动到最左边
    if (coin1.center.x<=[self coinWidth]/2.0f) {
        coin1.center=CGPointMake([self coinWidth]/2.0f, coin2.center.y);
        coin1.direction=KSCoinDirectionToRight;
        coin2.direction=KSCoinDirectionToLeft;
        [self sendSubviewToBack:coin1];
    }
    
    //刷新位置
    CGPoint center1=coin1.center;
    center1.x+=coin1.direction*KSSpeed;
    coin1.center=center1;
    //改变放大效果
    [self refreshAnimation:coin1];
    
    //计算第二枚硬币的相对位置
    CGFloat relativeTocoin1=coin1.center.x-self.bounds.size.width/2.0f;
    CGPoint center2=coin2.center;
    center2.x=self.bounds.size.width/2.0f-relativeTocoin1;
    coin2.center=center2;
    [self refreshAnimation:coin2];
}

/*
 ** 刷新动画效果（形变）
 */
-(void)refreshAnimation:(KSCoin *)coin{
    //当前移动的距离
    CGFloat currentDistance=coin.center.x-self.bounds.size.width/2.0f;
    //最大允许移动距离
    CGFloat maxDistance=(self.bounds.size.width-[self coinWidth])/2.0f;
    //当前移动占最大距离的比例
    CGFloat proportionScale=currentDistance/maxDistance;
    //根据比例获取对应状态的Y值
    CGFloat cosinY=cos(proportionScale*M_PI/2.0);
    
    if (coin.direction==KSCoinDirectionToRight) {
        coin.transform=CGAffineTransformMakeScale(1-cosinY/4.0f, 1-cosinY/4.0f);
    }else if (coin.direction==KSCoinDirectionToLeft){
        coin.transform=CGAffineTransformMakeScale(1+cosinY/4.0f, 1+cosinY/4.0f);
    }
}

/*
 ** 计算每一颗硬币的宽度
 */
-(CGFloat)coinWidth{
    CGFloat margin = self.bounds.size.width/5.0f;
    CGFloat coinWidth = (self.bounds.size.width - margin)/2.0f;
    return  coinWidth;
}

#pragma tools
-(UIColor*)R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+(KSMoneyLoding *)loadingInView:(UIView *)view{
    KSMoneyLoding *loading=nil;
    for (KSMoneyLoding *subview in view.subviews) {
        if ([subview isKindOfClass:[KSMoneyLoding class]]) {
            loading=subview;
        }
    }
    return loading;
}
+(void)showLodingInView:(UIView *)view{
    KSMoneyLoding *loding=[[KSMoneyLoding alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    loding.center=view.center;
    [view addSubview:loding];
    [loding show];
}
+(void)hideLodingInView:(UIView *)view{
    KSMoneyLoding *loading=[KSMoneyLoding loadingInView:view];
    if (loading) {
        [loading removeFromSuperview];
        [loading hide];
    }
}
-(void)show
{
    [_displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)hide
{
    [_displaylink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
@end
