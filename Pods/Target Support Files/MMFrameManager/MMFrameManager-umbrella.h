#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FrameManager.h"
#import "MDScreenInstance.h"
#import "MMFrameManager.h"

FOUNDATION_EXPORT double MMFrameManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char MMFrameManagerVersionString[];

