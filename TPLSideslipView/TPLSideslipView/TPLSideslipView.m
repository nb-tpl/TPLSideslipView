//
//  TPLSideslipView.m
//  duoweiNews
//
//  Created by tiperTan_HGST_7200_1T on 2017/5/12.
//  Copyright © 2017年 tiperTan_HGST_7200_1T. All rights reserved.
//

#import "TPLSideslipView.h"
@interface TPLSideslipView ()

@property(nonatomic,weak)UIView * controlView;


@property(nonatomic,strong)UIView * coverView;

@property(nonatomic,strong)UIPanGestureRecognizer * pan;

@end


@implementation TPLSideslipView

#pragma mark --- property ---
- (void)setWidth:(CGFloat)width
{
    _width = width;
    self.frame = CGRectMake(-self.width, 0, self.width, self.controlView.frame.size.height);
}

- (UIPanGestureRecognizer *)pan
{
    if (_pan == nil) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    }
    return _pan;
}





#pragma mark --- view life ---
//初始化方法
- (TPLSideslipView *)initWithView:(UIView *)view
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        view.clipsToBounds = YES;
        self.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, view.frame.size.height);
        self.coverView = [[UIView alloc] initWithFrame:view.bounds];
        self.coverView.backgroundColor = [UIColor blackColor];
        self.coverView.alpha = 0;
        [view addSubview:self.coverView];
        [view addSubview:self];
        self.controlView = view;
        self.width = view.frame.size.width/2.0f;
        self.layer.shadowOffset = CGSizeMake(3, 3);
        self.layer.masksToBounds = NO;
        [self addGesture];
    }
    return self;
}

- (void)addGesture
{
    UITapGestureRecognizer * tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOn)];
    tapOne.numberOfTapsRequired = 1;
    [self.coverView addGestureRecognizer:tapOne];
}

#pragma mark --- Gesture ---
- (void)setUpGesture
{
    [self.controlView addGestureRecognizer:self.pan];
}

//卸载手势
- (void)uninstallGesture
{
    [self.controlView removeGestureRecognizer:self.pan];
}

#pragma mark --- event ---
- (void)tapOn
{
    if (self.isOpen) {
        [self close];
    }
}


-(void)pan:(UIPanGestureRecognizer *)recognizer{
   
    //触点移动的绝对距离
    static CGFloat self_beginX = 0;
    static CGFloat super_beginX = 0;
    //CGPoint location = [gr locationInView:self.view];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.layer.shadowOpacity = 0;
        //初始状态
        self_beginX = self.frame.origin.x;
        CGPoint translation = [recognizer translationInView:self.controlView];
        super_beginX = translation.x;
    }
    
    //移动
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.controlView];

        CGFloat temp = translation.x - super_beginX;
        CGFloat endX = self_beginX + temp;
        
        [self dealEndX:endX isMove:YES];
    }
    
    //检测最终状态
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:self.controlView];
        CGFloat temp = translation.x - super_beginX;
        CGFloat endX = self_beginX + temp;

        [self dealEndX:endX isMove:NO];

    }
}




#pragma mark --- animation ---
- (void)close
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(-self.frame.size.width,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
        self.coverView.alpha = 0;
    } completion:^(BOOL isFinish){
        self.layer.shadowOpacity = 0;
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        typeof(self) __weak weak_self = self;
        if (self.closeOrOpen) {
            self.closeOrOpen(weak_self);
        }
    }];
}
- (void)open
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.frame = CGRectMake(0,self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        self.coverView.alpha = 0.5;
    } completion:^(BOOL isFinish){
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        typeof(self) __weak weak_self = self;
        if (self.closeOrOpen) {
            self.closeOrOpen(weak_self);
        }
    }];

}

#pragma mark --- help ---

- (BOOL)isOpen
{
    if(self.frame.origin.x == 0)
    {
        return YES;
    }else {
        return NO;
    }
}


//调整
- (void)dealEndX:(CGFloat)endX isMove:(BOOL)isMove
{
    endX = endX > 0 ? 0 : endX;
    endX = endX < -self.width ? -self.width : endX;
    self.frame = CGRectMake(endX,self.frame.origin.y,self.frame.size.width, self.frame.size.height);
    
    
    self.coverView.alpha = (0.5 - (-endX/self.width)/2);
    //结束判断状态
    if (!isMove) {
        if(endX > -(self.width/2.0f))
        {
            [self open];
        }else {
            [self close];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
