//
//  ViewController.m
//  ReadStream
//
//  Created by Marc Davis on 1/27/15.
//  Copyright (c) 2015 Marc Davis. All rights reserved.
//

#import "ViewController.h"
#import "Reciever.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataReciever = [[Reciever alloc] init];
    _testView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _testView.contentMode = UIViewContentModeScaleAspectFit;
    //test.image = [UIImage imageNamed:@"ShinyUmbreon.png"];
    [self.view addSubview:_testView];
    self.view.backgroundColor = [UIColor blackColor];
    _dataReciever.test = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)updateView:(UIImage *)image {
    [_testView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
