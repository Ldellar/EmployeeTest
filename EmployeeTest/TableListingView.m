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
#import "CheckReachability.h"

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
        if(![CheckReachability checkReachability])
        {
            employees = [DBManager getallEmployeesL2];
            tView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height-75) style:UITableViewStylePlain];
            tView.delegate = self;
            tView.dataSource = self;
            tView.backgroundColor = [UIColor clearColor];
            tView.separatorColor = [UIColor clearColor];
            [self.view addSubview:tView];
        }
    }
    
}

-(void)runHTMLParse
{
    NSURL *teamURL = [NSURL URLWithString:@"http://www.theappbusiness.com/our-team/"];
    NSData *teamHtmlData = [NSData dataWithContentsOfURL:teamURL];
    
    // RUN THE PARSER
    TFHpple *teamParser = [TFHpple hppleWithHTMLData:teamHtmlData];
    
    NSString *xPathQueryString = @"//div[@class='col col2']";
    teamNodes = [teamParser searchWithXPathQuery:xPathQueryString];
    [spinner stopAnimating];
    
    for (TFHppleElement *element in teamNodes)
    {
        // GET ALL TAGS FOR 1 EMPLOYEE
        NSArray *r = [element children];
        
        // GET IMAGEURL FOR 1 EMPLOYEE;
        TFHppleElement *imageURL = [[[r objectAtIndex:0]children]objectAtIndex:0];
        // GET NAME TAG FOR 1 EMPLOYEE;
        TFHppleElement *name = [[[r objectAtIndex:1]children]objectAtIndex:0];
        // GET TITLE FOR 1 EMPLOYEE;
        TFHppleElement *title = [[[r objectAtIndex:2]children]objectAtIndex:0];
        // GET BIO FOR 1 EMPLOYEE;
        TFHppleElement *bio = [[[r objectAtIndex:3]children]objectAtIndex:0];
        
        if ([DBManager EmployeeL2ExistswithName:[name content] andJobtitle:[title content]])
        {
            
        }
        else
        {
            [DBManager addEmployeeL2withName:[name content] andTitle:[title content] withBio:[bio content] withInternalImageCacheLink:[[imageURL attributes]valueForKey:@"src"]];
        }
    }

    EmpCount = [DBManager getNumberofL2Employees];
    
    
    [self parseFinished];
}

-(void)parseandStoreImage
{
    for (TFHppleElement *element in teamNodes)
    {
        // GET ALL TAGS FOR 1 EMPLOYEE
        NSArray *r = [element children];
        
        // GET IMAGEURL FOR 1 EMPLOYEE;
        TFHppleElement *imageLink = [[[r objectAtIndex:0]children]objectAtIndex:0];
        // GET NAME TAG FOR 1 EMPLOYEE;
        TFHppleElement *name = [[[r objectAtIndex:1]children]objectAtIndex:0];
        // GET TITLE FOR 1 EMPLOYEE;
        TFHppleElement *title = [[[r objectAtIndex:2]children]objectAtIndex:0];
        // GET BIO FOR 1 EMPLOYEE;
        TFHppleElement *bio = [[[r objectAtIndex:3]children]objectAtIndex:0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:[[imageLink attributes]valueForKey:@"src"]];
                       NSData *imData = [NSData dataWithContentsOfURL:imageURL];
                       
                       //This is your completion handler
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           NSData *imageData = UIImagePNGRepresentation([UIImage imageWithData:imData]);
                           
                           NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                           NSString *documentsDirectory = [paths objectAtIndex:0];
                           
                           NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
                           
                           NSLog((@"pre writing to file"));
                           if (![imageData writeToFile:imagePath atomically:NO]) 
                           {
                               NSLog(@"Failed to cache image data to disk");
                           }
                           else
                           {
                               NSLog(@"the cachedImagedPath is %@",imagePath);
                           }
                           
                       });
                   });
        if ([DBManager EmployeeL2ExistswithName:[name content] andJobtitle:[title content]])
        {
            
        }
        else
        {
            [DBManager addEmployeeL2withName:[name content] andTitle:[title content] withBio:[bio content] withInternalImageCacheLink:[[imageLink attributes]valueForKey:@"src"]];
        }
    }

}

-(void)parseFinished
{
    employees = [DBManager getallEmployeesL2];
    tView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height-75) style:UITableViewStylePlain];
    tView.delegate = self;
    tView.dataSource = self;
    tView.backgroundColor = [UIColor clearColor];
    tView.separatorColor = [UIColor clearColor];
    [self.view addSubview:tView];
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
        cell.imageView.backgroundColor = [UIColor clearColor];
        cell.imageView.image = [UIImage imageNamed:@"loading.png"];
        
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
    else
    {
        cell.imageView.backgroundColor = [UIColor clearColor];
        cell.imageView.image = [UIImage imageNamed:@"loading.png"];
        
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
                                       if (tableView) {
                                       [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                       }
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
    if(checkforLevel == 2 && [CheckReachability checkReachability])
    {
        spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner setCenter:self.view.center];
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
        // run the HTML parse on a seperate thread so we can run aynchronously
        [NSThread detachNewThreadSelector:@selector(runHTMLParse)
                                 toTarget:self
                               withObject:nil];
    }
    else
    {
        UIBarButtonItem *PlusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(ProfileView)];
        self.navigationItem.rightBarButtonItem = PlusButton;
    }
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
