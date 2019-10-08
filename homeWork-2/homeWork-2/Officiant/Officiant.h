//
//  Officiant.h
//  homeWork-2
//
//  Created by Максим Жуков on 07/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientProtocol.h"
#import "Cook.h"

NS_ASSUME_NONNULL_BEGIN

@interface Officiant : NSObject

@property(nonatomic, weak)id <ClientProtocol> delegate;

- (void)start;

@end


NS_ASSUME_NONNULL_END
