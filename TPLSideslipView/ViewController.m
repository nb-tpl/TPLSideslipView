//
//  ViewController.m
//  TPLSideslipView
//
//  Created by tiperTan_HGST_7200_1T on 2017/12/10.
//  Copyright © 2017年 tiperTan_HGST_7200_1T. All rights reserved.
//

#import "ViewController.h"

#import "TPLSideslipView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height/2.0f)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [self addSlideslipViewToView:topView width:topView.frame.size.width/2.0f];
    
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height +20, self.view.bounds.size.width,self.view.bounds.size.height/2.0f - 20)];
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];
    [self addSlideslipViewToView:bottomView width:(bottomView.bounds.size.width/5.0f)*4];

    
}


- (void)addSlideslipViewToView:(UIView *)view width:(CGFloat)width
{
    TPLSideslipView * sideslipView = [[TPLSideslipView alloc] initWithView:view];
    sideslipView.backgroundColor = [UIColor greenColor];
    sideslipView.width = width;
    [sideslipView setUpGesture];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
