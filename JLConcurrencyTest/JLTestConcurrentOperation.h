//
//  JLTestConcurrentOperation.h
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/2/7.
//
//

#import <Foundation/Foundation.h>

@interface JLTestConcurrentOperation : NSOperation
{
    BOOL        executing;
    BOOL        finished;
}
@end
