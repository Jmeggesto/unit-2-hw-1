//
//  InstagramTableViewController.m
//  TalkinToTheNet
//
//  Created by Jackie Meggesto on 9/24/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramTableViewController.h"
#import "InstagramTableViewCell.h"
#import "APIManager.h"
#import "InstagramObject.h"

@interface InstagramTableViewController ()

@end

@implementation InstagramTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Instagram results for %@", self.searchString];
}
-(void)viewWillAppear:(BOOL)animated {
    
    [self makeNewRequestWithSearchTerm:self.searchString callBackBlock:^{
       
        [self.tableView reloadData];
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.instagramPostArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InstagramTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstagramCell" forIndexPath:indexPath];
    
    InstagramObject *post = self.instagramPostArray[indexPath.row];
    
    cell.username1.text = post.userName;
    cell.username2.text = post.userName;
    cell.profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.profilePicString]]];
    cell.contentImage.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.contentPicString]]];
    
    return cell;

}
-(void)makeNewRequestWithSearchTerm:(NSString*)searchTerm callBackBlock:(void(^)())callBackBlock  {
    
    
    //search term
    //url (media = music, term = searchTerm
    NSString *URLString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067", self.searchString];
    NSString *encodedString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *requestURL = [NSURL URLWithString:encodedString];
    
    [APIManager GETRequestWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        if (data != nil){
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *results = json[@"data"];

            
            self.instagramPostArray = [[NSMutableArray alloc]init];
            
            for(NSDictionary *result in results){
             
                
                InstagramObject *instagramPost = [[InstagramObject alloc]initWithJSON:result];
              
                
                
                
                [self.instagramPostArray addObject:instagramPost];
                
                
            }
            
            callBackBlock();
        }
        
    }];
    
}


 
@end
