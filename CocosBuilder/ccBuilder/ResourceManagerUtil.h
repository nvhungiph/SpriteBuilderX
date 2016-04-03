/*
 * CocosBuilder: http://www.cocosbuilder.org
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

@class RMResource;

@interface ResourceManagerUtil : NSObject <NSMenuDelegate>

+ (void) populateResourcePopup:(NSPopUpButton*)popup resType:(int)resType allowSpriteFrames:(BOOL)allowSpriteFrames selectedFile:(NSString*)file selectedSheet:(NSString*) sheetFile target:(id)target;

+ (void) populateFontTTFPopup:(NSPopUpButton*)popup selectedFont:(NSString*)file target:(id)target;

+ (NSString*) relativePathFromAbsolutePath: (NSString*) path;

+ (void) setTitle:(NSString*)str forPopup:(NSPopUpButton*)popup;

+ (void) setTitle:(NSString*)str forPopup:(NSPopUpButton*)popup forceMarker:(BOOL) forceMarker;

+ (void)setAttributedTitle:(NSString*)fontName ofMenuItem:(NSMenuItem*)item;

+ (NSImage*) thumbnailImageForResource:(RMResource*)res;

+ (NSImage*) iconForResource:(RMResource*) res;

@end