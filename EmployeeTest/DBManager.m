//
//  DBManager.m
//  EmployeeTest
//
//  Created by Luke Dellar on 15/09/2014.
//  Copyright (c) 2014 LDellar. All rights reserved.
//

#import "DBManager.h"
#import "AppDelegate.h"
#import "EmployeeL1.h"
#import "EmployeeL2.h"

@implementation DBManager

#pragma mark - Add Employees Methods

/* Method Description - Add Employee for L1 example. */

+(BOOL)addEmployeeL1withName:(NSString*)name andTitle:(NSString*)title withBio:(NSString*)bio withInternalImageCacheLink:(NSString*)photolink
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    EmployeeL1 *l1Employee;
    l1Employee = [NSEntityDescription
                 insertNewObjectForEntityForName:@"EmployeeL1"
                 inManagedObjectContext:managedObjectContext];
    l1Employee.name = name;
    l1Employee.jobtitle = title;
    l1Employee.biodescription = bio;
    l1Employee.photolink = photolink;
    
    NSError *error;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Error Saving Object: %@", [error localizedDescription]);
        return NO;
    }
    else
    {
        NSLog(@"Save Successful");
        return YES;
    }

}

/* Method Description - Add Employee for L2 example, this will be added at the end of a parsing operation */

+(BOOL)addEmployeeL2withName:(NSString*)name andTitle:(NSString*)title withBio:(NSString*)bio withInternalImageCacheLink:(NSString*)photolink
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    EmployeeL2 *l2Employee;
    l2Employee = [NSEntityDescription
                  insertNewObjectForEntityForName:@"EmployeeL2"
                  inManagedObjectContext:managedObjectContext];
    l2Employee.name = name;
    l2Employee.jobtitle = title;
    l2Employee.biodescription = bio;
    l2Employee.photolink = photolink;
    
    NSError *error;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Error Saving Object: %@", [error localizedDescription]);
        return NO;
    }
    else
    {
        NSLog(@"Save Successful");
        return YES;
    }
}

#pragma mark - Find/Check Employees Methods

+(BOOL)EmployeeL1ExistswithName:(NSString*)name andJobtitle:(NSString*)jtitle
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Perform a fetch of all current data
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmployeeL1" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (int i = 0;i<[fetchedObjects count];i++)
    {
        EmployeeL1 *emp1 = [fetchedObjects objectAtIndex:i];
        if([emp1.name isEqualToString:name] && [emp1.jobtitle isEqualToString:jtitle])
        {
            return YES;
            break;
        }
    }

    return NO;

}

+(BOOL)EmployeeL2ExistswithName:(NSString*)name andJobtitle:(NSString*)jtitle
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Perform a fetch of all current data
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmployeeL2" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (int i = 0;i<[fetchedObjects count];i++)
    {
        EmployeeL2 *emp1 = [fetchedObjects objectAtIndex:i];
        if([emp1.name isEqualToString:name] && [emp1.jobtitle isEqualToString:jtitle])
        {
            return YES;
            break;
        }
    }
    
    return NO;
}

#pragma mark - Delete Employees Methods

+(BOOL)deleteEmployeeL1withName:(NSString*)name andJobtitle:(NSString*)jtitle
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Perform a fetch of all current data
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmployeeL1" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    EmployeeL1 *toDelete;
    for (int i = 0;i<[fetchedObjects count];i++)
    {
        EmployeeL1 *emp1 = [fetchedObjects objectAtIndex:i];
        if([emp1.name isEqualToString:name] && [emp1.jobtitle isEqualToString:jtitle])
        {
            toDelete = emp1;
        }
    }

    [managedObjectContext deleteObject:toDelete];
    
    NSError *deleteError;
    if (![managedObjectContext save:&deleteError])
    {
        NSLog(@"Couldn't Delete: %@", [deleteError localizedDescription]);
        return NO;
    }
    else
    {
        return YES;
    }
}

+(BOOL)deleteEmployeeL2withName:(NSString*)name andJobtitle:(NSString*)jtitle
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    // Perform a fetch of all current data
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmployeeL2" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    EmployeeL2 *toDelete;
    for (int i = 0;i<[fetchedObjects count];i++)
    {
        EmployeeL2 *emp1 = [fetchedObjects objectAtIndex:i];
        if([emp1.name isEqualToString:name] && [emp1.jobtitle isEqualToString:jtitle])
        {
            toDelete = emp1;
        }
    }
    
    [managedObjectContext deleteObject:toDelete];
    
    NSError *deleteError;
    if (![managedObjectContext save:&deleteError])
    {
        NSLog(@"Couldn't Delete: %@", [deleteError localizedDescription]);
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - Get All Employees Methods

+(NSMutableArray*)getallEmployeesL1
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmployeeL1" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *all = [[NSMutableArray alloc]init];
    for (int i = 0;i<[fetchedObjects count];i++)
    {
        EmployeeL1 *emp1 = [fetchedObjects objectAtIndex:i];
        [all addObject:emp1];
    }
    
    return all;
}

+(NSMutableArray*)getallEmployeesL2
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmployeeL2" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *all = [[NSMutableArray alloc]init];
    for (int i = 0;i<[fetchedObjects count];i++)
    {
        EmployeeL2 *emp1 = [fetchedObjects objectAtIndex:i];
        [all addObject:emp1];
    }
    
    return all;
}

#pragma mark - Number of Employees Methods

+(NSInteger)getNumberofL1Employees
{
    return 0;
}
+(NSInteger)getNumberofL2Employees
{
    return 0;
}



@end
