//
//  PasscodeViewController.m
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

#import "PasscodeViewController.h"

@interface PasscodeViewController ()
@property (nonatomic, strong) UIButton *btnNum1;
@property (nonatomic, strong) UIButton *btnNum2;
@property (nonatomic, strong) UIButton *btnNum3;
@property (nonatomic, strong) UIButton *btnNum4;
@property (nonatomic, strong) UIButton *btnNum5;
@property (nonatomic, strong) UIButton *btnNum6;
@property (nonatomic, strong) UIButton *btnNum7;
@property (nonatomic, strong) UIButton *btnNum8;
@property (nonatomic, strong) UIButton *btnNum9;
@property (nonatomic, strong) UIButton *btnNum0;

@property (nonatomic, strong) UIButton *btnID;
@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, strong) UIButton *btnCancel;

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelSub;
@property (nonatomic, strong) UILabel *labelTitleVerify;

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UIView *dot1View;
@property (nonatomic, strong) UIView *dot2View;
@property (nonatomic, strong) UIView *dot3View;
@property (nonatomic, strong) UIView *dot4View;

@property (nonatomic, assign) float btnMarginTop;
@property (nonatomic, assign) float btnMargin;
@property (nonatomic, assign) float labelMarginTop;
@property (nonatomic, assign) float labelMargin;
@property (nonatomic, assign) float dotMarginTop;
@property (nonatomic, strong) NSString *passcode;
@property (nonatomic, strong) NSString *passcodeOld;
@property (nonatomic, strong) NSString *passcodeCheck;
@property (nonatomic, assign) BOOL boolBtnNumEnable;


@end

@implementation PasscodeViewController
@synthesize passcodeType;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.btnMarginTop = 160;
    self.btnMargin = 20;
    self.labelMarginTop = 50;
    self.labelMargin = 10;
    self.dotMarginTop = 120;
    self.passcode = @"";
    self.boolBtnNumEnable = YES;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.passcodeOld = [userDefaults objectForKey:@"passcode"];
    
    if (SCREENHEIGHT == 667) { //ip7
        self.btnMarginTop = 240;
        self.btnMargin = 30;
        self.labelMarginTop = 90;
        self.labelMargin = 10;
        self.dotMarginTop = 180;
        
    } else if (SCREENHEIGHT == 736) { //ip7 plus
        self.btnMarginTop = 260;
        self.btnMargin = 30;
        self.labelMarginTop = 100;
        self.labelMargin = 10;
        self.dotMarginTop = 190;
    } else if (SCREENHEIGHT == 812) { //ip x xs
        self.btnMarginTop = 260;
        self.btnMargin = 30;
        self.labelMarginTop = 100;
        self.labelMargin = 10;
        self.dotMarginTop = 190;
    } else if (SCREENHEIGHT == 896) { //ip xs max xr
        self.btnMarginTop = 360;
        self.btnMargin = 30;
        self.labelMarginTop = 160;
        self.labelMargin = 10;
        self.dotMarginTop = 260;

    }
    
    self.dotView = [UIView new];
    self.dotView.frame = CGRectMake((SCREENWIDTH - 70)/2, self.dotMarginTop, 70, 20);
    [self.view addSubview:self.dotView];

    self.dot1View = [UIView new];
    self.dot1View.frame = CGRectMake(0, 0, 10, 10);
    self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
    self.dot1View.layer.cornerRadius = 5;
    [self.dotView addSubview:self.dot1View];
    
    self.dot2View = [UIView new];
    self.dot2View.frame = CGRectMake(20, 0, 10, 10);
    self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
    self.dot2View.layer.cornerRadius = 5;
    [self.dotView addSubview:self.dot2View];
    
    self.dot3View = [UIView new];
    self.dot3View.frame = CGRectMake(40, 0, 10, 10);
    self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
    self.dot3View.layer.cornerRadius = 5;
    [self.dotView addSubview:self.dot3View];
    
    self.dot4View = [UIView new];
    self.dot4View.frame = CGRectMake(60, 0, 10, 10);
    self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    self.dot4View.layer.cornerRadius = 5;
    [self.dotView addSubview:self.dot4View];
    
    self.labelTitle = [UILabel new];
    self.labelTitle.frame = CGRectMake((SCREENWIDTH - 250)/2, self.labelMarginTop, 250, 20);
    self.labelTitle.font = [UIFont boldSystemFontOfSize:16];
    self.labelTitle.textColor = COLOR_LABEL;
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"ENTER PASSCODE";
    [self.view addSubview:self.labelTitle];

    self.labelSub = [UILabel new];
    self.labelSub.frame = CGRectMake((SCREENWIDTH - 250)/2, self.labelMarginTop + 20 + self.labelMargin, 250, 20);
    self.labelSub.font =  [UIFont systemFontOfSize:12 weight:UIFontWeightThin];;
    self.labelSub.textColor = COLOR_SUB;
    self.labelSub.textAlignment = NSTextAlignmentCenter;
    self.labelSub.text = @"Please enter your passcode";
    [self.view addSubview:self.labelSub];
    
    self.labelTitleVerify = [UILabel new];
    self.labelTitleVerify.frame = CGRectMake(SCREENWIDTH, self.labelMarginTop, 250, 20);
    self.labelTitleVerify.font = [UIFont boldSystemFontOfSize:16];
    self.labelTitleVerify.textColor = COLOR_LABEL;
    self.labelTitleVerify.textAlignment = NSTextAlignmentCenter;
    self.labelTitleVerify.text = @"VERIFY YOUR NEW PASSCODE";
    [self.view addSubview:self.labelTitleVerify];
    
    self.btnNum2 = [UIButton new];
    self.btnNum2.frame = CGRectMake((SCREENWIDTH - 70)/2, self.btnMarginTop, 70, 70);
    self.btnNum2.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum2 setTitle:@"2" forState:UIControlStateNormal];
    self.btnNum2.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum2 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum2.layer.cornerRadius = 35;
    self.btnNum2.tag = 2;
    [self.btnNum2 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum2 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum2];
    
    self.btnNum5 = [UIButton new];
    self.btnNum5.frame = CGRectMake((SCREENWIDTH - 70)/2, self.btnMarginTop + 70*1 + self.btnMargin*1, 70, 70);
    self.btnNum5.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum5 setTitle:@"5" forState:UIControlStateNormal];
    self.btnNum5.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum5 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum5.layer.cornerRadius = 35;
    self.btnNum5.tag = 5;
    [self.btnNum5 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum5 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum5];
    
    self.btnNum8 = [UIButton new];
    self.btnNum8.frame = CGRectMake((SCREENWIDTH - 70)/2, self.btnMarginTop + 70*2 + self.btnMargin*2, 70, 70);
    self.btnNum8.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum8 setTitle:@"8" forState:UIControlStateNormal];
    self.btnNum8.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum8 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum8.layer.cornerRadius = 35;
    self.btnNum8.tag = 8;
    [self.btnNum8 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum8 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum8 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum8];
    
    self.btnNum0 = [UIButton new];
    self.btnNum0.frame = CGRectMake((SCREENWIDTH - 70)/2, self.btnMarginTop + 70*3 + self.btnMargin*3, 70, 70);
    self.btnNum0.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum0 setTitle:@"0" forState:UIControlStateNormal];
    self.btnNum0.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum0 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum0.layer.cornerRadius = 35;
    self.btnNum0.tag = 0;
    [self.btnNum0 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum0 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum0 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum0];
    
    // 1 3
    self.btnNum1 = [UIButton new];
    self.btnNum1.frame = CGRectMake(self.btnNum2.frame.origin.x - 70 - self.btnMargin, self.btnMarginTop, 70, 70);
    self.btnNum1.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum1 setTitle:@"1" forState:UIControlStateNormal];
    self.btnNum1.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum1 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum1.layer.cornerRadius = 35;
    self.btnNum1.tag = 1;
    [self.btnNum1 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum1 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum1];
    
    self.btnNum3 = [UIButton new];
    self.btnNum3.frame = CGRectMake(self.btnNum2.frame.origin.x + 70 + self.btnMargin, self.btnMarginTop, 70, 70);
    self.btnNum3.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum3 setTitle:@"3" forState:UIControlStateNormal];
    self.btnNum3.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum3 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum3.layer.cornerRadius = 35;
    self.btnNum3.tag = 3;
    [self.btnNum3 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum3 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum3];
    
    //4 6
    self.btnNum4 = [UIButton new];
    self.btnNum4.frame = CGRectMake(self.btnNum5.frame.origin.x - 70 - self.btnMargin, self.btnMarginTop + 70*1 + self.btnMargin*1, 70, 70);
    self.btnNum4.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum4 setTitle:@"4" forState:UIControlStateNormal];
    self.btnNum4.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum4 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum4.layer.cornerRadius = 35;
    self.btnNum4.tag = 4;
    [self.btnNum4 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum4 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum4];
    
    self.btnNum6 = [UIButton new];
    self.btnNum6.frame = CGRectMake(self.btnNum5.frame.origin.x + 70 + self.btnMargin, self.btnMarginTop + 70*1 + self.btnMargin*1, 70, 70);
    self.btnNum6.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum6 setTitle:@"6" forState:UIControlStateNormal];
    self.btnNum6.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum6 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum6.layer.cornerRadius = 35;
    self.btnNum6.tag = 6;
    [self.btnNum6 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum6 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum6 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum6];
    
    //7 9
    self.btnNum7 = [UIButton new];
    self.btnNum7.frame = CGRectMake(self.btnNum8.frame.origin.x - 70 - self.btnMargin, self.btnMarginTop + 70*2 + self.btnMargin*2, 70, 70);
    self.btnNum7.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum7 setTitle:@"7" forState:UIControlStateNormal];
    self.btnNum7.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum7 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum7.layer.cornerRadius = 35;
    self.btnNum7.tag = 7;
    [self.btnNum7 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum7 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum7 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum7];
    
    self.btnNum9 = [UIButton new];
    self.btnNum9.frame = CGRectMake(self.btnNum8.frame.origin.x + 70 + self.btnMargin, self.btnMarginTop + 70*2 + self.btnMargin*2, 70, 70);
    self.btnNum9.backgroundColor = COLOR_BTN_BG_NORMAL;
    [self.btnNum9 setTitle:@"9" forState:UIControlStateNormal];
    self.btnNum9.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.btnNum9 setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnNum9.layer.cornerRadius = 35;
    self.btnNum9.tag = 9;
    [self.btnNum9 addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnNum9 addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnNum9 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNum9];
    
    
    //ID
    self.btnID = [UIButton new];
    self.btnID.frame = CGRectMake(self.btnNum0.frame.origin.x - 70 - self.btnMargin, self.btnMarginTop + 70*3 + self.btnMargin*3, 70, 70);
    [self.btnID setImage:[UIImage imageNamed:@"btnPasscodeTouchID"] forState:UIControlStateNormal];
    self.btnID.layer.cornerRadius = 35;
    self.btnID.tag = 11;
    [self.btnID addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnID addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnID addTarget:self action:@selector(btnIDAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnID];
    self.btnID.hidden = YES;

    self.btnDelete = [UIButton new];
    self.btnDelete.frame = CGRectMake(self.btnNum0.frame.origin.x + 70 + self.btnMargin, self.btnMarginTop + 70*3 + self.btnMargin*3, 70, 70);
    [self.btnDelete setImage:[UIImage imageNamed:@"btnPasscodeDelete"] forState:UIControlStateNormal];
    self.btnDelete.layer.cornerRadius = 35;
    self.btnDelete.tag = 12;
    self.btnDelete.hidden = YES;
    [self.btnDelete addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnDelete addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnDelete addTarget:self action:@selector(btnDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnDelete];
    
    self.btnCancel = [UIButton new];
    self.btnCancel.frame = CGRectMake(self.btnNum0.frame.origin.x + 70 + self.btnMargin, self.btnMarginTop + 70*3 + self.btnMargin*3, 70, 70);
    [self.btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btnCancel setTitleColor:COLOR_NUM_NORMAL forState:UIControlStateNormal];
    self.btnCancel.tag = 12;
    [self.btnCancel addTarget:self action:@selector(btnDownEffect:) forControlEvents:UIControlEventTouchDown];
    [self.btnCancel addTarget:self action:@selector(btnUpEffect:) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnCancel addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnCancel];

    if ([self.passcodeType isEqualToString:@"passcodeCreate"]) {
        self.btnID.hidden = YES;
    }else if([self.passcodeType isEqualToString:@"passcodeVerify"]){
        self.btnCancel.hidden = YES;
        [self isSupportDeviceID];
    }else{
        
    }
    
}

- (void)btnDownEffect:(UIButton*)btnEdit
{
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         btnEdit.alpha = .4;
                     }
                     completion:nil];
}

- (void)btnUpEffect:(UIButton*)btnEdit
{
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         btnEdit.alpha = 1;
                     }
                     completion:nil];
}

- (void)passcodeCreate{
    if (self.passcode.length == 0) {
        self.btnDelete.hidden = YES;
        self.btnCancel.hidden = NO;

        self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 1) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 2) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 3) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 4) {
        self.btnDelete.hidden = YES;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_ON;
        
        if (self.passcodeCheck.length == 0) {
            self.passcodeCheck = self.passcode;
            self.passcode = @"";
            self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
            self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
            self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
            self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
            self.boolBtnNumEnable = NO;
            [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.labelTitle.frame = CGRectMake(-250, self.labelMarginTop, 250, 20);
                self.labelSub.frame = CGRectMake(-250, self.labelMarginTop + 20 + self.labelMargin, 250, 20);
                self.labelTitleVerify.frame = CGRectMake((SCREENWIDTH - 250)/2, self.labelMarginTop, 250, 20);
            } completion:nil];
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.45 /*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                self.boolBtnNumEnable = YES;
            });
        }else if ([self.passcode isEqualToString:self.passcodeCheck] && self.passcodeCheck.length == 4) {
            NSLog(@"密码是%@",self.passcode);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.passcode  forKey:@"passcode"];
            [userDefaults synchronize];
            [self closeAction:nil];
        }else if(![self.passcode isEqualToString:self.passcodeCheck] && self.passcodeCheck.length == 4){
            self.passcodeCheck = @"";
            self.passcode = @"";
            self.btnCancel.hidden = NO;
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
            self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
            self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
            self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
            self.boolBtnNumEnable = NO;
            [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.labelSub.text = @"Passcode did not match.try again";
                self.labelTitle.frame = CGRectMake((SCREENWIDTH - 250)/2, self.labelMarginTop, 250, 20);
                self.labelSub.frame = CGRectMake((SCREENWIDTH - 250)/2, self.labelMarginTop + 20 + self.labelMargin, 250, 20);
                self.labelTitleVerify.frame = CGRectMake(SCREENWIDTH, self.labelMarginTop, 250, 20);
                
            } completion:nil];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.45 /*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                self.boolBtnNumEnable = YES;
            });
        }
    }
}

- (void)passcodeVerify{
    if (self.passcode.length == 0) {
        self.btnDelete.hidden = YES;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 1) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 2) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 3) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 4) {
        self.btnDelete.hidden = YES;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_ON;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 /*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if([self.passcode isEqualToString:self.passcodeOld]){
                NSLog(@"密码是%@",self.passcode);
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.passcode  forKey:@"passcode"];
                [userDefaults synchronize];
                [self closeAction:nil];
            }else{
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                self.labelSub.textColor = COLOR_SUB_ERROR;
                self.labelSub.text = @"Failed passcode";
                self.passcode = @"";
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
                animation.fromValue = [NSNumber numberWithFloat:0];
                animation.toValue = [NSNumber numberWithFloat:6];
                animation.duration = 0.05; // 动画持续时间
                animation.repeatCount = 3; // 重复次数
                animation.autoreverses = YES; // 动画结束时执行逆动画
                [self.dotView.layer addAnimation:animation forKey:@"scale-layer"];

                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4/*延迟执行时间*/ * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
                    self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
                    self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
                    self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
                });
            }
        });
    }
}

- (void)passcodeChange{
    if (self.passcode.length == 0) {
        self.btnDelete.hidden = YES;
        self.btnCancel.hidden = NO;
        
        self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 1) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 2) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 3) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 4) {
        self.btnDelete.hidden = YES;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_ON;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 /*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if([self.passcode isEqualToString:self.passcodeOld]){
                self.passcode = @"";
                self.passcodeOld = @"";
                self.passcodeCheck = @"";
                self.labelSub.textColor = COLOR_SUB;
                self.labelSub.text = @"Please enter your passcode";
                self.labelTitle.text = @"ENTER NEW PASSCODE";
                self.passcodeType = @"passcodeCreate";
                [self passcodeCreate];
            }else{
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                self.labelSub.textColor = COLOR_SUB_ERROR;
                self.labelSub.text = @"Failed passcode";
                self.passcode = @"";
                self.btnCancel.hidden = NO;
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
                animation.fromValue = [NSNumber numberWithFloat:0];
                animation.toValue = [NSNumber numberWithFloat:6];
                animation.duration = 0.05; // 动画持续时间
                animation.repeatCount = 3; // 重复次数
                animation.autoreverses = YES; // 动画结束时执行逆动画
                [self.dotView.layer addAnimation:animation forKey:@"scale-layer"];
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4/*延迟执行时间*/ * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
                    self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
                    self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
                    self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
                });
            }
        });
    }
}

- (void)btnAction:(UIButton*)btnEdit
{
    btnEdit.alpha = 1;
    if (!self.boolBtnNumEnable) {
        return;
    }
    if (self.passcode.length < 4) {
        if (btnEdit.tag == 1) {
            self.passcode = [NSString stringWithFormat:@"%@1",self.passcode];
        }else if (btnEdit.tag == 2) {
            self.passcode = [NSString stringWithFormat:@"%@2",self.passcode];
        }else if (btnEdit.tag == 3) {
            self.passcode = [NSString stringWithFormat:@"%@3",self.passcode];
        }else if (btnEdit.tag == 4) {
            self.passcode = [NSString stringWithFormat:@"%@4",self.passcode];
        }else if (btnEdit.tag == 5) {
            self.passcode = [NSString stringWithFormat:@"%@5",self.passcode];
        }else if (btnEdit.tag == 6) {
            self.passcode = [NSString stringWithFormat:@"%@6",self.passcode];
        }else if (btnEdit.tag == 7) {
            self.passcode = [NSString stringWithFormat:@"%@7",self.passcode];
        }else if (btnEdit.tag == 8) {
            self.passcode = [NSString stringWithFormat:@"%@8",self.passcode];
        }else if (btnEdit.tag == 9) {
            self.passcode = [NSString stringWithFormat:@"%@9",self.passcode];
        }else if (btnEdit.tag == 0) {
            self.passcode = [NSString stringWithFormat:@"%@0",self.passcode];
        }
    }
    if ([self.passcodeType isEqualToString:@"passcodeCreate"]) {
        [self passcodeCreate];
    }else if([self.passcodeType isEqualToString:@"passcodeVerify"]){
        [self passcodeVerify];
    }else{
        [self passcodeChange];
    }
}

- (void)closeAction:(UIButton*)btnClear
{
    btnClear.alpha = 1;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnDeleteAction:(UIButton*)btnEdit
{
    btnEdit.alpha = 1;
    if (self.passcode.length > 0) {
        self.passcode = [self.passcode substringWithRange:NSMakeRange(0, [self.passcode length] - 1)];
    }
    if (self.passcode.length == 0) {
        self.btnDelete.hidden = YES;
        if ([self.passcodeType isEqualToString:@"passcodeCreate"]) {
            self.btnCancel.hidden = NO;
        }else if ([self.passcodeType isEqualToString:@"passcodeVerify"]) {
            self.btnCancel.hidden = YES;
        }else{
            self.btnCancel.hidden = NO;
        }
        self.dot1View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 1) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 2) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_NORMAL;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 3) {
        self.btnDelete.hidden = NO;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_NORMAL;
    }else if (self.passcode.length == 4) {
        self.btnDelete.hidden = YES;
        self.btnCancel.hidden = YES;
        
        self.dot1View.backgroundColor = COLOR_DOT_ON;
        self.dot2View.backgroundColor = COLOR_DOT_ON;
        self.dot3View.backgroundColor = COLOR_DOT_ON;
        self.dot4View.backgroundColor = COLOR_DOT_ON;
    }

}
- (BOOL)isFaceID{
    if (SCREENHEIGHT == 812 || SCREENHEIGHT == 896) { //ip x xs
        return YES;
    } else
        return NO;
}
- (BOOL)isSupportDeviceID{
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"输入密码";
    NSError *error = nil;
    NSString* describe = @"需要您的支付进行支付";
    // LAPolicyDeviceOwnerAuthenticationWithBiometrics: 用TouchID/FaceID验证
    // LAPolicyDeviceOwnerAuthentication: 用TouchID/FaceID或密码验证, 默认是错误两次或锁定后, 弹出输入密码界面（本案例使用）
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        self.btnID.hidden = NO;
        NSLog(@"DeviceID");
        if ([self isFaceID]) {
            [self.btnID setImage:[UIImage imageNamed:@"btnPasscodeFaceID"] forState:UIControlStateNormal];
        }
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:describe reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [self closeAction:nil];
            }else if(error){
                if (@available(iOS 11.0, *)) {
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID/FaceID 验证失败");
                            });
                            break;
                        }
                        case LAErrorUserCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID/FaceID 被用户手动取消");
                            });
                        }
                            break;
                        case LAErrorUserFallback:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"用户不使用TouchID/FaceID,选择手动输入密码");
                            });
                        }
                            break;
                        case LAErrorSystemCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID/FaceID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            });
                        }
                            break;
                        case LAErrorPasscodeNotSet:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID/FaceID 无法启动,因为用户没有设置密码");
                            });
                        }
                            break;
                            //case LAErrorTouchIDNotEnrolled:{
                        case LAErrorBiometryNotEnrolled:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID/FaceID 无法启动,因为用户没有设置TouchID/FaceID");
                            });
                        }
                            break;
                            //case LAErrorTouchIDNotAvailable:{
                        case LAErrorBiometryNotAvailable:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID/FaceID 无效");
                            });
                        }
                            break;
                            //case LAErrorTouchIDLockout:{
                        case LAErrorBiometryLockout:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID/FaceID 被锁定(连续多次验证TouchID/FaceID失败,系统需要用户手动输入密码)");
                            });
                        }
                            break;
                        case LAErrorAppCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                            });
                        }
                            break;
                        case LAErrorInvalidContext:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            });
                        }
                            break;
                        default:
                            break;
                    }
                }else{
                    // iOS 11.0以下的版本只有 TouchID 认证
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 验证失败");
                            });
                            break;
                        }
                        case LAErrorUserCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 被用户手动取消");
                            });
                        }
                            break;
                        case LAErrorUserFallback:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"用户不使用TouchID,选择手动输入密码");
                            });
                        }
                            break;
                        case LAErrorSystemCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            });
                        }
                            break;
                        case LAErrorPasscodeNotSet:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                            });
                        }
                            break;
                        case LAErrorTouchIDNotEnrolled:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                            });
                        }
                            break;
                            //case :{
                        case LAErrorTouchIDNotAvailable:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 无效");
                            });
                        }
                            break;
                        case LAErrorTouchIDLockout:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                            });
                        }
                            break;
                        case LAErrorAppCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                            });
                        }
                            break;
                        case LAErrorInvalidContext:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            });
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
        }];
    }else{
        NSLog(@"NO DeviceID");
    }
    return NO;
}

- (void)btnIDAction:(UIButton*)btnEdit
{
    btnEdit.alpha = 1;
    [self isSupportDeviceID];
    //dddd
}
@end
