//
//  gameViewController.h
//  ingo
//
//  Created by 一野哲也 on 2015/08/03.
//  Copyright (c) 2015年 TetsuyaIchino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "game2Viewcontroller.h"


@interface gameViewController : UIViewController{

}

@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIButton *answerAButton;
- (IBAction)tapABtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *answerBButton;
- (IBAction)tapBBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *answerCButton;
- (IBAction)tapCBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *answerDButton;
- (IBAction)tapDBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *correctAnswerLabel;

@property (weak, nonatomic) IBOutlet UILabel *incorrectAnswerLabel;

@end

