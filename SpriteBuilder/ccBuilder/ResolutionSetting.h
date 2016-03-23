/*
 * CocosBuilder: http://www.cocosbuilder.com
 *
 * Copyright (c) 2012 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

@interface ResolutionSetting : NSObject
{
    BOOL enabled;
    NSString* name;
    int width;
    int height;
    NSString* ext;
    BOOL centeredOrigin;
    NSArray* exts;
}

@property (nonatomic,assign) BOOL enabled;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,assign) int width;
@property (nonatomic,assign) int height;
@property (nonatomic,copy) NSString* ext;
@property (nonatomic,assign) float resourceScale;
@property (nonatomic,assign) float mainScale;
@property (nonatomic,assign) float additionalScale;
@property (nonatomic,assign) BOOL centeredOrigin;
@property (nonatomic,readonly) NSArray* exts;

// Fixed resolutions
+ (ResolutionSetting*) settingPhone;
+ (ResolutionSetting*) settingPhoneHd;
+ (ResolutionSetting*) settingTablet;
+ (ResolutionSetting*) settingTabletHd;

// iOS resolutions
+ (ResolutionSetting*) settingIPhone;
+ (ResolutionSetting*) settingIPhoneLandscape;
+ (ResolutionSetting*) settingIPhonePortrait;
+ (ResolutionSetting*) settingIPhoneRetina;
+ (ResolutionSetting*) settingIPhoneRetinaLandscape;
+ (ResolutionSetting*) settingIPhoneRetinaPortrait;
+ (ResolutionSetting*) settingIPhone5Landscape;
+ (ResolutionSetting*) settingIPhone5Portrait;
+ (ResolutionSetting*) settingIPhone6;
+ (ResolutionSetting*) settingIPhone6Landscape;
+ (ResolutionSetting*) settingIPhone6Portrait;
+ (ResolutionSetting*) settingIPhone6PlusLandscape;
+ (ResolutionSetting*) settingIPhone6PlusPortrait;
+ (ResolutionSetting*) settingIPad;
+ (ResolutionSetting*) settingIPadLandscape;
+ (ResolutionSetting*) settingIPadPortrait;
+ (ResolutionSetting*) settingIPadRetina;
+ (ResolutionSetting*) settingIPadRetinaLandscape;
+ (ResolutionSetting*) settingIPadRetinaPortrait;

// Android resolutions
+ (ResolutionSetting*) settingAndroidXSmall;
+ (ResolutionSetting*) settingAndroidXSmallLandscape;
+ (ResolutionSetting*) settingAndroidXSmallPortrait;
+ (ResolutionSetting*) settingAndroidSmall;
+ (ResolutionSetting*) settingAndroidSmallLandscape;
+ (ResolutionSetting*) settingAndroidSmallPortrait;
+ (ResolutionSetting*) settingAndroidMedium;
+ (ResolutionSetting*) settingAndroidMediumLandscape;
+ (ResolutionSetting*) settingAndroidMediumPortrait;
+ (ResolutionSetting*) settingAndroidLarge;
+ (ResolutionSetting*) settingAndroidLargeLandscape;
+ (ResolutionSetting*) settingAndroidLargePortrait;
+ (ResolutionSetting*) settingAndroidXLarge;
+ (ResolutionSetting*) settingAndroidXLargeLandscape;
+ (ResolutionSetting*) settingAndroidXLargePortrait;

// HTML 5
+ (ResolutionSetting*) settingHTML5;
+ (ResolutionSetting*) settingHTML5Landscape;
+ (ResolutionSetting*) settingHTML5Portrait;

- (id) initWithSerialization:(id)serialization;

- (id) serialize;

@end