//
//  TPLSideslipView.h
//  duoweiNews
//
//  Created by tiperTan_HGST_7200_1T on 2017/5/12.
//  Copyright © 2017年 tiperTan_HGST_7200_1T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPLSideslipView : UIControl
//侧滑内容空间宽度
@property(nonatomic,assign)CGFloat width;


//打开和关闭回调
@property(nonatomic,copy)void (^closeOrOpen)(TPLSideslipView * sideslipView);




//初始化方法
- (TPLSideslipView *)initWithView:(UIView *)view;


//装载手势
- (void)setUpGesture;
//卸载手势
- (void)uninstallGesture;



//关闭
- (void)close;
//开启
- (void)open;

- (BOOL)isOpen;

@end
