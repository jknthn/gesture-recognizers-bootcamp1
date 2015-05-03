//
//  TapViewController.m
//  Gesture Recognizers
//
//  Created by Jeremi Kaczmarczyk on 01.05.2015.
//  Copyright (c) 2015 Jeremi Kaczmarczyk. All rights reserved.
//

#import "TapViewController.h"

@interface TapViewController ()

@property (strong, nonatomic) UIView *rectangle;
@property (assign, nonatomic) NSInteger tapCount;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) NSArray *motivationLabelText;
@property (weak, nonatomic) IBOutlet UILabel *motivationLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextLevelButton;

@end

@implementation TapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    self.tapCount = 0;
    self.countLabel.text = @"5";
    
    self.motivationLabelText = @[@"Come on!", @"You can do it!", @"Few more to go!", @"You are very close!",@"One more to go!", @"I knew you can do this!"];
    self.motivationLabel.text = self.motivationLabelText[self.tapCount];
    
    [self.nextLevelButton.layer setCornerRadius:5];
    [self.nextLevelButton setHidden:YES];
    
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    self.rectangle = [[UIView alloc] initWithFrame:rect];
    [self.rectangle setCenter:center];
    [self.rectangle setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.rectangle];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.rectangle addGestureRecognizer:tapRecognizer];
}

- (void)handleTap: (UITapGestureRecognizer *)tapRecognizer {
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.rectangle setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
                     } completion:^(BOOL finished){
                         [self.rectangle setTransform:CGAffineTransformMakeScale(1, 1)];
                     }];
    
    
    NSInteger numberOfTaps = 5;
    self.tapCount++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(numberOfTaps - self.tapCount)];
    self.motivationLabel.text = self.motivationLabelText[self.tapCount];
    
    if ( (numberOfTaps - self.tapCount) == 0 ) {
        [self backgroundChange];
    }
}

- (void)backgroundChange {
    [self.rectangle setHidden:YES];
    [UIView animateWithDuration:0.4 animations:^{
        [self.view setBackgroundColor:[UIColor blackColor]];
        [self.motivationLabel setTextColor:[UIColor whiteColor]];
        [self.motivationLabel setTransform:CGAffineTransformMakeScale(1.8, 1.8)];
    } completion:^(BOOL finished){
        [self.nextLevelButton setHidden:NO];
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
