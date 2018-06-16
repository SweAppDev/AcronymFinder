//
//  Acronym.m
//  AcronymFinder
//
//
//
//

#import "Acronym.h"
#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"

@implementation Acronym

- (id)initWithArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        _dataArray = dataArray;
    }
    return self;
}

#pragma mark - Network Call

+ (void) getAbbreviationFor: (NSString *) acronym returnWithCompletion:(void (^) (Acronym *acronymObj, NSError *error)) block {
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@", acronym]];
    
    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
    
    // Configure Request Operation
    [requestOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    requestOperation.responseSerializer.acceptableContentTypes = [requestOperation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([(NSArray*)responseObject count] > 0) {
            // Process Response Object
            NSArray *objArray = [responseObject[0] objectForKey:@"lfs"]; // Number of acronym objects to be retuned..
            NSLog(@"The return array is %@",objArray);
            
            //Initialize the Acronym instance
            Acronym *acronymObj = [[Acronym alloc] initWithArray:objArray];
            acronymObj.acronymString = acronym;
            
            //Call completion block
            block (acronymObj, nil);
        }
        else {
            
            NSString *descString = [NSString stringWithFormat:@"Sorry! No abbreviations found for \"%@\"!",acronym];
            NSLog(@"%@", descString);
            
            //Pass the error from block
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(descString, nil),
                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Data base couldn't locate any related data.", nil),
                                       NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please try looking for other acronyms to test the app.", nil)
                                       };
            NSError *error = [NSError errorWithDomain:@"Nactem Error Domain"
                                                 code:-37
                                             userInfo:userInfo];

            block (nil, error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle Other Errors
        NSLog(@"Error %@", error);
        
        //Return Block
        block (nil, error);
    }];
    
    // Start Request Operation
    [requestOperation start];
}

@end
