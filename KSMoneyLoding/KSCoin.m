//
//  KSCoin.m
//  KSMoneyLoding
//
//  Created by 康帅 on 17/2/23.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "KSCoin.h"
@interface KSCoin()
@property(nonatomic,strong)UILabel *title;
@end
@implementation KSCoin
/*
 ** 构造方法
 */
-(instancetype)init{
    self=[super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}
/*
 ** 初始化参数
 */
-(void)commonInit{
    self.backgroundColor=[UIColor whiteColor];
    self.clipsToBounds=YES;
    
    _title=[[UILabel alloc]initWithFrame:self.bounds];
    _title.adjustsFontSizeToFitWidth=YES;
    _title.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_title];
}

-(void)setCoinbackcolor:(UIColor *)coinbackcolor{
    _title.backgroundColor=coinbackcolor;
}
-(void)setCointitlecolor:(UIColor *)cointitlecolor{
    _title.textColor=cointitlecolor;
}
-(void)setCointitle:(NSString *)cointitle{
    _title.text=cointitle;
}
@end
