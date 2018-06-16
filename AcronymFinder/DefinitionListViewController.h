//
//  DefinitionListViewController.h
//  AcronymFinder
//
//  
//
//

#import <UIKit/UIKit.h>
#import "Acronym.h"

@interface DefinitionListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *definitionTableView;

@property (strong, nonatomic) Acronym *acronymDataObject;

@end
