#import "SBPackageSettings.h"
#import "RMPackage.h"
#import "PublishOSSettings.h"
#import "MiscConstants.h"

NSString *const KEY_PUBLISH_TO_CUSTOM_DIRECTORY = @"publishToCustomDirectory";
NSString *const KEY_PUBLISH_TO_ZIP = @"publishToZip";
NSString *const KEY_PUBLISH_TO_MAINPROJECT = @"publishToMainProject";
NSString *const KEY_SHOW_CONTENT_IN_FINDER = @"showContentInFinder";
NSString *const KEY_OS_SETTINGS = @"osSettings";
NSString *const KEY_OUTPUTDIR = @"outputDir";
NSString *const KEY_PUBLISH_ENV = @"publishEnv";
NSString *const KEY_DEFAULT_SCALE = @"resourceAutoScaleFactor";

// It's a tag for a dropdown
NSInteger const DEFAULT_TAG_VALUE_GLOBAL_DEFAULT_SCALING = -1;

@interface SBPackageSettings ()

@property (nonatomic, strong) NSMutableDictionary *publishSettingsForOsType;

@end


@implementation SBPackageSettings

- (instancetype)init
{
    NSLog(@"Error initializing SBPackageSettings, use initWithPackage:");
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithPackage:(RMPackage *)package
{
    self = [super init];

    if (self)
    {
        self.publishToZip = NO;
        self.publishToMainProject = YES;
        self.showPackageContentInFinder = NO;
        self.publishToCustomOutputDirectory = NO;
        self.resourceAutoScaleFactor = DEFAULT_TAG_VALUE_GLOBAL_DEFAULT_SCALING;

        self.package = package;
        self.publishSettingsForOsType = [NSMutableDictionary dictionary];

        _publishSettingsForOsType[[self osTypeToString:kCCBPublisherOSTypeIOS]] = [[PublishOSSettings alloc] init];
        _publishSettingsForOsType[[self osTypeToString:kCCBPublisherOSTypeTVOS]] = [[PublishOSSettings alloc] init];
    }

    return self;
}

- (NSString *)osTypeToString:(CCBPublisherOSType)osType
{
    switch (osType)
    {
        case kCCBPublisherOSTypeIOS :
            return @"ios";

        case kCCBPublisherOSTypeTVOS :
            return @"tvos";
        default :
            return nil;
    }
}

- (NSDictionary *)osSettings
{
    return _publishSettingsForOsType;
}

- (PublishOSSettings *)settingsForOsType:(CCBPublisherOSType)type;
{
    return _publishSettingsForOsType[[self osTypeToString:type]];
}

- (void)setOSSettings:(PublishOSSettings *)osSettings forOsType:(CCBPublisherOSType)type
{
    if (!osSettings)
    {
        return;
    }

    _publishSettingsForOsType[[self osTypeToString:type]] = osSettings;
}

- (BOOL)load
{
    NSString *fullPath = [_package.dirPath stringByAppendingPathComponent:@"Package.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:fullPath];

    if (!dict)
    {
        return NO;
    }

    self.publishToCustomOutputDirectory = [dict[KEY_PUBLISH_TO_CUSTOM_DIRECTORY] boolValue];
    self.publishToZip = [dict[KEY_PUBLISH_TO_ZIP] boolValue];
    self.showPackageContentInFinder = [dict[KEY_SHOW_CONTENT_IN_FINDER] boolValue];
    self.publishToMainProject = [dict[KEY_PUBLISH_TO_MAINPROJECT] boolValue];
    self.customOutputDirectory = dict[KEY_OUTPUTDIR];
    self.publishEnvironment = (CCBPublishEnvironment) [dict[KEY_PUBLISH_ENV] integerValue];

    // Migration if keys are not set
    self.resourceAutoScaleFactor = dict[KEY_DEFAULT_SCALE]
        ? [dict[KEY_DEFAULT_SCALE] integerValue]
        : DEFAULT_TAG_VALUE_GLOBAL_DEFAULT_SCALING;

    for (NSString *osType in dict[KEY_OS_SETTINGS])
    {
        NSDictionary *dictOsSettings = dict[KEY_OS_SETTINGS][osType];
        PublishOSSettings *publishOSSettings = [[PublishOSSettings alloc] initWithDictionary:dictOsSettings];
        _publishSettingsForOsType[osType] = publishOSSettings;
    }

    return YES;
}

- (BOOL)store
{
    NSAssert(_package != nil, @"package must not be nil");

    NSDictionary *dict = [self toDictionary];
    NSString *fullPath = [_package.dirPath stringByAppendingPathComponent:PACKAGE_PUBLISH_SETTINGS_FILE_NAME];
    return [dict writeToFile:fullPath atomically:YES];
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];

    result[KEY_PUBLISH_TO_CUSTOM_DIRECTORY] = @(_publishToCustomOutputDirectory);
    result[KEY_PUBLISH_TO_ZIP] = @(_publishToZip);
    result[KEY_SHOW_CONTENT_IN_FINDER] = @(_showPackageContentInFinder);
    result[KEY_PUBLISH_TO_MAINPROJECT] = @(_publishToMainProject);
    result[KEY_PUBLISH_ENV] = @(_publishEnvironment);
    result[KEY_OUTPUTDIR] = _customOutputDirectory
        ? _customOutputDirectory
        : @"";

    result[KEY_OS_SETTINGS] = [NSMutableDictionary dictionary];

    for (NSString *osType in _publishSettingsForOsType)
    {
        PublishOSSettings *someOsSettings = _publishSettingsForOsType[osType];

        result[KEY_OS_SETTINGS][osType] = [someOsSettings toDictionary];
    }

    result[KEY_DEFAULT_SCALE] = @(_resourceAutoScaleFactor);

    return result;
}

- (NSString *)effectiveOutputDirectory
{
    return _publishToCustomOutputDirectory
           && ([[_customOutputDirectory stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0)
        ? _customOutputDirectory
        : DEFAULT_OUTPUTDIR_PUBLISHED_PACKAGES;
}

+(void)showPackageContentInFinder:(BOOL)showPackageInFinder withPackagePath:(NSString*)packagePath
{
    const char* pathFSR = [packagePath fileSystemRepresentation];
    FSRef ref;
    OSStatus err = FSPathMakeRef((const UInt8*)pathFSR, &ref, /*isDirectory*/ NULL);
    if (err == noErr)
    {
        struct FSCatalogInfo catInfo;
        
        if (err == noErr)
        {
            struct FSCatalogInfo catInfo;
            err = FSGetCatalogInfo(&ref,
                                   kFSCatInfoFinderInfo,
                                   &catInfo,
                                   /*outName*/ NULL,
                                   /*FSSpec*/ NULL,
                                   /*parentRef*/ NULL);
            
            if (err == noErr)
            {
                if (!showPackageInFinder)
                    ((FolderInfo*)&catInfo.finderInfo)->finderFlags |=  kHasBundle;
                else
                    ((FolderInfo*)&catInfo.finderInfo)->finderFlags &= ~kHasBundle;
                
                FSSetCatalogInfo(&ref,
                                 kFSCatInfoFinderInfo,
                                 &catInfo);
            }
        }
    }
}

@end
