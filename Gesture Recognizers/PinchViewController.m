//
//  PinchViewController.m
//  Gesture Recognizers
//
//  Created by Jeremi Kaczmarczyk on 01.05.2015.
//  Copyright (c) 2015 Jeremi Kaczmarczyk. All rights reserved.
//

#import "PinchViewController.h"

@interface PinchViewController ()

@property (strong, nonatomic) UIView *rectangle;
@property (assign, nonatomic) CGFloat pinchScale;
@property (assign, nonatomic) CGFloat rectScale;
@property (weak, nonatomic) IBOutlet UILabel *pinchMotivation;
@property (weak, nonatomic) IBOutlet UIButton *nextLevelButton;

@end

@implementation PinchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    [self.nextLevelButton setHidden:YES];
    [self.nextLevelButton setAlpha:0];
    [self.nextLevelButton.layer setCornerRadius:5];
    
    [self.pinchMotivation setHidden:YES];
    [self.pinchMotivation setText:@"Well done!"];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.rectScale = 100;
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    self.rectangle = [[UIView alloc] initWithFrame:rect];
    [self.rectangle setCenter:center];
    [self.rectangle setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.rectangle];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.rectangle addGestureRecognizer:pinchRecognizer];
}

- (void)handlePinch: (UIPinchGestureRecognizer *)pinchRecognizer {
    self.pinchScale = [pinchRecognizer scale];
    //[self.rectangle setTransform:CGAffineTransformMakeScale(self.pinchScale, self.pinchScale)];
    CGRect rect = CGRectMake(0, 0, self.rectScale*self.pinchScale, self.rectScale*self.pinchScale);
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.rectangle setFrame:rect];
    [self.rectangle setCenter:center];
    
    [UIView animateWithDuration:0.1 animations:^{
    if (pinchRecognizer.state == UIGestureRecognizerStateEnded){
        self.rectScale = self.rectScale * self.pinchScale;
    }}];
    if (self.rectScale >= 300){
        [self backroundChange];
    }

}

- (void)backroundChange {

    [self.rectangle setHidden:YES];
    [self.nextLevelButton setHidden:NO];

    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{[self.view setBackgroundColor:[UIColor whiteColor]];}
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5 animations:^{
                             [self.nextLevelButton setAlpha:1];
                             [self.pinchMotivation setHidden:NO];
                             [UIView animateWithDuration:0.5 animations:^{
                                 [self.pinchMotivation setTransform:CGAffineTransformMakeScale(2.5, 2.5)];
                             }];
                         }];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
