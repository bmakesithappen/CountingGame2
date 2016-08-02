//
//  ViewController.m
//  CountGameApp2
//
//  Created by Bernard Desert on 08/01/2016.
//  Copyright © 2016 Bernard Desert. All rights reserved.
//

#import "ViewController.h"

static CGFloat const ButtonDiameter = 80; // Global Naming?? Why

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *buttons; // list of buttons Array

@property (nonatomic) NSInteger numberOFButtons; // # for buttons 1 - ....
@property (nonatomic) NSInteger lastTappedNumber; // need to retain which button was tapped

// strong was not listed.  What is the default?  why not

@end

@implementation ViewController

#pragma mark - View Lifecycle 
// what will happen when buttons are tapped

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttons = [[NSMutableArray alloc] init];  // instantiate
    self.lastTappedNumber = 0; // why zero
    
    self.numberOFButtons = 10;
    [self createButtons];
    [self randomizedButtonPositions]; // property we imported
}

#pragma mark - Private 

// pragma is for denoting specific sections , keeping code readable
// Private ??

- (void)createButtons { // instatiating create buttons
    // never used "i" before
    // best way to remember constantly used methods
    //  never used in self.buttons before 
    
    for (int i = 0; i < self.numberOFButtons; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setBackgroundColor:[UIColor redColor]];
        button.layer.cornerRadius = ButtonDiameter / 2;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 2.0;
        
        int buttonNumber = i + 1;
        button.tag = buttonNumber;
        
        [button setTitle:[@(buttonNumber) stringValue]
                forState:UIControlStateNormal];
        
        [button addTarget:self
                   action:@selector(buttonWasTapped:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        [self.buttons addObject:button];
    }

}
-(void)randomizedButtonPositions {
    for (int i = 0; i < self.numberOFButtons; i++) {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGRect randomFrame = CGRectMake(arc4random_uniform((int)screenBounds.size.width - ButtonDiameter),
                                        arc4random_uniform((int)screenBounds.size.height - ButtonDiameter),
                                        
                                        ButtonDiameter,
                                        ButtonDiameter);
        
        BOOL collisionWasFound = NO;
        for (UIView *button in self.buttons) {
            if (button == self.buttons[i]) {
                continue;
            }
            
            if (CGRectIntersectsRect(randomFrame, button.frame)) {
                collisionWasFound = YES;
                break;
            }
        }
      
        if (collisionWasFound) {
            i--;
            continue;
        }
        else {
            UIButton *button = self.buttons[i];
            button.frame = randomFrame;
        }
        
    }

}

#pragma mark - View Controller 

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Actions

-(void)buttonWasTapped:(UIButton*)sender {
    NSLog(@"Number %ld was pressed",(long)sender.tag);
    
    if ((self.lastTappedNumber +1) == sender.tag) {
    self.lastTappedNumber++;
    sender.hidden = YES;
    
    if (sender.tag == self.numberOFButtons) {
        self.view.backgroundColor = [UIColor greenColor];
        }
    }
    else {
        [self randomizedButtonPositions];
        self.lastTappedNumber = 0;
        
        for (UIButton *button in self.buttons) {
            button.hidden = NO;
        }
    }



}
@end
