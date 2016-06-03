//
//  TextFieldReactiveViewController.m
//  ABReactiveDojo
//
//  Created by Adil BOUGAMZA on 03/06/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "TextFieldReactiveViewController.h"

@interface TextFieldReactiveViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;

@end

@implementation TextFieldReactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // get textField signal
    RACSignal *textSignal =  [self.textField rac_textSignal];

    // assign the typed string directly to the first label
    RAC(self.label,text) = textSignal;

    // filter only length > 3 and assign to second label
    RAC(self.filterLabel,text) = [textSignal filter:^BOOL(NSString *value) {
        return value.length > 3;
    }];

    // map value and put it inbetween -- %@ -- and assign to third label
    RAC(self.mapLabel, text) = [textSignal map:^id(NSString *value) {
        return [NSString stringWithFormat:@"-- %@ --",value];
    }];

    // if user types one of the color names => the view background should change to that color
    RAC(self.view,backgroundColor) = [textSignal map:^id(NSString *value) {
        // map the color string to a UIColor
        return [self getColorForText:value];
    }];
}

-(UIColor *) getColorForText:(NSString *) colorText
{
    if ([colorText.uppercaseString isEqualToString:@"RED"]) {
        return  [UIColor redColor];
    } else if ([colorText.uppercaseString isEqualToString:@"BLUE"]) {
        return  [UIColor blueColor];
    } else if ([colorText.uppercaseString isEqualToString:@"GREEN"]) {
        return  [UIColor greenColor];
    } else if ([colorText.uppercaseString isEqualToString:@"GRAY"]) {
        return  [UIColor grayColor];
    } else if ([colorText.uppercaseString isEqualToString:@"ORANGE"]) {
        return  [UIColor orangeColor];
    } else if ([colorText.uppercaseString isEqualToString:@"YELLOW"]) {
        return  [UIColor yellowColor];
    }

    return [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
