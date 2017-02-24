//
//  ViewController.m
//  Radioset
//
//  Created by Павел Квачан on 2/20/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import "ViewController.h"
#import "Recorder.h"
#import "Player.h"
#import "MultipeerViewController.h"


@interface ViewController ()
{
    MultipeerViewController *_multipeerViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _multipeerViewController = [[MultipeerViewController alloc] init];
}
- (IBAction)Start:(id)sender
{
    [Recorder sharedRecorder].isStart = YES;
//    [Player sharedPlayer].isStart = YES;
    
//    NSData *data = nil;
//    data = [NSData dataWithBytes:[Recorder sharedRecorder].buffer.mData length:[Recorder sharedRecorder].buffer.mDataByteSize];
    
    
    if (_multipeerViewController != nil)
    {
        while ([Recorder sharedRecorder].buffer.mDataByteSize > 0)
        {
        
        if (_multipeerViewController.stream != nil)
        {
            void *testBuf = (void *)malloc([Recorder sharedRecorder].buffer.mDataByteSize);
            memcpy(testBuf, [Recorder sharedRecorder].buffer.mData, [Recorder sharedRecorder].buffer.mDataByteSize);
            
            
//             = static_cast<uint8_t *>(malloc([Recorder sharedRecorder].buffer.mDataByteSize *  sizeof(uint8_t)));
//            uint8_t *buffer = static_cast<uint8_t *>([Recorder sharedRecorder].buffer.mData);
            
            

            [_multipeerViewController.stream write:(uint8_t *)testBuf maxLength:[Recorder sharedRecorder].buffer.mDataByteSize];
            
        }
        else
        {
            NSLog(@"qwe");
        }
        }
    }
}

- (IBAction)Stop:(id)sender
{
    [Recorder sharedRecorder].isStart = NO;
    [Player sharedPlayer].isStart = NO;
}


- (IBAction)ShowBrowser:(id)sender
{
    [self presentViewController:(UIViewController *)_multipeerViewController.browserViewController
                       animated:YES
                     completion:nil];

}

@end
