//
//  Client.h
//  homeWork-2
//
//  Created by Максим Жуков on 07/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cook.h"
#import "Officiant.h"
#import "ClientProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Client : NSObject

@property(nonatomic, strong)Cook *cook;

@end

NS_ASSUME_NONNULL_END
