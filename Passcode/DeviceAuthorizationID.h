
#import <LocalAuthentication/LocalAuthentication.h>

/**
 *  TouchID/FaceID 状态
 */
typedef NS_ENUM(NSUInteger, DeviceAuthorizationIDState){
    
    /**
     *  当前设备不支持TouchID/FaceID
     */
    DeviceAuthorizationIDStateNotSupport = 0,
    /**
     *  TouchID/FaceID 验证成功
     */
    DeviceAuthorizationIDStateSuccess = 1,
    
    /**
     *  TouchID/FaceID 验证失败
     */
    DeviceAuthorizationIDStateFail = 2,
    /**
     *  TouchID/FaceID 被用户手动取消
     */
    DeviceAuthorizationIDStateUserCancel = 3,
    /**
     *  用户不使用TouchID/FaceID,选择手动输入密码
     */
    DeviceAuthorizationIDStateInputPassword = 4,
    /**
     *  TouchID/FaceID 被系统取消 (如遇到来电,锁屏,按了Home键等)
     */
    DeviceAuthorizationIDStateSystemCancel = 5,
    /**
     *  TouchID/FaceID 无法启动,因为用户没有设置密码
     */
    DeviceAuthorizationIDStatePasswordNotSet = 6,
    /**
     *  TouchID/FaceID 无法启动,因为用户没有设置TouchID/FaceID
     */
    DeviceAuthorizationIDStateTouchIDNotSet = 7,
    /**
     *  TouchID/FaceID 无效
     */
    DeviceAuthorizationIDStateTouchIDNotAvailable = 8,
    /**
     *  TouchID/FaceID 被锁定(连续多次验证TouchID/FaceID失败,系统需要用户手动输入密码)
     */
    DeviceAuthorizationIDStateTouchIDLockout = 9,
    /**
     *  当前软件被挂起并取消了授权 (如App进入了后台等)
     */
    DeviceAuthorizationIDStateAppCancel = 10,
    /**
     *  当前软件被挂起并取消了授权 (LAContext对象无效)
     */
    DeviceAuthorizationIDStateInvalidContext = 11,
    /**
     *  系统版本不支持TouchID/FaceID (必须高于iOS 8.0才能使用)
     */
    DeviceAuthorizationIDStateVersionNotSupport = 12
};


@interface DeviceAuthorizationID : LAContext

typedef void (^DeviceAuthorizationIDStateBlock)(DeviceAuthorizationIDState state, NSError *error);

/**
 * 启动TouchID/FaceID进行验证
 * @param describe TouchID/FaceID显示的描述
 * @param block 回调状态的block
 */
- (void)showAuthIDWithDescribe:(NSString *)describe block:(DeviceAuthorizationIDStateBlock)block;

@end
