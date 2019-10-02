//
//  EventTableViewCell.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "EventTableViewCell.h"
#import "Event.h"

@interface EventTableViewCell ()

/** A label that displays a string representing the title of the event. */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** A label that displays a string representing the duration of the event. */
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation EventTableViewCell

#pragma mark - Methods

- (void)populateWithEvent:(Event *)event
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-d HH:mm"];
    
    NSDate *startDate = [dateFormatter dateFromString:event.startDate];
    NSDate *endDate = [dateFormatter dateFromString:event.endDate];
    
    // Convert to the new date format.
    [dateFormatter setLocalizedDateFormatFromTemplate:@"MMMM d"];
    NSString *startDateString = [dateFormatter stringFromDate:startDate];

    // Convert the new date format, again.
    [dateFormatter setLocalizedDateFormatFromTemplate:@"HH:mm"];
    NSString *startHour = [dateFormatter stringFromDate:startDate];
    NSString *endHour = [dateFormatter stringFromDate:endDate];
    
    NSString *durationString = [NSString stringWithFormat:NSLocalizedString(@"fromTo", NULL), startHour, endHour];
    
    // Populate the labels...
    [self.titleLabel setText:[[event.title lowercaseString] capitalizedString]];
    [self.durationLabel setText:[NSString stringWithFormat:@"%@, %@", startDateString, [durationString lowercaseString]]];
}

@end

