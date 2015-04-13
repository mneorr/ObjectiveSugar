@interface NSDate (ObjectiveSugar)

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hours;
- (NSInteger)minutes;
- (NSInteger)seconds;
- (NSInteger)weekOfYear;
- (NSInteger)weekOfMonth;
- (NSInteger)dayOfYear;
- (NSInteger)dayOfWeek;
- (NSDateComponents *)components;

- (BOOL)isAfter:(NSDate *)date;
- (BOOL)isBefore:(NSDate *)date;
- (BOOL)isOnOrAfter:(NSDate *)date;
- (BOOL)isOnOrBefore:(NSDate *)date;
- (BOOL)isInSameYear:(NSDate *)date;
- (BOOL)isInSameMonth:(NSDate *)date;
- (BOOL)isInSameWeek:(NSDate *)date;
- (BOOL)isOnSameDay:(NSDate *)date;
- (BOOL)isInSameHour:(NSDate *)date;

- (BOOL)isBetween:(NSDate *)date1 and:(NSDate *)date2;

- (BOOL)isAtLeast:(NSNumber *)time from:(NSDate *)date;
- (BOOL)isMoreThan:(NSNumber *)time from:(NSDate *)date;
- (BOOL)isLessThan:(NSNumber *)time from:(NSDate *)date;

- (BOOL)isAtLeast:(NSNumber *)time before:(NSDate *)date;
- (BOOL)isMoreThan:(NSNumber *)time before:(NSDate *)date;
- (BOOL)isLessThan:(NSNumber *)time before:(NSDate *)date;

- (BOOL)isAtLeast:(NSNumber *)time after:(NSDate *)date;
- (BOOL)isMoreThan:(NSNumber *)time after:(NSDate *)date;
- (BOOL)isLessThan:(NSNumber *)time after:(NSDate *)date;

- (NSInteger)yearsUntil:(NSDate *)date;
- (NSInteger)monthsUntil:(NSDate *)date;
- (NSInteger)daysUntil:(NSDate *)date;
- (NSInteger)hoursUntil:(NSDate *)date;
- (NSInteger)secondsUntil:(NSDate *)date;

- (NSInteger)yearsSince:(NSDate *)date;
- (NSInteger)monthsSince:(NSDate *)date;
- (NSInteger)daysSince:(NSDate *)date;
- (NSInteger)hoursSince:(NSDate *)date;
- (NSInteger)secondsSince:(NSDate *)date;

@end
