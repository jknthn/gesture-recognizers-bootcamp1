//
//  PanViewController.m
//  Gesture Recognizers
//
//  Created by Jeremi Kaczmarczyk on 01.05.2015.
//  Copyright (c) 2015 Jeremi Kaczmarczyk. All rights reserved.
//

#import "PanViewController.h"

@interface PanViewController ()

@property (strong, nonatomic) UIView *rectangle;
@property (weak, nonatomic) IBOutlet UIButton *nextLevelButton;

@end

@implementation PanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    [self.nextLevelButton setHidden:YES];
    [self.nextLevelButton.layer setCornerRadius:5];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    self.rectangle = [[UIView alloc] initWithFrame:rect];
    [self.rectangle setCenter: center];
    [self.rectangle setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.rectangle];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.rectangle addGestureRecognizer:panRecognizer];
}

- (void)handlePan: (UIPanGestureRecognizer *)panRegognizer {
    CGPoint touchLocation = [panRegognizer locationInView:self.view];
    [UIView animateWithDuration:0.3 animations:^{
    [self.rectangle setCenter:touchLocation];
    }];
    
    if (self.rectangle.frame.origin.y <= 0){
        [self backgroundChange];
    }
}

- (void)backgroundChange {
    [UIView animateWithDuration:0.5 animations:^{
    [self.view setBackgroundColor:[UIColor blackColor]];}
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5 animations:^{ [self.nextLevelButton setHidden:NO]; }];
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
