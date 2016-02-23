//
//  FavoritesTableViewController.m
//  Smaato
//
//  Created by Bruno Rocha on 2/23/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "CoreDataManager.h"
#import "TextTableViewCell.h"
#import "ImageTableViewCell.h"
#import "SmaatoContent.h"

@interface FavoritesTableViewController ()

@property (strong) NSArray *data;

@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [[CoreDataManager manager] fetchObjects];
    
    self.title = @"Favorites";
    
    [self.tableView reloadData];

}


#pragma mark - 
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SmaatoContent *content = _data[indexPath.row];
    
    if ([content.type isEqualToString: @"img"]) {
        
        ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ImageTableViewCell"];
        
        cell.picture.image = [UIImage imageWithData: content.image];
        cell.userLabel.text = [NSString stringWithFormat: @"Name: %@ Country: %@", content.name, content.country];
        
        return cell;
        
    } else  {
        
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TextTableViewCell"];
        cell.userLabel.text = [NSString stringWithFormat: @"Name: %@ Country: %@", content.name, content.country];
        cell.descriptionLabel.text = content.text;
        
        return cell;
        
    }
    
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
