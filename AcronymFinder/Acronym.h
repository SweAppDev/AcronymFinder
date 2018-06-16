//
//  Acronym.h
//  AcronymFinder
//
//  
//
//

#import <Foundation/Foundation.h>

@interface Acronym : NSObject

/**
 This array is used as the data source that is displayed as rows in the table view
 */
@property (nonatomic, strong, readonly) NSArray *dataArray;

@property (nonatomic, strong) NSString *acronymString;

+ (void) getAbbreviationFor: (NSString *) acronymText returnWithCompletion:(void (^) (Acronym *acronymObj, NSError *error)) block;

@end
