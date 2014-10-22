//
//  CBViewController.m
//  SearchDisplayControllerDemo
//
//  Created by Joshua Howlandon 06/09/13.
//  Copyright (c) 2013 DevMountain. All rights reserved.
//

#import "CBViewController.h"
#import "CBObjectController.h"

@interface CBViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *filteredObjects;

@property (nonatomic, strong) IBOutlet UISearchBar* searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation CBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filteredObjects = [NSMutableArray new];
    
    self.searchBar.delegate = self;

    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        return [CBObjectController objects].count;
    
    } else {
        return self.filteredObjects.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.tableView) {
        cell.textLabel.text = [CBObjectController objects][indexPath.row];
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = self.filteredObjects[indexPath.row];
    }
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    [self.filteredObjects removeAllObjects];
    for (NSString *object in [CBObjectController objects]) {
        if ([object rangeOfString:searchText].location != NSNotFound) {
            [self.filteredObjects addObject:object];
        }
    }
}


@end
