//
//  DefinitionListViewController.m
//  AcronymFinder
//
//  
//
//

#import "DefinitionListViewController.h"

@interface DefinitionListViewController ()

@end

@implementation DefinitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Data 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_acronymDataObject.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"definitionCell" forIndexPath:indexPath];

    NSDictionary *dict =[_acronymDataObject.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict objectForKey:@"lf"];
    
    cell.detailTextLabel.text = [[dict objectForKey:@"since"] stringValue];
    
    return cell;
}


#pragma mark - Table View Delegates

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [NSString stringWithFormat:@"Definition's' for \"%@\"", _acronymDataObject.acronymString];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    return @"Fullforms of the acronym and the year when the definition appeared for the first time in the corpus. \n\nSource: \"The National Center For Text Mixing.\"";
}

@end
