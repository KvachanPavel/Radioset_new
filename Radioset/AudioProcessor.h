//
//  AudioProcessor.h
//  Radioset
//
//  Created by Павел Квачан on 2/21/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioProcessor : NSObject
{
    AudioBuffer                 _buffer;
    AudioComponentInstance      _audioUnit;
    AudioStreamBasicDescription _ASBD;
    
//    void* __nullable    mData;
}

@property (nonatomic, readonly) AudioComponentInstance audioUnit;
@property (nonatomic, assign) AudioBuffer buffer;

@property (nonatomic, assign) BOOL isStart;

@end
