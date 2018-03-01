//
//  ViewController.m
//  GithubRepos
//
//  Created by Chris Dean on 2018-03-01.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "ViewController.h"
#import "repoObject.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *arrayOfRepos;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.arrayOfRepos = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/ChrisJohnDean/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        for(NSDictionary *repo in repos) {
            //- (instancetype)initWithName:(NSString*)name withID:(NSString*)repoID withFullName:(NSString*)full_name
            repoObject *myRepo = [[repoObject alloc] initWithName:repo[@"name"] withID:repo[@"id"] withFullName:repo[@"full_name"]];
            [self.arrayOfRepos addObject:myRepo];
            NSLog(@"repo: %@", repo[@"name"]);
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
        
    }];
    
    [dataTask resume];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfRepos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    repoObject *myRepo = [[repoObject alloc] init];
    myRepo = [self.arrayOfRepos objectAtIndex:indexPath.row];
    cell.textLabel.text = myRepo.name;
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
