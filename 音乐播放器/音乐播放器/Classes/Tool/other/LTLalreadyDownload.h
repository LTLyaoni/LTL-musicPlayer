//
//  LTLalreadyDownload.h
//  音乐播放器
//
//  Created by 李泰良 on 16/12/13.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;



@interface LTLalreadyDownload : NSObject


#pragma mark - Resizing Behavior

typedef enum : NSInteger
{
    LTLalreadyDownloadResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    LTLalreadyDownloadResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    LTLalreadyDownloadResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    LTLalreadyDownloadResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.
    
} LTLalreadyDownloadResizingBehavior;

extern CGRect LTLalreadyDownloadResizingBehaviorApply(LTLalreadyDownloadResizingBehavior behavior, CGRect rect, CGRect target);


#pragma mark - Canvas Drawings

//! Page 1
+(void) drawAlreadyDownload;
+(void) drawAlreadyDownloadWithFrame:(CGRect)frame resizing:(LTLalreadyDownloadResizingBehavior)resizing;


#pragma mark - Canvas Images

//! Page 1
+(UIImage *) imageOfAlreadyDownload;
+(UIImage *) imageOfAlreadyDownloadWithSize:(CGSize)size resizing:(LTLalreadyDownloadResizingBehavior)resizing;


@end
