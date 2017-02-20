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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)Start:(id)sender
{
    [Recorder sharedRecorder].isStart = YES;
    [Player sharedPlayer].isStart = YES;
    
    memcpy([Player sharedPlayer].buffer.mData, [Recorder sharedRecorder].buffer.mData, [Recorder sharedRecorder].buffer.mDataByteSize);
    
    
}

- (IBAction)Stop:(id)sender
{
    [Recorder sharedRecorder].isStart = NO;
    [Player sharedPlayer].isStart = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
