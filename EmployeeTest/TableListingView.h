//
//  TableListingView.h
//  EmployeeTest
//
//  Created by Luke Dellar on 15/09/2014.
//  Copyright (c) 2014 LDellar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableListingView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tView;
    NSMutableArray *employees;
    NSMutableDictionary *cachedImages;
    
    
    NSArray *teamNodes;
    NSInteger *fileStoredImages;
    UIActivityIndicatorView *spinner;
    NSInteger EmpCount;
}

@property(nonatomic)NSInteger checkforLevel;

@end
