//
//  GenericHelper.h
//  Objective Sugar
//
//  Created by Tom Quist on 15.12.15.
//
//

#if __has_feature(objc_generics)
#   define __OBJECTIVE_SUGAR_GENERICS(class, ...)      class<__VA_ARGS__>
#   define __OBJECTIVE_SUGAR_GENERICS_TYPE(type)       type
#else
#   define __OBJECTIVE_SUGAR_GENERICS(class, ...)      class
#   define __OBJECTIVE_SUGAR_GENERICS_TYPE(type)       id
#endif

#if !(__has_feature(nullability))
#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define nullable
#define __nullable
#endif
