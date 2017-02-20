//
//  Player.m
//  Radioset
//
//  Created by Павел Квачан on 2/21/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import "Player.h"

@implementation Player

static OSStatus playbackCallback(void *inRefCon,
                                 AudioUnitRenderActionFlags *ioActionFlags,
                                 const AudioTimeStamp *inTimeStamp,
                                 UInt32 inBusNumber,
                                 UInt32 inNumberFrames,
                                 AudioBufferList *ioData)
{
    for (int i = 0; i < ioData->mNumberBuffers; i++)
    {
        AudioBuffer buffer = ioData->mBuffers[i];
        
        Player *player = [Player sharedPlayer];
        
        UInt32 size = MIN(buffer.mDataByteSize, player.buffer.mDataByteSize);
        memcpy(buffer.mData, player.buffer.mData, size);
        buffer.mDataByteSize = size;
    }
    
    return noErr;
}




#pragma mark - Lifecycle

+ (instancetype)sharedPlayer
{
    static Player *sharedPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      sharedPlayer = [[self alloc] init];
                  });
    return sharedPlayer;
}

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        UInt32 flag = 1;
        
        AudioUnitSetProperty(_audioUnit,
                             kAudioOutputUnitProperty_EnableIO,
                             kAudioUnitScope_Output,
                             0,
                             &flag,
                             sizeof(flag));
        
        AudioUnitSetProperty(_audioUnit,
                             kAudioUnitProperty_StreamFormat,
                             kAudioUnitScope_Input,
                             0,
                             &_ASBD,
                             sizeof(_ASBD));
        
        AURenderCallbackStruct callbackStruct;
        callbackStruct.inputProc = playbackCallback;
        callbackStruct.inputProcRefCon = (__bridge void * _Nullable)(self);
        AudioUnitSetProperty(_audioUnit,
                             kAudioUnitProperty_SetRenderCallback,
                             kAudioUnitScope_Global,
                             0,
                             &callbackStruct,
                             sizeof(callbackStruct));
        
        AudioUnitInitialize(_audioUnit);
    }
    
    return self;
}

@end

