//
//  UIImageView+Download.m
//  LazyLoad
//
//  Created by LT on 6/17/14.
//  Copyright (c) 2014 PCS. All rights reserved.
//

#import "UIImageView+Download.h"

@implementation UIImageView (Download)

-(void)setImageForUrl:(NSString*)url {
    if ([self checkIfFilePathExist:url]) {
        NSString* editedUrl = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
        editedUrl = [editedUrl stringByReplacingOccurrencesOfString:@":" withString:@""];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:editedUrl];
        NSData* data = [NSData dataWithContentsOfFile:path];
        self.image = [UIImage imageWithData:data];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }else {
        dispatch_queue_t imageFetch = dispatch_queue_create("get main image", NULL);
        dispatch_async(imageFetch, ^{
            NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            [self savePhoto:image with:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(image) {
                    self.image = image;
                    self.contentMode = UIViewContentModeScaleAspectFill;
                    self.clipsToBounds = YES;
                }
            });
        });
    }
}

-(BOOL)checkIfFilePathExist:(NSString*)url {
    //remove any slashes and colons to store our urls
    url = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
    url = [url stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:url];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

-(void)savePhoto:(UIImage*)downloadedImage with:(NSString*)url {
    url = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
    url = [url stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:url];
    NSData* data = UIImageJPEGRepresentation(downloadedImage, 0.3f);
    [data writeToFile:path atomically:YES];
}

@end
