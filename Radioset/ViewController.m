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
    MultipeerViewController *multipeerViewController;
    NSOutputStream *outStream;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    multipeerViewController = [[MultipeerViewController alloc] init];
}
- (IBAction)Start:(id)sender
{
    [Recorder sharedRecorder].isStart = YES;
//    [Player sharedPlayer].isStart = YES;
    
    if (multipeerViewController != nil)
    {
        outStream = [multipeerViewController startStream];
        [outStream write:[Recorder sharedRecorder].buffer.mData maxLength:[Recorder sharedRecorder].buffer.mDataByteSize];
    }
    
    
    
    
//    NSLog(@"[Player sharedPlayer].buffer.mDataByteSize = %d", [Player sharedPlayer].buffer.mDataByteSize);
//    NSLog(@"[Recorder sharedRecorder].buffer.mDataByteSize = %d", [Recorder sharedRecorder].buffer.mDataByteSize);
//    
//    NSLog(@"[Player sharedPlayer].buffer.mNumberChannels = %d", [Player sharedPlayer].buffer.mNumberChannels);
//    NSLog(@"[Recorder sharedRecorder].buffer.mNumberChannels = %d", [Recorder sharedRecorder].buffer.mNumberChannels);
    
//    while (true)
//    {
//        memcpy([Player sharedPlayer].buffer.mData, [Recorder sharedRecorder].buffer.mData, [Recorder sharedRecorder].buffer.mDataByteSize);
//    }
    
}

- (IBAction)Stop:(id)sender
{
    [Recorder sharedRecorder].isStart = NO;
    [Player sharedPlayer].isStart = NO;
}


- (IBAction)ShowBrowser:(id)sender
{
    [self presentViewController:(UIViewController *)multipeerViewController.browserViewController
                       animated:YES
                     completion:nil];

}

@end
