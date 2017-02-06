//
//  JLTestNonconcurrentOperation.m
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/2/6.
//
//

#import "JLTestNonconcurrentOperation.h"

@implementation JLTestNonconcurrentOperationzhijie
- (void)main
{
    NSLog(@"JLTestNonconcurrentOperation");
    NSThread *current = [NSThread currentThread];
    NSThread *main = [NSThread mainThread];
    if (main == current) {
        NSLog(@"main thread and current thead are same");
    }else{
        NSLog(@"main thread and current thead are diff");
    }
}
@end
