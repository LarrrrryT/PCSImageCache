//
//  PCSTableViewController.m
//  LazyLoad
//
//  Created by LT on 6/17/14.
//  Copyright (c) 2014 PCS. All rights reserved.
//

#import "PCSTableViewController.h"
#import "PCSTableViewCell.h"
#import "UIImageView+Download.h"

@interface PCSTableViewController()

@property (nonatomic, strong) NSArray *photosArray;

@end

@implementation PCSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photosArray = @[@"http://a.espncdn.com/photo/2013/0310/nba_wrap_03.jpg",
                         @"http://wallpapertoon.com/wp-content/uploads/2014/06/nba-player-hd-wallpapers.jpg",
                         @"http://www.digitaltrends.com/wp-content/uploads/2013/11/5-apps-all-NBA-basketball-fans-need-on-their-phones.jpg",
                         @"http://i2.cdn.turner.com/si/dam/assets/130504165018-san-antonio-spurs-golden-state-warriors-nba-playoffs-2013-preview-single-image-cut.jpg",
                         @"http://a.espncdn.com/photo/2013/1121/nba_g_andre-iguodala_mb_576x324.jpg",
                         @"http://hornsillustrated.com/wp-content/uploads/2014/06/Kevin-Durant-and-LaMarcus-Aldridge-Earn-Spots-on-All-NBA-Teams.jpg"];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.photosArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PCSTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.mainImageView setImageForUrl:self.photosArray[indexPath.row]];
}

@end
