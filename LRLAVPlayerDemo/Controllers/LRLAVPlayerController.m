
//
//  LRLAVPlayerController.m
//  
//
//  Created by 刘瑞龙 on 15/9/10.
//
//

#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "LRLAVPlayerView.h"
#import "LRLAVPlayerController.h"

@interface LRLAVPlayerController ()<LRLAVPlayDelegate, AVPictureInPictureControllerDelegate>

//用来播放视频的view
@property (nonatomic, strong) LRLAVPlayerView * avplayerView;

@property (nonatomic, strong) AVPictureInPictureController *PiPVc;

@end

@implementation LRLAVPlayerController
//注意, 要实现正常的旋转屏, 设置处的旋转屏幕开启 上, 左, 右, 而代码中需要控制关闭设备自动旋转, 然后我在内部的实现是: 然后手动监测设备旋转方向来旋转avplayerView, 你要做的是各种视图控制器 实现:
/*
 -(BOOL)shouldAutorotate{
    return NO;
 }
 */

//还有AppDelegate中实现:
/*
 -(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
 return self.window.rootViewController.supportedInterfaceOrientations;
 }
 */

//播放器所用的图片资源, 在压缩包里的 Resource 文件夹下有一份
//代码全在在LRLAVPlayer文件夹下

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self createAVPlayerView];
}
//播放
- (IBAction)playButtonClicked:(id)sender {
    [self createAVPlayerView];
}
//销毁
- (IBAction)destoryButton:(id)sender {
//    [self.avplayerView destoryAVPlayer];
    [self.avplayerView removeFromSuperview];
    self.avplayerView = nil;
}
//下一页
- (IBAction)nextPage:(id)sender {
}
- (IBAction)startPiP:(id)sender {
//    if ([AVPictureInPictureController isPictureInPictureSupported]) {
//        if (self.PiPVc.pictureInPicturePossible) {
//            [self.PiPVc startPictureInPicture];
//        }else{
//            NSLog(@"画中画不可用");
//        }
//    }else{
//        NSLog(@"此设备不支持画中画");
//    }
}

#pragma mark - 创建用于播放的View
-(void)createAVPlayerView{
    //固定的实例化方法
    self.avplayerView = [LRLAVPlayerView avplayerViewWithVideoUrlStr:@"http://baobab.wdjcdn.com/1463028607774b.mp4" ];
    self.avplayerView.delegate = self;

    [self.avplayerView replay];
//    //我的播放器依赖 Masonry 第三方库
//    [self.avplayerView setPositionWithLandscapeBlock:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(SCREEN_HEIGHT));
//        make.height.equalTo(@(SCREEN_WIDTH));
//        make.center.equalTo(Window);
//    }];

}

- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController{
    NSLog(@"pip will start");
}
- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController{
    NSLog(@"pip did start");
}
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController failedToStartPictureInPictureWithError:(NSError *)error{
    NSLog(@"pip failed");
}
- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController{
    NSLog(@"pip will stop");
}
- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController{
    NSLog(@"pip did stop");
}
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler{
    NSLog(@"pip stop with handle");
}
-(void)didEndTime:(NSTimeInterval)havePlayTime {
    
}
#pragma mark - 关闭设备自动旋转, 然后手动监测设备旋转方向来旋转avplayerView
-(BOOL)shouldAutorotate{
    return NO;
}

@end
