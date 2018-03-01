//
//  repoObject.h
//  GithubRepos
//
//  Created by Chris Dean on 2018-03-01.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface repoObject : NSObject

@property (nonatomic) NSNumber *repoID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *full_name;

- (instancetype)initWithName:(NSString*)name withID:(NSNumber*)repoID withFullName:(NSString*)full_name;

@end
