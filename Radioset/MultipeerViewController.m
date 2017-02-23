//
//  MultipeerViewController.m
//  Radioset
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Павел Квачан. All rights reserved.
//

#import "MultipeerViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

NSString * const KPServiceType = @"KPServiceType";

@interface MultipeerViewController () <MCBrowserViewControllerDelegate, MCSessionDelegate>
{
    MCPeerID  *_myPeerID;
    MCSession *_mySession;
    
    MCAdvertiserAssistant   *_advertiser;
}

@end

@implementation MultipeerViewController

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        _myPeerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
        
        _mySession = [[MCSession alloc] initWithPeer:_myPeerID
                                    securityIdentity:nil
                                encryptionPreference:MCEncryptionNone];
        
        _mySession.delegate = self;
        
        _browserViewController = [[MCBrowserViewController alloc] initWithServiceType:KPServiceType
                                                                              session:_mySession];
        
        _browserViewController.delegate = self;
        
        
        _advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:KPServiceType
                                                           discoveryInfo:nil
                                                                 session:_mySession];
        
        [_advertiser start];
//        [_mySession startStreamWithName:<#(nonnull NSString *)#> toPeer:<#(nonnull MCPeerID *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>]        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_browserViewController != nil)
    {
        [self presentViewController:_browserViewController
                           animated:YES
                         completion:nil];
    }
    
}


- (NSOutputStream *)startStream
{
    NSError *error;
    NSOutputStream *stream = [_mySession startStreamWithName:@"test"
                                                      toPeer:_mySession.connectedPeers[0]
                                                       error:&error];
    
    if (error != nil)
    {
        NSLog(error);
    }
    
    [stream open];
    
    return stream;
}



#pragma mark - MCBrowserViewControllerDelegate -

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES
                                              completion:^
     {
         NSLog(@"browserViewControllerDidFinish");
     }];
}


- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES
                                              completion:^
     {
         NSLog(@"browserViewControllerWasCancelled");
     }];
}




#pragma mark - MCSessionDelegate -

// Remote peer changed state.
- (void)session:(MCSession *)session
           peer:(MCPeerID *)peerID
 didChangeState:(MCSessionState)state
{
    switch (state)
    {
        case MCSessionStateConnecting:
            NSLog(@"connecting");
            break;
            
        case MCSessionStateConnected:
            _stream = [self startStream];
            NSLog(@"connected");
            break;
            
        case MCSessionStateNotConnected:
            
            if (_stream != nil)
            {
                _stream = nil;
            }
            NSLog(@"NotConnected");
            break;
            
        default:
            break;
    }
}

// Received data from remote peer.
- (void)session:(MCSession *)session
 didReceiveData:(NSData *)data
       fromPeer:(MCPeerID *)peerID
{
    NSLog(@"didReceiveData");
}

#define BUFFER_LEN 10000

// Received a byte stream from remote peer.
- (void)    session:(MCSession *)session
   didReceiveStream:(NSInputStream *)stream
           withName:(NSString *)streamName
           fromPeer:(MCPeerID *)peerID
{
    int result = 0;
    uint8_t buffer[BUFFER_LEN];
//
    while((result = [stream read:buffer maxLength:BUFFER_LEN]) != 0)
    {
        if(result > 0)
        {
            NSLog(@"YES");
            // buffer contains result bytes of data to be handled
        }
        else
        {
            NSLog(@"NO");
            // The stream had an error. You can get an NSError object using [iStream streamError]
        }
    }
//    [stream open];
//    [stream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [stream setDelegate:self];
    
    NSLog(@"didReceiveStream");
}

// Start receiving a resource from remote peer.
- (void)                    session:(MCSession *)session
  didStartReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                       withProgress:(NSProgress *)progress
{
    
}

// Finished receiving a resource from remote peer and saved the content
// in a temporary location - the app is responsible for moving the file
// to a permanent location within its sandbox.
- (void)                    session:(MCSession *)session
 didFinishReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                              atURL:(NSURL *)localURL
                          withError:(nullable NSError *)error
{
    
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode;
{
    BOOL shouldClose = NO;
    NSLog(@"delegate");
//    switch(eventCode)
//    {
//        case  NSStreamEventEndEncountered:
//            NSLog(@"NSStreamEventEndEncountered");
//            shouldClose = YES;
//            // If all data hasn't been read, fall through to the "has bytes" event
//            if(!aStream.hasBytesAvailable) break;
//        case NSStreamEventHasBytesAvailable: ; // We need a semicolon here before we can declare local variables
//            NSLog(@"NSStreamEventHasBytesAvailable");
//            uint8_t *buffer;
//            NSUInteger length;
//            BOOL freeBuffer = NO;
//            // The stream has data. Try to get its internal buffer instead of creating one
//            if(![iStream getBuffer:&buffer length:&length]) {
//                // The stream couldn't provide its internal buffer. We have to make one ourselves
//                buffer = malloc(BUFFER_LEN * sizeof(uint8_t));
//                freeBuffer = YES;
//                NSInteger result = [iStream read:buffer maxLength:BUFFER_LEN];
//                if(result < 0) {
//                    // error copying to buffer
//                    break;
//                }
//                length = result;
//            }
//            // length bytes of data in buffer
//            if(freeBuffer) free(buffer);
//            break;
//        case NSStreamEventErrorOccurred:
//            NSLog(@"NSStreamEventErrorOccurred");
//            // some other error
//            shouldClose = YES;
//            break;
//    }
//    if(shouldClose) [iStream close];
}






@end
