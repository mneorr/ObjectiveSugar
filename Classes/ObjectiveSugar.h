// C SUGAR
#define unless(condition...) if(!(condition))
#define until(condition...) while(!(condition))

#define YES_OR_NO(boolean) ((boolean) ? @"YES" : @"NO")

// OBJC SUGAR
#import "NSNumber+ObjectiveSugar.h"
#import "NSArray+ObjectiveSugar.h"
#import "NSMutableArray+ObjectiveSugar.h"
#import "NSDictionary+ObjectiveSugar.h"
#import "NSSet+ObjectiveSugar.h"
#import "NSString+ObjectiveSugar.h"
