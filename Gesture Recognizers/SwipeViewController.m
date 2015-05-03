//
//  SwipeViewController.m
//  Gesture Recognizers
//
//  Created by Jeremi Kaczmarczyk on 01.05.2015.
//  Copyright (c) 2015 Jeremi Kaczmarczyk. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@property (strong,nonatomic) UIView *rectangle;
@property (strong,nonatomic) UIView *rectangle2;
@property (weak, nonatomic) IBOutlet UIButton *nextLevelButton;
@property (nonatomic, assign) bool rightCompleted;
@property (nonatomic, assign) bool leftCompleted;

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.leftCompleted = NO;
    self.rightCompleted = NO;
    
    [self.nextLevelButton setHidden:YES];
    [self.nextLevelButton.layer setCornerRadius:5];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGPoint left = CGPointMake(0, self.view.bounds.size.height/2);
    CGPoint right = CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height/2);
    
    self.rectangle = [[UIView alloc] initWithFrame:rect];
    [self.rectangle setBackgroundColor:[UIColor whiteColor]];
    [self.rectangle setCenter:left];
    [self.view addSubview:self.rectangle];
    
    self.rectangle2 = [[UIView alloc] initWithFrame:rect];
    [self.rectangle2 setBackgroundColor:[UIColor whiteColor]];
    [self.rectangle2 setCenter:right];
    [self.view addSubview:self.rectangle2];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    [rightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.rectangle addGestureRecognizer:rightRecognizer];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    [leftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.rectangle2 addGestureRecognizer:leftRecognizer];
}

- (void)setBackground {
    [UIView animateWithDuration:1 animations:^{
        [self.view setBackgroundColor:[UIColor whiteColor]];
    } completion:^(BOOL finished){
        [self.nextLevelButton setHidden:NO];
    }];
}

- (void)handleSwipeRight: (UISwipeGestureRecognizer *)rightRecognizer {
    if (UISwipeGestureRecognizerDirectionRight){
        CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        CGPoint right = CGPointMake(self.view.bounds.size.width - self.view.bounds.size.width/4, self.view.bounds.size.height/2);
        
        [UIView animateWithDuration:0.2
                              delay:0.05
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                                     [self.rectangle setCenter:right];
                         }completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 [self.rectangle setCenter:center];
                                 self.rightCompleted = YES;
                                 if (self.rightCompleted && self.leftCompleted){
                                     [self setBackground];
                                 }
                             }];
                         }];
    }
}

- (void)handleSwipeLeft: (UISwipeGestureRecognizer *)leftRecognizer {
    if (UISwipeGestureRecognizerDirectionLeft){
        CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        CGPoint left = CGPointMake(self.view.bounds.size.width/4, self.view.bounds.size.height/2);
        
        [UIView animateWithDuration:0.2
                              delay:0.05
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.rectangle2 setCenter:left];
                         }completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 [self.rectangle2 setCenter:center];
                                 self.leftCompleted = YES;
                                 if (self.rightCompleted && self.leftCompleted){
                                     [self setBackground];
                                 }
                             }];
                         }];
    }
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
