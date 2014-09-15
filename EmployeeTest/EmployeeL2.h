//
//  EmployeeL2.h
//  EmployeeTest
//
//  Created by Luke Dellar on 15/09/2014.
//  Copyright (c) 2014 LDellar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EmployeeL2 : NSManagedObject

@property (nonatomic, retain) NSString * photolink;
@property (nonatomic, retain) NSString * biodescription;
@property (nonatomic, retain) NSString * jobtitle;
@property (nonatomic, retain) NSString * name;

@end
