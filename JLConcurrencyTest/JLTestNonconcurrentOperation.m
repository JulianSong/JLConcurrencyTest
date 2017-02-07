//
//  JLTestNonconcurrentOperation.m
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/2/6.
//
//

#import "JLTestNonconcurrentOperation.h"

@implementation JLTestNonconcurrentOperation
- (void)main
{
    @try {
        BOOL isDone = NO;
        while (![self isCancelled] && !isDone) {
            NSLog(@"JLTestNonconcurrentOperation");
            NSThread *current = [NSThread currentThread];
            NSThread *main = [NSThread mainThread];
            if (main == current) {
                NSLog(@"main thread and current thead are same");
            }else{
                NSLog(@"main thread and current thead are diff");
            }
            isDone = YES;
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

@end
