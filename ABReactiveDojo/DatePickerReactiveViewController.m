//
//  DatePickerReactiveViewController.m
//  ABReactiveDojo
//
//  Created by Adil BOUGAMZA on 05/06/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "DatePickerReactiveViewController.h"

@interface DatePickerReactiveViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *label;

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
}

- (NSString *) formattedStringFromDate:(NSDate *) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
