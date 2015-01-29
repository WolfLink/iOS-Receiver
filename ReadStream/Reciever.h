//
//  Reciever.h
//  ReadStream
//
//  Created by Marc Davis on 1/27/15.
//  Copyright (c) 2015 Marc Davis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@protocol testDelegate <NSObject>

-(void)updateView:(UIImage *)image;

@end

@interface Reciever : NSObject <MCNearbyServiceBrowserDelegate, MCSessionDelegate>
@property (nonatomic) MCPeerID *myID;
@property (nonatomic) MCNearbyServiceBrowser *bowser;
@property (nonatomic) MCSession *session;

@property (nonatomic, weak) id<testDelegate> test;

@end
