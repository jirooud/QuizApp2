//
//  ResultViewController.h
//  QuizApp2
//
//  Created by bpqd on 2016/01/10.
//  Copyright © 2016年 nakayama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property NSInteger response;

@property (weak, nonatomic) IBOutlet UITextView *result;

- (IBAction)returnButton:(id)sender;

@end
