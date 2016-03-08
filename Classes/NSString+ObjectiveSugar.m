//
//  NSString+ObjectiveSugar.m
//  SampleProject
//
//  Created by Neil on 05/12/2012.
//  Copyright (c) 2012 @supermarin | supermar.in. All rights reserved.
//

#import "NSArray+ObjectiveSugar.h"
#import "NSString+ObjectiveSugar.h"

static NSString *const UNDERSCORE = @"_";
static NSString *const SPACE = @" ";
static NSString *const EMPTY_STRING = @"";

NSString *NSStringWithFormat(NSString *formatString, ...) {
  va_list args;
  va_start(args, formatString);

  NSString *string =
      [[NSString alloc] initWithFormat:formatString arguments:args];

  va_end(args);

#if defined(__has_feature) && __has_feature(objc_arc)
  return string;
#else
  return [string autorelease];
#endif
}

@implementation NSString (Additions)

- (NSArray *)split {
  NSArray *result =
      [self componentsSeparatedByCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
  return [result select:^BOOL(NSString *string) {
    return string.length > 0;
  }];
}

- (NSArray *)split:(NSString *)delimiter {
  return [self componentsSeparatedByString:delimiter];
}

- (NSString *)camelCase {
  NSString *spaced =
      [self stringByReplacingOccurrencesOfString:UNDERSCORE withString:SPACE];
  NSString *capitalized = [spaced capitalizedString];

  return [capitalized stringByReplacingOccurrencesOfString:SPACE
                                                withString:EMPTY_STRING];
}

- (NSString *)lowerCamelCase {
  NSString *upperCamelCase = [self camelCase];
  NSString *firstLetter = [upperCamelCase substringToIndex:1];
  return [upperCamelCase
      stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                              withString:firstLetter.lowercaseString];
}

- (BOOL)containsString:(NSString *)string {
  NSRange range = [self rangeOfString:string options:NSCaseInsensitiveSearch];
  return range.location != NSNotFound;
}

- (NSString *)strip {
  return [self
      stringByTrimmingCharactersInSet:[NSCharacterSet
                                          whitespaceAndNewlineCharacterSet]];
}

- (NSString *)match:(NSString *)pattern {
  NSRegularExpression *regex =
      [NSRegularExpression regularExpressionWithPattern:pattern
                                                options:0
                                                  error:nil];
  NSTextCheckingResult *match =
      [regex firstMatchInString:self
                        options:0
                          range:NSMakeRange(0, self.length)];

  return (match != nil) ? [self substringWithRange:[match range]] : nil;
}

- (id)toJSON {
  NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
  id JSON = [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingAllowFragments
                                              error:nil];
  return JSON;
}

- (NSString *)language {
  NSArray *tagschemes =
      [NSArray arrayWithObjects:NSLinguisticTagSchemeLanguage, nil];
  NSLinguisticTagger *tagger =
      [[NSLinguisticTagger alloc] initWithTagSchemes:tagschemes options:0];
  [tagger setString:self];
  NSString *language = [tagger tagAtIndex:0
                                   scheme:NSLinguisticTagSchemeLanguage
                               tokenRange:NULL
                            sentenceRange:NULL];
  return language;
}

- (double)multipleLinesHeightForWidth:(double)width font:(UIFont *)font {
  CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{
                                  NSFontAttributeName : font
                                }
                                   context:nil];
  return rect.size.height;
}

- (double)dynamicWidthForHeight:(double)height font:(UIFont *)font {
  CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{
                                  NSFontAttributeName : font
                                }
                                   context:nil];
  return rect.size.width;
}

- (NSString *)unescapedUnicodeString {
  NSString *string = [NSString stringWithString:self];
  // unescape quotes and backwards slash and slash
  NSString *unescapedString = [string
      stringByReplacingOccurrencesOfString:@"\\\""
                                withString:@"\""]; /*          Replaces \"
                                                    with "              */
  unescapedString = [unescapedString
      stringByReplacingOccurrencesOfString:@"\\\\"
                                withString:@"\\"]; /*          Replaces \\
                                                    with \              */
  unescapedString =
      [unescapedString
          stringByReplacingOccurrencesOfString:@"\\/"
                                    withString:@"/"]; /*          Replaces \/
                                                         with / */

  // tokenize based on unicode escape char
  NSMutableString *tokenizedString = [NSMutableString string];
  NSScanner *scanner = [NSScanner scannerWithString:unescapedString];
  while ([scanner isAtEnd] == NO) {
    // read up to the first unicode marker
    // if a string has been scanned, it's a token
    // and should be appended to the tokenized string
    NSString *token = @"";
    [scanner scanUpToString:@"\\u" intoString:&token];
    if (token != nil && token.length > 0) {
      [tokenizedString appendString:token];
      continue;
    }

    // skip two characters to get past the marker
    // check if the range of unicode characters is
    // beyond the end of the string (could be malformed)
    // and if it is, move the scanner to the end
    // and skip this token
    NSUInteger location = [scanner scanLocation];
    NSInteger extra = scanner.string.length - location - 4 - 2;
    if (extra < 0) {
      NSRange range = {location, -extra};
      [tokenizedString appendString:[scanner.string substringWithRange:range]];
      [scanner setScanLocation:location - extra];
      continue;
    }

    // move the location pas the unicode marker
    // then read in the next 4 characters
    location += 2;
    NSRange range = {location, 4};
    token = [scanner.string substringWithRange:range];
    unichar codeValue = (unichar)strtol([token UTF8String], NULL, 16);
    [tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];

    // move the scanner past the 4 characters
    // then keep scanning
    location += 4;
    [scanner setScanLocation:location];
  }

  // done
  return tokenizedString;
}

- (NSString *)escapedUnicodeString {
  // lastly escaped quotes and back slash
  // note that the backslash has to be escaped before the quote
  // otherwise it will end up with an extra backslash
  NSString *string = [NSString stringWithString:self];
  NSString *escapedString =
      [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
  escapedString = [escapedString stringByReplacingOccurrencesOfString:@"\""
                                                           withString:@"\\\""];

  // convert to encoded unicode
  // do this by getting the data for the string
  // in UTF16 little endian (for network byte order)
  NSData *data =
      [escapedString dataUsingEncoding:NSUTF16LittleEndianStringEncoding
                  allowLossyConversion:YES];
  size_t bytesRead = 0;
  const char *bytes = data.bytes;
  NSMutableString *encodedString = [NSMutableString string];

  // loop through the byte array
  // read two bytes at a time, if the bytes
  // are above a certain value they are unicode
  // otherwise the bytes are ASCII characters
  // the %C format will write the character value of bytes
  while (bytesRead < data.length) {
    uint16_t code = *((uint16_t *)&bytes[bytesRead]);
    if (code > 0x007E) {
      [encodedString appendFormat:@"\\u%04X", code];
    } else {
      [encodedString appendFormat:@"%C", code];
    }
    bytesRead += sizeof(uint16_t);
  }
  // done
  return encodedString;
}

- (NSString *)URLEncodedString {
  __autoreleasing NSString *encodedString;
  NSString *originalString = (NSString *)self;
  encodedString =
      (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
          NULL, (__bridge CFStringRef)originalString, NULL,
          (CFStringRef) @":!*();@/&?#[]+$,='%’\"", kCFStringEncodingUTF8);
  return encodedString;
}

- (NSString *)URLDecodedString {
  __autoreleasing NSString *decodedString;
  NSString *originalString = (NSString *)self;
  decodedString = (__bridge_transfer NSString *)
      CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
          NULL, (__bridge CFStringRef)originalString, CFSTR(""),
          kCFStringEncodingUTF8);
  return decodedString;
}

- (NSString *)trim {
  return [self
      stringByTrimmingCharactersInSet:[NSCharacterSet
                                          whitespaceAndNewlineCharacterSet]];
}

@end
