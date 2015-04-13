//
//  NSDate+ObjectiveSugar.h
//  Objective Sugar
//
//  Created by Casey Borders on 4/9/15.
//

#import "NSDate+ObjectiveSugar.h"
#import "NSNumber+ObjectiveSugar.h"

@implementation NSDate (ObjectiveSugar)

- (NSInteger)year
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    NSInteger year = [components year];
    return year;
}

- (NSInteger)month
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    NSInteger month = [components month];
    return month;
}

- (NSInteger)day
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    NSInteger day = [components day];
    return day;
}

- (NSInteger)hours
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:self];
    NSInteger hours = [components hour];
    return hours;
}

- (NSInteger)minutes
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMinuteCalendarUnit fromDate:self];
    NSInteger minutes = [components minute];
    return minutes;
}

- (NSInteger)seconds
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:self];
    NSInteger seconds = [components second];
    return seconds;
}

- (NSInteger)weekOfYear
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekOfYearCalendarUnit fromDate:self];
    NSInteger weekOfYear = [components weekOfYear];
    return weekOfYear;
}

- (NSInteger)weekOfMonth
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekOfMonthCalendarUnit fromDate:self];
    NSInteger weekOfMonth = [components weekOfMonth];
    return weekOfMonth;
}

- (NSInteger)dayOfYear
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger dayOfYear = [gregorian ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:self];
    return dayOfYear;
}

- (NSInteger)dayOfWeek
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger dayOfWeek = [components weekday];
    return dayOfWeek;
}

- (NSDateComponents *)components
{
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:units fromDate:self];
    return components;
}

- (BOOL)isAfter:(NSDate *)date
{
    BOOL isAfter = [self compare:date] == NSOrderedDescending;
    return isAfter;
}

- (BOOL)isBefore:(NSDate *)date
{
    BOOL isBefore = [self compare:date] == NSOrderedAscending;
    return isBefore;
}

- (BOOL)isOnOrAfter:(NSDate *)date
{
    BOOL isOnOrAfter = [self compare:date] == NSOrderedDescending || [date compare:self] == NSOrderedSame;
    return isOnOrAfter;
}

- (BOOL)isOnOrBefore:(NSDate *)date
{
    BOOL isOnOrBefore = [self compare:date] == NSOrderedAscending || [self compare:date] == NSOrderedSame;
    return isOnOrBefore;
}

- (BOOL)isInSameYear:(NSDate *)date
{
    BOOL sameYear = [self year] == [date year];
    return sameYear;
}

- (BOOL)isInSameMonth:(NSDate *)date
{
    BOOL sameMonth = [self isInSameYear:date] &&
                     [self month] == [date month];
    return sameMonth;
}

- (BOOL)isInSameWeek:(NSDate *)date
{
    BOOL sameWeek = [self isInSameMonth:date] &&
                    [self weekOfMonth] == [date weekOfMonth];
    return sameWeek;
}

- (BOOL)isOnSameDay:(NSDate *)date
{
    BOOL sameDay = [self isInSameMonth:date] &&
                   [self day] == [date day];
    return sameDay;
}

- (BOOL)isInSameHour:(NSDate *)date
{
    BOOL sameHour = [self isOnSameDay:date] &&
                    [self hours] == [date hours];
    return sameHour;
}

- (BOOL)isBetween:(NSDate *)date1 and:(NSDate *)date2
{
    BOOL isBetweenDates = ([self isOnOrAfter:date1] && [self isOnOrBefore:date2]) ||
                          ([self isOnOrAfter:date2] && [self isOnOrBefore:date1]);
    
    return isBetweenDates;
}

- (BOOL)isAtLeast:(NSNumber *)time from:(NSDate *)date
{
    BOOL atLeast = [self isOnOrBefore:[time until:date]] &&
                   [self isOnOrAfter:[time since:date]];
    return atLeast;
}

- (BOOL)isMoreThan:(NSNumber *)time from:(NSDate *)date
{
    BOOL moreThan = [self isBefore:[time until:date]] &&
                    [self isAfter:[time since:date]];
    return moreThan;
}

- (BOOL)isLessThan:(NSNumber *)time from:(NSDate *)date
{
    BOOL lessThan = [self isOnOrAfter:[time until:date]] &&
                    [self isOnOrBefore:[time since:date]];
    return lessThan;
}

- (BOOL)isAtLeast:(NSNumber *)time before:(NSDate *)date
{
    BOOL before = [self isOnOrBefore:[time until:date]];
    return before;
}

- (BOOL)isMoreThan:(NSNumber *)time before:(NSDate *)date
{
    BOOL before = [self isBefore:[time until:date]];
    return before;
}

- (BOOL)isLessThan:(NSNumber *)time before:(NSDate *)date
{
    BOOL after = [self isAfter:[time until:date]] &&
                 ![self isAfter:date];
    return after;
}

- (BOOL)isAtLeast:(NSNumber *)time after:(NSDate *)date
{
    BOOL after = [self isOnOrAfter:[time since:date]];
    return after;
}

- (BOOL)isMoreThan:(NSNumber *)time after:(NSDate *)date
{
    BOOL after = [self isAfter:[time since:date]];
    return after;
}

- (BOOL)isLessThan:(NSNumber *)time after:(NSDate *)date
{
    BOOL before = [self isBefore:[time since:date]] &&
                  ![self isBefore:date];
    return before;
}

- (NSInteger)yearsUntil:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self toDate:date options:0];
    NSInteger years = [components year];
    return years;
}

- (NSInteger)monthsUntil:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self toDate:date options:0];
    NSInteger months = [components month];
    return months;
}

- (NSInteger)daysUntil:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self toDate:date options:0];
    NSInteger days = [components day];
    return days;
}

- (NSInteger)hoursUntil:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:self toDate:date options:0];
    NSInteger hours = [components hour];
    return hours;
}

- (NSInteger)secondsUntil:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:self toDate:date options:0];
    NSInteger seconds = [components second];
    return seconds;
}

- (NSInteger)yearsSince:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:date toDate:self options:0];
    NSInteger years = [components year];
    return years;
}

- (NSInteger)monthsSince:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:date toDate:self options:0];
    NSInteger months = [components month];
    return months;
}

- (NSInteger)daysSince:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:date toDate:self options:0];
    NSInteger days = [components day];
    return days;
}

- (NSInteger)hoursSince:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:date toDate:self options:0];
    NSInteger hours = [components hour];
    return hours;
}

- (NSInteger)secondsSince:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:date toDate:self options:0];
    NSInteger seconds = [components second];
    return seconds;
}

@end
