//
//  ViewController.m
//  Touch of Class
//
//  Created by Jay Versluis on 29/09/2015.
//  Copyright © 2015 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UILabel *forceLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // if 3D Touch is not available, remove label
    if (self.traitCollection.forceTouchCapability != UIForceTouchCapabilityAvailable) {
        self.forceLabel.text = @"Force: n/a";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)trackTouch:(UITouch *)touch {
    
    // track the current position
    CGPoint position = [touch locationInView:self.view];
    NSString *xPosition = [NSString stringWithFormat:@"%f", position.x];
    NSString *yPosition = [NSString stringWithFormat:@"%f", position.y];
    
    // update position labels
    NSString *positionText = [NSString stringWithFormat:@"X = %@ / Y = %@", xPosition, yPosition];
    self.positionLabel.text = positionText;
    
    // update force label (if 3D Touch is available
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        self.forceLabel.text = [NSString stringWithFormat:@"Force: %f", touch.force];
    }
}

#pragma mark - Responders

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self handleTouches:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self handleTouches:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self handleTouches:touches withEvent:event];
}



- (void)handleTouches:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // is it a touch?
    if (event.type == UIEventTypeTouches) {
        
        // for each touch update the label
        for (UITouch *currentTouch in touches) {
            [self trackTouch:currentTouch];
        }
    }
}

@end
