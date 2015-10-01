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
@property (strong, nonatomic) IBOutlet UISwitch *precisionSwitch;
@property (strong, nonatomic) IBOutlet UILabel *touchTypeLabel;


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
    CGPoint position;
    NSString *xPosition;
    NSString *yPosition;
    
    if (self.precisionSwitch.on) {
        
        // use precise location (iOS 9.1 and above)
        position = [touch preciseLocationInView:self.view];
        xPosition = [NSString stringWithFormat:@"%f", position.x];
        yPosition = [NSString stringWithFormat:@"%f", position.y];
    
    } else {
        
        // use regular precision (iOS 9.0 and lower)
        position = [touch locationInView:self.view];
        xPosition = [NSString stringWithFormat:@"%f", position.x];
        yPosition = [NSString stringWithFormat:@"%f", position.y];
    }
    
    // update position labels
    NSString *positionText = [NSString stringWithFormat:@"Position: X = %@ / Y = %@", xPosition, yPosition];
    self.positionLabel.text = positionText;
    
    // update force label (if 3D Touch is available)
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        self.forceLabel.text = [NSString stringWithFormat:@"Force: %f", touch.force];
    }
    
    // update touch type label
    // how did the user touch the screen?
    if (touch.type == UITouchTypeDirect) {
        self.touchTypeLabel.text = @"Touch Type: Finger";
    }

    if (touch.type == UITouchTypeIndirect) {
        self.touchTypeLabel.text = @"Touch Type: Indirect";
    }

    if (touch.type == UITouchTypeStylus) {
        self.touchTypeLabel.text = @"Touch Type: Apple Pencil";
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
