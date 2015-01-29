//
//  ViewController.h
//  ReadStream
//
//  Created by Marc Davis on 1/27/15.
//  Copyright (c) 2015 Marc Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reciever.h"

@interface ViewController : UIViewController <testDelegate>

@property (nonatomic) Reciever *dataReciever;
@property (nonatomic) UIImageView *testView;

@end

