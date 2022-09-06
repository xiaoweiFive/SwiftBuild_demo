//
//  MMBaseFoundation.h
//  MMBaseFoundationDemo
//
//  Created by yzkmac on 2020/2/24.
//  Copyright © 2020 yzkmac. All rights reserved.
//

#ifndef MMBaseFoundation_h
#define MMBaseFoundation_h

// NSObject
#if __has_include(<MMBaseFoundation/NSObject+Swizzle.h>)
#import <MMBaseFoundation/NSObject+Swizzle.h>
#import <MMBaseFoundation/NSObject+MMUtility.h>
#import <MMBaseFoundation/NSObject+DebugConfiguration.h>
#endif

// NSString
#if __has_include(<MMBaseFoundation/NSString+Momo.h>)
#import <MMBaseFoundation/NSString+Momo.h>
#endif

// NSSet
#if __has_include(<MMBaseFoundation/NSMutableSet+MMSafe.h>)
#import <MMBaseFoundation/NSMutableSet+MMSafe.h>
#endif

// NSDictionary
#if __has_include(<MMBaseFoundation/NSDictionary+MMSafe.h>)
#import <MMBaseFoundation/MFDictionaryAccessor.h>
#import <MMBaseFoundation/NSObject+MFDictionaryAdapterPrivate.h>
#import <MMBaseFoundation/NSDictionary+MMSafe.h>
#import <MMBaseFoundation/NSDictionary+URLQueryComponents.h>
#endif

// NSArray
#if __has_include(<MMBaseFoundation/NSArray+MMSafe.h>)
#import <MMBaseFoundation/NSArray+MMSafe.h>
#import <MMBaseFoundation/NSArray+MMUtility.h>
#endif

// NSData
#if __has_include(<MMBaseFoundation/NSData+MMConverString.h>)
#import <MMBaseFoundation/NSData+MMConverString.h>
#endif

// NSDate
#if __has_include(<MMBaseFoundation/NSDate+MMFormat.h>)
#import <MMBaseFoundation/NSDate+MMFormat.h>
#import <MMBaseFoundation/NSDate+Utilities.h>
#import <MMBaseFoundation/NSDate+MDUtility.h>
#endif

// NSFileManager
#if __has_include(<MMBaseFoundation/NSFileManager+Paths.h>)
#import <MMBaseFoundation/NSFileManager+Paths.h>
#endif

// JSON
#if __has_include(<MMBaseFoundation/MDJSONHelper.h>)
#import <MMBaseFoundation/MDJSONHelper.h>
#endif

#endif /* MMBaseFoundation_h */
