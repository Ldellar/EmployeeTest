//
//  TableListingView.m
//  EmployeeTest
//
//  Created by Luke Dellar on 15/09/2014.
//  Copyright (c) 2014 LDellar. All rights reserved.
//

#import "TableListingView.h"
#import "EmployeeL1.h"
#import "EmployeeL2.h"
#import "DBManager.h"
#import <QuartzCore/QuartzCore.h>
#import "TFHpple.h"

@implementation TableListingView

@synthesize checkforLevel;

-(id)init
{
    return self;
}

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Employee List";
    
    if(checkforLevel == 1)
    {
        employees = [DBManager getallEmployeesL1];
        
        tView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
        tView.delegate = self;
        tView.dataSource = self;
        tView.backgroundColor = [UIColor clearColor];
        tView.separatorColor = [UIColor clearColor];
        [self.view addSubview:tView];
    }
    else
    {
        // PARSE
        
    }
}

-(void)parseFinished
{
    
}

-(void)refresh
{
    
}

-(void)ProfileView
{
    NSLog(@"ADD PROFILE");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [employees count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // FOR LEVEL 1
    if(checkforLevel == 1)
    {
        cell.imageView.backgroundColor = [UIColor blackColor];
        
        EmployeeL1 *e1 = [employees objectAtIndex:indexPath.row];
        
        // SECOND IDENTIFIER FOR THE CACHE
        NSString *ImageCelllidentifier = [NSString stringWithFormat:@"Cell%ld" ,
                                (long)indexPath.row];
        
        if([cachedImages objectForKey:ImageCelllidentifier] != nil)
        {
            cell.imageView.image = [cachedImages valueForKey:ImageCelllidentifier];
        }
        else
        {
            // Run asynchronous queue for image loading so larger numbers can be managed
            char const * s = [ImageCelllidentifier UTF8String];
            dispatch_queue_t queue = dispatch_queue_create(s, 0);
            dispatch_async(queue, ^{
                
                NSString *url = e1.photolink;
                UIImage *img = nil;
                NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
                
                img = [[UIImage alloc] initWithData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if ([tableView indexPathForCell:cell].row == indexPath.row)
                    {
                        [cachedImages setValue:img forKey:ImageCelllidentifier];
                        cell.imageView.image = [cachedImages valueForKey:ImageCelllidentifier];
                        
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            });
        }
        
        cell.textLabel.text = e1.name;
        cell.detailTextLabel.text = e1.jobtitle;
        cell.imageView.layer.cornerRadius = 21.0;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.borderWidth = 0;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *PlusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(ProfileView)];
    self.navigationItem.rightBarButtonItem = PlusButton;
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cachedImages = [[NSMutableDictionary alloc]init];
    //employees = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
