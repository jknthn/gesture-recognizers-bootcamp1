//
//  RotationViewController.m
//  Gesture Recognizers
//
//  Created by Jeremi Kaczmarczyk on 01.05.2015.
//  Copyright (c) 2015 Jeremi Kaczmarczyk. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()

@property (strong, nonatomic) UIView *rectangle;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;

@end

@implementation RotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    self.rectangle = [[UIView alloc] initWithFrame:rect];
    [self.rectangle setCenter:center];
    [self.rectangle setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.rectangle];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.rectangle addGestureRecognizer:rotationRecognizer];
}

- (void)handleRotation: (UIRotationGestureRecognizer *)rotationRecognizer {
    CGFloat rotation = [rotationRecognizer rotation];
    [self.rectangle setTransform:CGAffineTransformMakeRotation(rotation)];
    if (rotation > 2) {
        [self youWin];
    }
}

- (void)youWin{
    CGRect rect = CGRectMake(0, 0, 300, 300);
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    UIImage *image = [UIImage imageNamed:@"Well-Played-Meme.jpg"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    [imageView setImage:image];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setCenter:center];
    
    [UIView animateWithDuration:3 animations:^{
    [self.view addSubview:imageView];
    [self.rectangle setHidden:YES];
    [self.instructionLabel setHidden:YES];
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
