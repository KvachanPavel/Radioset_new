//
//  Player.h
//  Radioset
//
//  Created by Павел Квачан on 2/21/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioProcessor.h"

@interface Player : AudioProcessor

+ (instancetype)sharedPlayer;

@end
