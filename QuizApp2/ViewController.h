//
//  ViewController.h
//  QuizApp2
//
//  Created by bpqd on 2016/01/10.
//  Copyright © 2016年 nakayama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *problem;

- (IBAction)circleButton:(id)sender;

- (IBAction)crossButton:(id)sender;

@end

