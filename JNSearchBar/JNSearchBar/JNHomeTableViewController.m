//
//  JNHomeTableViewController.m
//  JNSearchBar
//
//  Created by Jiangergo Pk Czt on 16/10/9.
//  Copyright © 2016年 jiangergo. All rights reserved.
//

#import "JNHomeTableViewController.h"
#import "JNResultTableViewController.h"

static NSString *reuseID = @"cell";

@interface JNHomeTableViewController ()<UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UISearchController *searchVc;

@property (nonatomic, strong) JNResultTableViewController *resultVc;

@end

@implementation JNHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArray = [NSMutableArray arrayWithCapacity:100];
    
    for (NSInteger i = 0; i < 100; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%zd - jiangergo",i]];
    }
    
    _resultVc = [[JNResultTableViewController alloc]init];
    
    _searchVc = [[UISearchController alloc]initWithSearchResultsController:_resultVc];
    _searchVc.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    
    self.tableView.tableHeaderView = self.searchVc.searchBar;
    
    self.searchVc.searchResultsUpdater = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    // 谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c]%@",self.searchVc.searchBar.text];
    
    // 过滤
    NSArray *resultArray = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    
    self.resultVc.searchList = resultArray;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
