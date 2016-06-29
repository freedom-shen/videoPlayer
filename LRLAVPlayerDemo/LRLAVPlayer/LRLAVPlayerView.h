//
//  AVPlayerView.h
//  
//
//  Created by 刘瑞龙 on 15/9/10.
//
//

#import "Masonry.h"
#import "AppDelegate.h"
#import "LRLLightView.h"
#import "TimeSheetView.h"
#import "LRLAVPlayerDefine.h"

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^LayoutBlock)(MASConstraintMaker * make);

typedef enum : NSUInteger {
    progressControl,
    voiceControl,
    lightControl,
    noneControl = 999,
} ControlType;

@protocol LRLAVPlayDelegate <NSObject>
@optional
//开始时调用的方法
-(void)play;
//暂停时调用的方法
-(void)pause;
/**
 *  @param havePlayTime 总计播放时间
 */
- (void)didEndTime:(NSTimeInterval)havePlayTime;

@end

@interface LRLAVPlayerView : UIView
{
    @public
    float * _videoHeight;
}

@property (nonatomic, weak) id<LRLAVPlayDelegate> delegate;

/**
 *  @b 是否在播放
 */
@property (nonatomic, assign, readonly) BOOL isPlaying;

/**
 *  @b 视频的总长度
 */
@property (nonatomic, assign, readonly) float totalSeconds;

/**
 * @b 视频源urlStr
 */
@property (nonatomic, copy) NSString * videoUrlStr;

/**
 *  跳转到指定位置
 */
-(void)seekToTheTimeValue:(float)value;

/**
 * @b 设置初始位置block和, 全屏的block
 */
-(void)setPositionWithLandscapeBlock:(LayoutBlock)landscapeBlock;

/**
 * @b 唯一的实例方法, 请不要用其他的实例方法
 */
+(LRLAVPlayerView *)avplayerViewWithVideoUrlStr:(NSString *)urlStr;
//                               andInitialHeight:(float)height andSuperView:(UIView *)superView;

;

/**
 * @b destory 后再次播放, 会记住之前的播放状态, 时间和是否暂停
 */
-(void)replay;

/**
 *  开始播放 忽略上次播放
 */
- (void)start;

@end
