//
//  MultipeerViewController.h
//  Radioset
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import "ViewController.h"

@class MCBrowserViewController;

@interface MultipeerViewController : ViewController

@property (nonatomic, readonly) MCBrowserViewController *browserViewController;


- (NSOutputStream *)startStream;

@end
