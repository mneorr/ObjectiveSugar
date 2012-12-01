Objective Sugar is a Ruby-style set of additions / categories for Objective C.
You can get the idea in [this post](http://blog.mneorr.com/2012/11/21/adding-some-ruby-sugar-to-objectivec/).

<br/>

## Installation

__Cocoapods__: `pod 'ObjectiveSugar'` (don't forget to `pod install`)<br/>
__Manual__: Copy the __src__ folder in your project<br/>

`#import "ObjectiveSugar.h"`


#### NSNumber additions

``` objc
[@3 times:^{
  NSLog(@"Hello!");
}];
// Hello!
// Hello!
// Hello!

[@3 timesWithIndex:^(int index) {
  NSLog(@"Another version with number: %d", index);
}];
// Another version with number: 0
// Another version with number: 1
// Another version with number: 2


[@1 upto:4 do:^(int numbah) {
  NSLog(@"Current number.. %d", numbah);        
}];
// Current number.. 1
// Current number.. 2
// Current number.. 3
// Current number.. 4

[@7 downto:4 do:^(int numbah) {
  NSLog(@"Current number.. %d", numbah);        
}];
// Current number.. 7
// Current number.. 6
// Current number.. 5
// Current number.. 4

NSDateFormatter *formatter = [NSDateFormatter new];
[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];            
NSDate *newYearsDay = [formatter dateFromString:@"2013-01-01T00:00:00Z"];
NSDate *result = [@(31).days since:newYearsDay];
// 2013-02-01 00:00:00 +0000

NSDate *future = @(24).days.from_now; // Today is December 1st
// 2012-12-25 20:49:05 +0000

NSDate *past = @(1).month.ago; // Today is December 1st
// 2012-11-01 20:50:28 +00:00

NSDate *result = [@(7).days until:newYearsDay];
// 2012-12-25 00:00:00 +0000

```

#### NSArray / NSSet additions

``` objc
NSArray *cars = [@"Testarossa", @"F50", @"F458 Italia"]; 
// or NSSet *cars = [NSSet setWithObjects:@"Testarossa", @"F50", @"F458 Italia", nil];

[cars each:^(id object) {
    NSLog(@"Car: %@", object); 
}];
// Car: Testarossa
// Car: F50
// Car: F458 Italia

[cars eachWithIndex:^(id object, int index) {    
    NSLog(@"Car: %@ index: %i", object, index); 
}];
// Car: Testarossa index: 0
// Car: F50 index: 1
// Car: F458 Italia index: 2

id object = cars.first; // Testarossa
id object = cars.last;  // 458 Italia

[cars map:^id(id car){
	return @([[car substringToIndex:1] isEqualToString:@"F"]);
}]; 
// NO (Testarossa)
// YES (F50)
// YES (F458 Italia)

```

#### NSArray only
``` objc
NSArray *fruits = @[ @"banana", @"mango", @"apple", @"pear" ];

NSLog(@"Is apple a fruit? %@", [fruits includes:@"apple"] ? @"Yes" : @"No"];
// Is apple a fruit? Yes

[fruits take:3]; 
// banana, mango, apple

[someFruits takeWhile:^BOOL(id fruit) {
	return ![fruit isEqualToString:@"apple"];
}];
// banana, mango


NSArray *landLockedCountries = @[ @"Bolivia", @"Paraguay", @"Austria", @"Switzerland", @"Hungary" ];
NSArray *europeanCountries = @[ @"France", @"Germany", @"Austria", @"Spain", @"Hungary", @"Poland", @"Switzerland" ];


[landlockedCountries intersectionWithArray:europeanCountries];
// landlockedEuropeanCountries = Austria, Switzerland, Hungary

[landlockedCountries unionWithArray:europeanCountries];
// landlockedOrEuropean = Bolivia, Paraguay, Austria, Switzerland, Hungary, France, Germany, Spain, Poland

[landlockedCountries relativeComplement:europeanCountries];
// nonEuropeanLandlockedCountries = Bolivia, Paraguay

[europeanCountries relativeComplement:landlockedCountries];
// notLandlockedEuropeanCountries = France, Germany, Spain, Poland

[landlockedCountries symmetricDifference:europeanCountries];
// uniqueCountries = Bolivia, Paraguay, Austria, Switzerland, Hungary, France, Germany, Spain, Poland


NSArray *mixedData = @[ @1, @"Objective Sugar!", @"Github", @4, @"5"];

[mixedData select:^BOOL(id object) {
	return ([object class] == [NSString class]);
}];
// Objective Sugar, Github, 5

[mixedData reject:^BOOL(id object) {
	return ([object class] == [NSString class]);
}];
// 1, 4

NSArray *nestedArray = @[ @[ @1, @2, @3 ], @[ @4, @5, @6, @[ @7, @8 ] ], @9, @10 ];
[nestedArray flatten];
// 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

NSArray *abc = @[ @"a", @"b", @"c" ];
[abc join];
// abc

[abc join:@"-"];
// a-b-c

```

#### NSMutableArray additions

``` objc
NSMutableArray *people = @[ @"Alice", @"Benjamin", @"Christopher" ];

[people push:@"Daniel"]; // Alice, Benjamin, Christopher, Daniel

[people pop]; // Daniel
// people = Alice, Benjamin, Christopher

[people pop:2]; // Benjamin, Christopher
// people = Alice

[people concat:@[ @"Evan", @"Frank", @"Gavin" ]];
// people = Alice, Evan, Frank, Gavin

```

#### NSDictionary additions

``` objc
NSDictionary *dict = @{ @"one" : @1, @"two" : @2, @"three" : @3 };

[dict each:^(id key, id value){
    NSLog(@"Key: %@, Value: %@", key, value);
}];
// Key: one, Value: 1
// Key: two, Value: 2
// Key: three, Value: 3

[dict eachKey:^(id key) {
    NSLog(@"Key: %@", key);
}];
// Key: one
// Key: two
// Key: three

[dict eachValue:^(id value) {
    NSLog(@"Value: %@", value);
}];
// Value: 1
// Value: 2
// Value: 3
```

### Contributing

ObjectiveSugar is tested with [Kiwi](https://github.com/allending/Kiwi), and tests are located in SampleProject.<br/>
If you plan on contributing to the project, please:

  * Write tests
  * Write documentation
