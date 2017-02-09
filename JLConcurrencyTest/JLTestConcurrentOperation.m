//
//  JLTestConcurrentOperation.m
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/2/7.
//
//

#import "JLTestConcurrentOperation.h"

@implementation JLTestConcurrentOperation
- (id)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}
- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start {

    if ([self isCancelled])
    {
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main
{
    @try {
        BOOL isDone = NO;
        while (![self isCancelled] && !isDone) {
            NSLog(@"JLTestConcurrentOperation");
            NSThread *current = [NSThread currentThread];
            NSThread *main = [NSThread mainThread];
            if (main == current) {
                NSLog(@"main thread and current thead are same");
            }else{
                NSLog(@"main thread and current thead are diff");
            }
            isDone = YES;
            [self completeOperation];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}
@end
