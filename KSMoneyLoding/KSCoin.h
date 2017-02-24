//
//  KSCoin.h
//  KSMoneyLoding
//
//  Created by 康帅 on 17/2/23.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,KSCoinDirection) {
    KSCoinDirectionToRight=1,
    KSCoinDirectionToLeft=-1
};
@interface KSCoin : UIView
@property(nonatomic,strong)NSString *cointitle;
@property(nonatomic,strong)UIColor *cointitlecolor;
@property(nonatomic,strong)UIColor *coinbackcolor;
@property(nonatomic,assign)KSCoinDirection direction;
@end
