//
//  ViewController.m
//  MyDynamicDemo
//
//  Created by ljf on 16/5/16.
//  Copyright © 2016年 hanwang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIDynamicAnimator *dynamicAnimator;
    
//    UIDynamicBehavior *dynamicBehavior;//动力学行为 父类
    UIGravityBehavior *gravityBehavior;
    UICollisionBehavior *collosionBehavior;
    UISnapBehavior *snapBehavior;//甩行为
    UIAttachmentBehavior *attachmentBehavior;//附着行为

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIView *testview = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 20, 100, 100)];
    testview.backgroundColor = [UIColor redColor];
    [self.view addSubview:testview];
    
    UIView *testview2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 200, 100, 20)];
    testview2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testview2];
    
    UIView *testview3 = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-30, 300, 60, 60)];
    testview3.layer.cornerRadius = 30;
    testview3.layer.masksToBounds = YES;
    testview3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testview3];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[testview,testview2]];
    gravityBehavior.magnitude = 0.1;
    [dynamicAnimator addBehavior:gravityBehavior];
    
    snapBehavior = [[UISnapBehavior alloc] initWithItem:testview3 snapToPoint:CGPointMake(self.view.bounds.size.width/2, 330)];
    snapBehavior.damping = 0.6;
    [dynamicAnimator addBehavior:snapBehavior];
    
    collosionBehavior = [[UICollisionBehavior alloc] initWithItems:@[testview,testview2,testview3]];
    [collosionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
    [dynamicAnimator addBehavior:collosionBehavior];
    
    attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:testview2 attachedToItem:testview3];
    attachmentBehavior.damping = 0.5;
    attachmentBehavior.length = 120;
    attachmentBehavior.frequency = 5;
    [dynamicAnimator addBehavior:attachmentBehavior];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    snapBehavior.snapPoint = point;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    snapBehavior.snapPoint = point;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
