//
//  ViewController.m
//  SnipperView
//
//  Created by Lin Dong on 1/25/15.
//  Copyright (c) 2015 Lin Dong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer *LDBackgroundLayer;
@property (nonatomic, strong) CALayer *LDBlackScreenLayer;
@property (nonatomic, strong) UIView  *LDMaskView;
@property (nonatomic, strong) UILabel *countDownLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  

//  [self performSelector:@selector(makeMaskLayerClear) withObject:nil afterDelay:2.f];
  
//  [self.view.layer addSublayer:self.maskLayer];
//  [self.view.layer addSublayer:_blackScreenLayer];

//  [self.view addSubview:self.countDownLabel];
//  NSTimer *timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
  
  [self gameBegin];
  NSLog(@"");
}

-(void) gameBegin {
  UIImage *wallImage = [UIImage imageNamed:@"wall.jpg"];
  self.LDBackgroundLayer = [CALayer layer];
  self.LDBackgroundLayer.contents = (__bridge id)wallImage.CGImage;
  self.LDBackgroundLayer.frame = CGRectMake(0,0,
                                            [[UIScreen mainScreen] bounds].size.width,
                                            [[UIScreen mainScreen] bounds].size.height);
  
  self.LDBlackScreenLayer = [CALayer layer];
  self.LDBlackScreenLayer.frame = CGRectMake(0,0,
                                             [[UIScreen mainScreen] bounds].size.width,
                                             [[UIScreen mainScreen] bounds].size.height);
  self.LDBlackScreenLayer.backgroundColor = [UIColor blackColor].CGColor;
  self.LDBlackScreenLayer.opacity = 1.f;
  
  [self.view.layer addSublayer:self.LDBackgroundLayer];
  self.LDBackgroundLayer.mask = self.LDBlackScreenLayer;
  
//  [self countDown];
  [self showMask];
}

-(void) countDown {
  [self countDownLabel];
}

-(void) showMask{
  UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
  [self.LDMaskView addGestureRecognizer:singleFingerTap];
  
  [self.view addSubview:self.LDMaskView];
}

-(void) handleSingleTap{
  NSLog(@"====handleSingleTap");
}

-(void) makeMaskLayerClear{
  CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  maskAnimation.fromValue = @(self.LDBackgroundLayer.mask.opacity);
  maskAnimation.toValue =  @0;
  maskAnimation.duration = 1.f;
  [self.LDBackgroundLayer addAnimation:maskAnimation forKey:@"maskAnimation"];

}

-(void) makeBackgroundGone{
  CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"zPosition"];
  contentsAnimation.fromValue = @(self.LDBackgroundLayer.zPosition);
  contentsAnimation.toValue =  @(0);
  contentsAnimation.duration = 1.f;
  _LDBackgroundLayer.zPosition = 10;
}

-(void) makeBackgroundAppear{
  CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"zPosition"];
  contentsAnimation.fromValue = @(self.LDBackgroundLayer.zPosition);
  contentsAnimation.toValue =  @(10);
  contentsAnimation.duration = 1.f;
  _LDBackgroundLayer.zPosition = 10;
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"===== touchesMoved CALLED");
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint location = [touch locationInView:touch.view];
  [self updateMaskLocation:location];
  self.LDMaskView.backgroundColor = [UIColor blackColor];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"===== touchesEnded CALLED");
  UITouch *touch = [[event allTouches] anyObject];
  CGPoint location = [touch locationInView:touch.view];
  [self updateMaskLocation:location];
    self.LDMaskView.backgroundColor = [UIColor blueColor];
}


-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
  NSLog(@"===== touchesCancelled CALLED");
//  UITouch *touch = [[event allTouches] anyObject];
//  CGPoint location = [touch locationInView:touch.view];
//  [self updateMaskLocation:location];
//  [super touchesCancelled:touches withEvent:event];
  self.LDMaskView.backgroundColor = [UIColor redColor];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [[event allTouches] anyObject];
  NSUInteger tapCount = [touch tapCount];
  
  
  NSLog(@"===== touchesBegan CALLED with %ld taps", tapCount);
  
  CGPoint location = [touch locationInView:touch.view];
  switch (tapCount) {
    case 1:
//        [self updateMaskLocation:location];
      [self performSelector:@selector(updateMaskLocationWithNSValue:) withObject:[NSValue valueWithCGPoint:location] afterDelay:0];
        self.LDMaskView.backgroundColor = [UIColor greenColor];
      
      //      [self performSelector:@selector(updateMaskLocation:) withObject:[NSValue valueWithCGPoint:location] afterDelay:.4];
      break;
    case 2:
//      [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateMaskLocation) object:nil];
//      [self performSelector:@selector(updateMaskLocation) withObject:nil afterDelay:.4];
//      [self performSelector:@selector(doubleTapMethod) withObject:nil afterDelay:.4];
      break;
    default:
      break;
  }
}

-(void) updateMaskLocationWithNSValue: (NSValue*) val {
  CGPoint location = [val CGPointValue];
  NSLog(@"Locaiton x: %f y: %f", location.x, location.y);
  self.LDMaskView.center = location;
}

-(void) updateMaskLocation: (CGPoint) location {
  NSLog(@"Locaiton x: %f y: %f", location.x, location.y);
  self.LDMaskView.center = location;
}

-(UIView*) LDMaskView {
  if(!_LDMaskView){
    _LDMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _LDMaskView.backgroundColor = [UIColor blackColor];
    _LDMaskView.layer.cornerRadius = 25;
    
    // assistants
    _LDMaskView.layer.borderColor = [UIColor redColor].CGColor;
    _LDMaskView.layer.borderWidth = 1.0f;
  }
  return _LDMaskView;
}

-(UILabel*) countDownLabel {
  if(!_countDownLabel){
    _countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                      [[UIScreen mainScreen] bounds].size.width/2-50,
                      [[UIScreen mainScreen] bounds].size.height/2-50,
                                                                100,
                                                                100)];
    _countDownLabel.backgroundColor = [UIColor blackColor];
    _countDownLabel.textAlignment =  NSTextAlignmentCenter;
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(100.0)];
    _countDownLabel.text = @"3";
//    [_countDownLabel sizeToFit];
  }
  return _countDownLabel;
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden { return YES; }


@end
