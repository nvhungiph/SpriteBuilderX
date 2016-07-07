//
//  PlatformSettings.m
//  SpriteBuilder
//
//  Created by Sergey on 22.05.16.
//
//

#import "PlatformSettings.h"
#import "ResourceManager.h"
#import "RMPackage.h"

@interface PacketPublish : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL publish;
@property (nonatomic, assign) NSMutableArray *packets;
@end

@implementation PacketPublish
- (void) setPublish:(BOOL) value
{
    _publish = value;
    if(value)
    {
        if(![_packets containsObject:_name])
            [_packets addObject:_name];
    }
    else
    {
        if([_packets containsObject:_name])
            [_packets removeObject:_name];
    }
}
@end

@implementation PlatformSettings

- (NSArray*) packetsPublish
{
    NSMutableArray *ret = [NSMutableArray array];
    PacketPublish *mainPacket = [[PacketPublish alloc] init];
    mainPacket.name = @"Main";
    mainPacket.publish = [_packets containsObject:@"Main"];
    mainPacket.packets = _packets;
    [ret addObject:mainPacket];
    for (RMPackage *package in [[ResourceManager sharedManager] allPackages])
    {
        PacketPublish *packetPublish = [[PacketPublish alloc] init];
        packetPublish.name = package.name;
        packetPublish.publish = [_packets containsObject:packetPublish.name];
        packetPublish.packets = _packets;
        [ret addObject:packetPublish];
    }
    return ret;
}

- (id) serialize
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    
    dict[@"name"] = _name;
    
    dict[@"publishEnabled"] = @(_publishEnabled);
    dict[@"publishDirectory"] = _publishDirectory;
    
    dict[@"publish1x"] = @(_publish1x);
    dict[@"publish2x"] = @(_publish2x);
    dict[@"publish4x"] = @(_publish4x);
    
    dict[@"publishSound"] = @(_publishSound);
    dict[@"effectFormat"] = @(_effectFormat);
    dict[@"effectParams"] = @(_effectParams);
    dict[@"effectQuality"] = @(_effectQuality);
    dict[@"musicFormat"] = @(_musicFormat);
    dict[@"musicParams"] = @(_musicParams);
    dict[@"musicQuality"] = @(_musicQuality);
    dict[@"customSoundFormat"] = @(_customSoundFormat);
    dict[@"customSoundParams"] = @(_customSoundParams);
    dict[@"customSoundQuality"] = @(_customSoundQuality);
    
    dict[@"compressedImageFormat"] = @(_compressedImageFormat);
    dict[@"compressedImageQuality"] = @(_compressedImageQuality);
    dict[@"compressedNoAlphaImageFormat"] = @(_compressedNoAlphaImageFormat);
    dict[@"compressedNoAlphaImageQuality"] = @(_compressedNoAlphaImageQuality);
    dict[@"uncompressedImageFormat"] = @(_uncompressedImageFormat);
    dict[@"uncompressedImageQuality"] = @(_uncompressedImageQuality);
    dict[@"customImageFormat"] = @(_customImageFormat);
    dict[@"customImageQuality"] = @(_customImageQuality);
    dict[@"packets"] = _packets;
    
    return dict;
}

- (id) init
{
    self = [super init];
    if (!self)
    {
        return NULL;
    }
    _packets = [NSMutableArray array];
    _name = @"Empty";
    
    _publishEnabled = YES;
    _publishDirectory = @".";
    
    _publish1x = YES;
    _publish2x = YES;
    _publish4x = YES;
    
    _publishSound = YES;
    _effectFormat = 0;
    _effectParams= 0;
    _effectQuality = 0;
    _musicFormat = 0;
    _musicParams = 0;
    _musicQuality = 0;
    _customSoundFormat = 0;
    _customSoundParams = 0;
    _customSoundQuality = 0;
    
    _compressedImageFormat = 0;
    _compressedImageQuality = 0;
    _compressedNoAlphaImageFormat = 0;
    _compressedNoAlphaImageQuality = 0;
    _uncompressedImageFormat = 0;
    _uncompressedImageQuality = 0;
    _customImageFormat = 0;
    _customImageQuality = 0;
    return self;
}

- (id) initWithSerialization:(id)dict
{
    self = [super init];
    if (!self)
    {
        return NULL;
    }
    
    _name = [dict objectForKey:@"name"];
    self.publishEnabled = [[dict objectForKey:@"publishEnabled"] boolValue];
    self.publishDirectory = [dict objectForKey:@"publishDirectory"];
    
    self.publish1x = [[dict objectForKey:@"publish1x"] boolValue];
    self.publish2x = [[dict objectForKey:@"publish2x"] boolValue];
    self.publish4x = [[dict objectForKey:@"publish4x"] boolValue];
    
    self.publishSound = [[dict objectForKey:@"publishSound"] boolValue];
    self.effectFormat = [[dict objectForKey:@"effectFormat"] intValue];
    self.effectParams= [[dict objectForKey:@"effectParams"] intValue];
    self.effectQuality = [[dict objectForKey:@"effectQuality"] intValue];
    self.musicFormat = [[dict objectForKey:@"musicFormat"] intValue];
    self.musicParams = [[dict objectForKey:@"musicParams"] intValue];
    self.musicQuality = [[dict objectForKey:@"musicQuality"] intValue];
    self.customSoundFormat = [[dict objectForKey:@"customSoundFormat"] intValue];
    self.customSoundParams = [[dict objectForKey:@"customSoundParams"] intValue];
    self.customSoundQuality = [[dict objectForKey:@"customSoundQuality"] intValue];
    
    self.compressedImageFormat = [[dict objectForKey:@"compressedImageFormat"] intValue];
    self.compressedImageQuality = [[dict objectForKey:@"compressedImageQuality"] intValue];
    self.compressedNoAlphaImageFormat = [[dict objectForKey:@"compressedImageFormat"] intValue];
    self.compressedNoAlphaImageQuality = [[dict objectForKey:@"compressedImageQuality"] intValue];
    self.uncompressedImageFormat = [[dict objectForKey:@"uncompressedImageFormat"] intValue];
    self.uncompressedImageQuality = [[dict objectForKey:@"uncompressedImageQuality"] intValue];
    self.customImageFormat = [[dict objectForKey:@"customImageFormat"] intValue];
    self.customImageQuality = [[dict objectForKey:@"customImageQuality"] intValue];
    self.packets = [dict objectForKey:@"packets"];
    if(!self.packets)
        self.packets = [NSMutableArray array];
    
    return self;
}

@end