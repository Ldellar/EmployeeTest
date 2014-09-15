//
//  DBManager.h
//  EmployeeTest
//
//  Created by Luke Dellar on 15/09/2014.
//  Copyright (c) 2014 LDellar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+(BOOL)addEmployeeL1withName:(NSString*)name andTitle:(NSString*)title withBio:(NSString*)bio withInternalImageCacheLink:(NSString*)photolink;

+(BOOL)addEmployeeL2withName:(NSString*)name andTitle:(NSString*)title withBio:(NSString*)bio withInternalImageCacheLink:(NSString*)photolink;

+(BOOL)EmployeeL1ExistswithName:(NSString*)name andJobtitle:(NSString*)jtitle;
+(BOOL)EmployeeL2ExistswithName:(NSString*)name andJobtitle:(NSString*)jtitle;

+(BOOL)deleteEmployeeL1withName:(NSString*)name andJobtitle:(NSString*)jtitle;
+(BOOL)deleteEmployeeL2withName:(NSString*)name andJobtitle:(NSString*)jtitle;

+(NSMutableArray*)getallEmployeesL1;
+(NSMutableArray*)getallEmployeesL2;

+(NSInteger)getNumberofL1Employees;
+(NSInteger)getNumberofL2Employees;

@end
