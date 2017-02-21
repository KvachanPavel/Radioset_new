//
//  AudioProcessor.m
//  Radioset
//
//  Created by Павел Квачан on 2/21/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import "AudioProcessor.h"

@implementation AudioProcessor




#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        OSStatus status;
        
        AudioComponentDescription description;
        description.componentType = kAudioUnitType_Output;
        description.componentSubType = kAudioUnitSubType_VoiceProcessingIO;//kAudioUnitSubType_RemoteIO;
        description.componentFlags = 0;
        description.componentFlagsMask = 0;
        description.componentManufacturer = kAudioUnitManufacturer_Apple;
        
        AudioComponent inputComponent = AudioComponentFindNext(NULL, &description);
        
        status = AudioComponentInstanceNew(inputComponent, &_audioUnit);
        
        _ASBD.mSampleRate		= 44100.00;
        _ASBD.mFormatID			= kAudioFormatLinearPCM;
        _ASBD.mFormatFlags		= kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
        _ASBD.mFramesPerPacket	= 1;
        _ASBD.mChannelsPerFrame	= 1;
        _ASBD.mBitsPerChannel	= 8;
        _ASBD.mBytesPerPacket	= 1;
        _ASBD.mBytesPerFrame	= 1;
        
        _buffer.mNumberChannels = 1;
        _buffer.mDataByteSize = 512;
        _buffer.mData = malloc( 512);
        
        
    }
    
    return self;
}




#pragma mark - Private methods

- (void)start
{
    AudioOutputUnitStart(_audioUnit);
}

- (void)stop
{
    AudioOutputUnitStop(_audioUnit);
}




#pragma mark - Properties

- (void)setIsStart:(BOOL)isStart
{
    if(isStart != _isStart)
    {
        ((isStart) ? ([self start]) : ([self stop]));
        
        _isStart = isStart;
    }
}


@end
