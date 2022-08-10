//
//  MMBaseUtility.h
//  MMBaseUtilityDemo
//
//  Created by yzkmac on 2020/2/25.
//  Copyright © 2020 yzkmac. All rights reserved.
//

#ifndef MMBaseUtility_h
#define MMBaseUtility_h

// MDLinkedMap
#if __has_include(<MMBaseUtility/MDLinkedMap.h>)
#import <MMBaseUtility/MDLinkedMap.h>
#endif

// MDQueue
#if __has_include(<MMBaseUtility/MDQuene.h>)
#import <MMBaseUtility/MDQuene.h>
#import <MMBaseUtility/MDKeyQuene.h>
#endif

// MDStack
#if __has_include(<MMBaseUtility/MDStack.h>)
#import <MMBaseUtility/MDStack.h>
#endif

// MDWeakProxy
#if __has_include(<MMBaseUtility/MDWeakProxy.h>)
#import <MMBaseUtility/MDWeakProxy.h>
#endif

// MultipleThread
#if __has_include(<MMBaseUtility/MDLockDefinitions.h>)
#import <MMBaseUtility/NSObject+SemaphoreLock.h>
#import <MMBaseUtility/MDLockDefinitions.h>
#import <MMBaseUtility/MDSynchronizedSet.h>
#import <MMBaseUtility/MDThreadSafeDictionary.h>
#import <MMBaseUtility/MDThreadSafeMapTable.h>
#import <MMBaseUtility/MDThreadSafeSet.h>
#import <MMBaseUtility/QMSafeMutableArray.h>
#import <MMBaseUtility/QMSafeMutableDictionary.h>
#endif

// DispatchSource
#if __has_include(<MMBaseUtility/MFDispatchSource.h>)
#import <MMBaseUtility/MFDispatchSource.h>
#endif

// Timer
#if __has_include(<MMBaseUtility/MDSourceTimer.h>)
#import <MMBaseUtility/MDSourceTimer.h>
#import <MMBaseUtility/MFTimer.h>
#import <MMBaseUtility/NSTimer+MDBlockSupport.h>
#import <MMBaseUtility/MDCountLimitTimer.h>
#import <MMBaseUtility/MDDisplayLinkProxy.h>
#endif

// UIDevice
#if __has_include(<MMBaseUtility/UIDevice-Hardware.h>)
#import <MMBaseUtility/UIDevice-Hardware.h>
#endif

// KeyChain
#if __has_include(<MMBaseUtility/UIMomoCKeyChainStore.h>)
#import <MMBaseUtility/UIMomoCKeyChainStore.h>
#endif

// Util
#if __has_include(<MMBaseUtility/MFStopWatch.h>)
#import <MMBaseUtility/MFStopWatch.h>
#endif

// MFInetAddress
#if __has_include(<MMBaseUtility/MFInetAddress.h>)
#import <MMBaseUtility/MFInetAddress.h>
#endif

#if __has_include(<MMBaseUtility/PHPhotoLibrary+MMAlbumAsset.h>)
#import <MMBaseUtility/PHPhotoLibrary+MMAlbumAsset.h>
#endif

// MMUtility
#if __has_include(<MMBaseUtility/MMUtility.h>)
#import <MMBaseUtility/MMUtility.h>
#import <MMBaseUtility/MMUtility+File.h>
#endif

#endif /* MMBaseUtility_h */
