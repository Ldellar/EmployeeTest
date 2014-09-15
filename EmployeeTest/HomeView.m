//
//  HomeView.m
//  EmployeeTest
//
//  Created by Luke Dellar on 15/09/2014.
//  Copyright (c) 2014 LDellar. All rights reserved.
//

#import "HomeView.h"
#import "DBManager.h"
#import "EmployeeL1.h"
#import "EmployeeL2.h"
#import "TableListingView.h"

@implementation HomeView

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // FOR LEVEL 1 JUST AS A TEST ADD A EMPLOYEE TO THE TABLE
    if([DBManager EmployeeL1ExistswithName:@"Will Thomas" andJobtitle:@"Engineering"])
    {
        
    }
    else
    {
        [DBManager addEmployeeL1withName:@"Will Thomas" andTitle:@"Engineering" withBio:@"After graduating from the University of Bath with a degree in Computer Information Systems, Will worked as a software developer at Lehman Brothers and UBS AG. At The App Business Will specialises in web development and object-oriented design and enjoys travelling and cheering on Gillingham FC in his spare time." withInternalImageCacheLink:@"http://1.gravatar.com/avatar/91fc34d9b33139db08bcc6f4d8ee2a3a?s=336&d=http"];
    }
    
    NSMutableArray *arr = [DBManager getallEmployeesL1];
    EmployeeL1 *emp1 = [arr objectAtIndex:0];
    NSLog(@"%@ - %lu",emp1.name, (unsigned long)arr.count);
    
    UIButton *l1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [l1 setTitle:@"Level 1 - NO PARSING" forState:UIControlStateNormal];
    [l1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [l1 setBackgroundColor:[UIColor whiteColor]];
    [l1 addTarget:self action:@selector(L1EmployeeList) forControlEvents:UIControlEventTouchUpInside];
    [l1 setFrame:CGRectMake(10, 50, [[UIScreen mainScreen] bounds].size.width-20, 200)];
    [self.view addSubview:l1];
    
    UIButton *l2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [l2 setTitle:@"Level 2 - PARSING" forState:UIControlStateNormal];
    [l2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [l2 setBackgroundColor:[UIColor whiteColor]];
    [l2 addTarget:self action:@selector(L2EmployeeList) forControlEvents:UIControlEventTouchUpInside];
    [l2 setFrame:CGRectMake(10, 260, [[UIScreen mainScreen] bounds].size.width-20, 200)];
    [self.view addSubview:l2];
}

-(void)L1EmployeeList
{
    TableListingView *listView = [[TableListingView alloc]init];
    listView.checkforLevel = 1;
    [self.navigationController pushViewController:listView animated:YES];
}

-(void)L2EmployeeList
{
    TableListingView *listView = [[TableListingView alloc]init];
    listView.checkforLevel = 2;
    [self.navigationController pushViewController:listView animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
