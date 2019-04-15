//
//  ViewController.h
//  Passcode
//
//  Created by hileo on 3/25/19.
//  Copyright © 2019 hileo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PasscodeViewController : UIViewController
{
     NSString *passcodeType;

}
@property (nonatomic, strong) NSString *passcodeType;

@end

