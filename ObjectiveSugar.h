//
//  ObjectiveSugar.h
//  ObjectiveSugar
//
//  Created by Marc Palmer on 20/08/2015.
//  Copyright © 2015 supermarin. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ObjectiveSugar.
FOUNDATION_EXPORT double ObjectiveSugarVersionNumber;

//! Project version string for ObjectiveSugar.
FOUNDATION_EXPORT const unsigned char ObjectiveSugarVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ObjectiveSugar/PublicHeader.h>

// C SUGAR
#define unless(condition...) if(!(condition))
#define until(condition...) while(!(condition))

// OBJC SUGAR
#import <ObjectiveSugar/NSNumber+ObjectiveSugar.h>
#import <ObjectiveSugar/NSArray+ObjectiveSugar.h>
#import <ObjectiveSugar/NSMutableArray+ObjectiveSugar.h>
#import <ObjectiveSugar/NSDictionary+ObjectiveSugar.h>
#import <ObjectiveSugar/NSSet+ObjectiveSugar.h>
#import <ObjectiveSugar/NSString+ObjectiveSugar.h>

