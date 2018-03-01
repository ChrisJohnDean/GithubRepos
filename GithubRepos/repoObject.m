//
//  repoObject.m
//  GithubRepos
//
//  Created by Chris Dean on 2018-03-01.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "repoObject.h"

@implementation repoObject

- (instancetype)initWithName:(NSString*)name withID:(NSNumber*)repoID withFullName:(NSString*)full_name
{
    self = [super init];
    if (self) {
        _repoID = repoID;
        _name = name;
        _full_name = full_name;
    }
    return self;
}


@end
