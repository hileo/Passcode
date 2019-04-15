//
//  ViewController.m
//  Passcode
//
//  Created by hileo on 3/25/19.
//  Copyright © 2019 hileo. All rights reserved.
//
//Private Mode Color
#define     COLOR_BTN_BG_ON [UIColor colorWithRed:71/255. green:71/255. blue:71/255. alpha:1.]
#define     COLOR_BTN_BG_NORMAL [UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:.3]
#define     COLOR_NUM_ON [UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1.]
#define     COLOR_NUM_NORMAL [UIColor blackColor]

#define     COLOR_LABEL [UIColor colorWithRed:53/255. green:168/255. blue:243/255. alpha:1.]
#define     COLOR_SUB [UIColor colorWithRed:186/255. green:186/255. blue:186/255. alpha:1.]
#define     COLOR_SUB_ERROR [UIColor redColor]


#define     COLOR_DOT_ON [UIColor colorWithRed:53/255. green:168/255. blue:243/255. alpha:1.]
#define     COLOR_DOT_NORMAL [UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1.]

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)showDefaultView{
    UIView *defaultView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDictory = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDictory)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, [UIScreen mainScreen].bounds.size) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    UIImage * launchImage = [UIImage imageNamed:launchImageName];
    defaultView.backgroundColor = [UIColor colorWithPatternImage:launchImage];

    [self.view addSubview:defaultView];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 /*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            defaultView.alpha = 0;
        } completion:nil];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btnNum8 = [UIButton new];
    btnNum8.frame = CGRectMake((SCREENWIDTH - 70)/2,72, 70, 70);
    btnNum8.backgroundColor = [UIColor redColor];
    [btnNum8 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNum8];
    
    UIButton *btnNum9 = [UIButton new];
    btnNum9.frame = CGRectMake((SCREENWIDTH - 70)/2,172, 70, 70);
    btnNum9.backgroundColor = [UIColor redColor];
    [btnNum9 addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNum9];
    
    
    UIButton *btnNum2 = [UIButton new];
    btnNum2.frame = CGRectMake((SCREENWIDTH - 70)/2,272, 70, 70);
    btnNum2.backgroundColor = [UIColor redColor];
    [btnNum2 addTarget:self action:@selector(btnAction3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNum2];
    [self showDefaultView];

}

- (void)btnAction:(UIButton*)btnEdit
{
    NSLog(@"11");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showPasscodeNotification" object:@"passcodeCreate"];

}

- (void)btnAction1:(UIButton*)btnEdit
{
    NSLog(@"22");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showPasscodeNotification" object:@"passcodeVerify"];

}

- (void)btnAction3:(UIButton*)btnEdit
{
    NSLog(@"22");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showPasscodeNotification" object:@"passcodeChange"];
    
}

@end
