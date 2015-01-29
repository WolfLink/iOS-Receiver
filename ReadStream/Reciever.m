//
//  Reciever.m
//  ReadStream
//
//  Created by Marc Davis on 1/27/15.
//  Copyright (c) 2015 Marc Davis. All rights reserved.
//

#import "Reciever.h"

@implementation Reciever
-(id)init{
    self = [super init];
    if (self){
        //CFReadStreamRef myReadStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, fileURL);
        _myID = [[MCPeerID alloc] initWithDisplayName:@"iPhone Viewer"];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud synchronize];
        NSString * str = [ud stringForKey:@"CID"];
        if (str == nil) {
            str = @"OSX-iOS";
        }
        
        NSUInteger count = 0, length = [str length];
        NSRange range = NSMakeRange(0, length);
        while(range.location != NSNotFound)
        {
            range = [str rangeOfString: @"cake" options:0 range:range];
            if(range.location != NSNotFound)
            {
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                count++;
            }
        }
        if (count > 2) {
            str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        if (str.length > 16) {
            str = [str substringToIndex:16];
        }
        
        NSLog(@"Starting service with service name: %@", str);
        
        _bowser = [[MCNearbyServiceBrowser alloc] initWithPeer:_myID serviceType:str];
        [_bowser setDelegate:self];
        [_bowser startBrowsingForPeers];
        NSLog(@"should be searching for peers");
    }
    return self;
}
-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    _session = [[MCSession alloc] initWithPeer:_myID];
    _session.delegate = self;
    [_bowser invitePeer:peerID toSession:_session withContext:nil timeout:5];
    NSLog(@"connection found");
}
-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    NSLog(@"Connection lost...");
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSLog(@"Session state changed");
    if (state == MCSessionStateConnected) {
        NSLog(@"connected...");
        [_bowser stopBrowsingForPeers];
    }
    else if(state == MCSessionStateConnecting) {
        NSLog(@"connecting...");
    }
    else {
        NSLog(@"not connected.");
        [_bowser startBrowsingForPeers];
    }
}
-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    /*CGColorSpaceRef color = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(data.bytes, 480, 300, 8, 960, color, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef img = CGBitmapContextCreateImage(newContext);
    UIImage *image = [[UIImage alloc] initWithCGImage:img];
     [_test updateView:image];*/
    
    [_test updateView:[UIImage imageWithData:data]];
}

@end
