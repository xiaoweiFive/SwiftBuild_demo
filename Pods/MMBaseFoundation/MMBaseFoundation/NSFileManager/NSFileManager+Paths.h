//
//  NSFileManager+Paths.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (MDPaths)

/**
 *  沙盒目录中document,library,caches的URL
 */
+ (NSURL *)md_documentsURL;
+ (NSURL *)md_libraryURL;
+ (NSURL *)md_cachesURL;
+ (NSURL *)md_applicationSupportURL;
+ (NSURL *)md_tempURL;

/**
 *  沙盒目录中document,library,caches的Path
 */
+ (NSString *)md_documentsPath;
+ (NSString *)md_libraryPath;
+ (NSString *)md_cachesPath;
+ (NSString *)md_applicationSupportPath;
+ (NSString *)md_tempPath;

@end
