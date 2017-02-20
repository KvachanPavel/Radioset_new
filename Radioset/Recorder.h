//
//  Recorder.h
//  Radioset
//
//  Created by Павел Квачан on 2/20/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioProcessor.h"

@interface Recorder : AudioProcessor

+ (instancetype)sharedRecorder;

@end
