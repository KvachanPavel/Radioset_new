//
//  Recorder.m
//  Radioset
//
//  Created by Павел Квачан on 2/20/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import "Recorder.h"



@interface  Recorder()

@end

@implementation Recorder

static OSStatus recordingCallback(void *inRefCon,
                                  AudioUnitRenderActionFlags *ioActionFlags,
                                  const AudioTimeStamp *inTimeStamp,
                                  UInt32 inBusNumber,
                                  UInt32 inNumberFrames,
                                  AudioBufferList *ioData)
{
    AudioBuffer buffer;
    
    buffer.mNumberChannels = 1;
    buffer.mDataByteSize = inNumberFrames;
    buffer.mData = malloc(inNumberFrames);
    
    AudioBufferList bufferList;
    bufferList.mNumberBuffers = 1;
    bufferList.mBuffers[0] = buffer;
    
    Recorder *recorder = [Recorder sharedRecorder];
    
    AudioUnitRender(recorder.audioUnit,
                    ioActionFlags,
                    inTimeStamp,
                    inBusNumber,
                    inNumberFrames,
                    &bufferList);
    
    memcpy(recorder.buffer.mData, bufferList.mBuffers[0].mData, bufferList.mBuffers[0].mDataByteSize);
    
    free(bufferList.mBuffers[0].mData);
    
    return noErr;
}




#pragma mark - Lifecycle

+ (instancetype)sharedRecorder
{
    static Recorder *sharedRecorder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      sharedRecorder = [[self alloc] init];
                  });
    return sharedRecorder;
}


- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        UInt32 flag = 1;
        AudioUnitSetProperty(_audioUnit,
                             kAudioOutputUnitProperty_EnableIO,
                             kAudioUnitScope_Input,
                             1,
                             &flag,
                             sizeof(flag));
        
        AudioUnitSetProperty(_audioUnit,
                             kAudioUnitProperty_StreamFormat,
                             kAudioUnitScope_Output,
                             1,
                             &_ASBD,
                             sizeof(_ASBD));
        
        AURenderCallbackStruct callbackStruct;
        callbackStruct.inputProc = recordingCallback;
        callbackStruct.inputProcRefCon = (__bridge void * _Nullable)(self);
        AudioUnitSetProperty(_audioUnit,
                             kAudioOutputUnitProperty_SetInputCallback,
                             kAudioUnitScope_Global,
                             1,
                             &callbackStruct,
                             sizeof(callbackStruct));
        
        AudioUnitInitialize(_audioUnit);
    }
    
    return self;
    
}





@end

