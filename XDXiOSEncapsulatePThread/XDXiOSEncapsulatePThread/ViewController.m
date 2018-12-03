//
//  ViewController.m
//  XDXiOSEncapsulatePThread
//
//  Created by 小东邪 on 2018/11/27.
//  Copyright © 2018 小东邪. All rights reserved.
//

#import "ViewController.h"
#import "XDXTestPThreadHandler.h"
#import "XDXTestAPThreadHandler.h"

@interface ViewController ()

@property (nonatomic, strong) XDXTestPThreadHandler *testThread;
@property (nonatomic, strong) XDXTestAPThreadHandler *testAThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 非单例
    self.testThread = [[XDXTestPThreadHandler alloc] init];
    self.testThread.baseThreadName = @"World";

    // 单例
    self.testAThread= [XDXTestAPThreadHandler getInstance];
    self.testAThread.baseThreadName = @"Hello";
    
}


#pragma mark test
- (IBAction)startBtnClicked:(id)sender {
    [self.testThread startBaseThreadTask];
}

- (IBAction)stopBtnClicked:(id)sender {
    [self.testThread stopBaseThreadTaskThread];
}

- (IBAction)pauseBtnClicked:(id)sender {
    [self.testThread pauseBaseThread];
}

- (IBAction)continueBtnClicked:(id)sender {
    [self.testThread continueBaseThread];
}

#pragma mark - A
- (IBAction)startABtnClicked:(id)sender {
    [self.testAThread startBaseThreadTask];
}

- (IBAction)stopABtnClicked:(id)sender {
    [self.testAThread stopBaseThreadTaskThread];
}

- (IBAction)pauseABtnClicked:(id)sender {
    [self.testAThread pauseBaseThread];
}

- (IBAction)continueABtnClicked:(id)sender {
    [self.testAThread continueBaseThread];
}

@end
