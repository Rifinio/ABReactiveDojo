//
//  DatePickerReactiveViewController.m
//  ABReactiveDojo
//
//  Created by Adil BOUGAMZA on 05/06/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "DatePickerReactiveViewController.h"
#import "NSDate+Additions.h"

@interface DatePickerReactiveViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *labelCounter;

@end

@implementation DatePickerReactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.datePicker setDatePickerMode:UIDatePickerModeDate];

    // get a date picker signal
    RACSignal *datePickerSignal = [self.datePicker rac_newDateChannelWithNilValue:[NSDate date]];

    // bind the signal to the text filed text
    RAC(self.label, text) = [[datePickerSignal map:^id(NSDate *date) {
        // format the date selected
        return [self formattedStringFromDate:date];
    }] startWith:[self formattedStringFromDate:[NSDate date]]];

    // Create a signal that sends values (dates) each second
    RACSignal *secondsSignal = [[[RACSignal interval:1.0
                                       onScheduler:[RACScheduler mainThreadScheduler]]
                                doNext:^(id x) {
                                    NSLog(@"seconds signal value :%@",x);
                                }] replayLast];

    // we get the seconds signal and format it to show the seconds
    RAC(self.labelCounter, text) = [[secondsSignal map:^id(NSDate *date) {
        return [date seconds];
        // StartWith will give a starting value when the view just shows
    }] startWith:[[NSDate date] seconds]];


    // Depending on the number of seconds if it's Odd or Even
    // we change the background color
    RAC(self.view, backgroundColor) = [[secondsSignal map:^id(NSDate *date) {
        return [self getColorFromSeconds:date];
    }] startWith:[self getColorFromSeconds:[NSDate date]]];
}

- (NSString *) formattedStringFromDate:(NSDate *) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (UIColor *) getColorFromSeconds:(NSDate *) date
{
    NSInteger seconds = [[date seconds] integerValue];

    if (seconds%2)  {
        return [UIColor orangeColor];
    }
    else {
        return [UIColor cyanColor];
    }
}

@end
