//
//  ClientProtocol.h
//  homeWork-2
//
//  Created by Максим Жуков on 08/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

#ifndef ClientProtocol_h
#define ClientProtocol_h

@protocol ClientProtocol <NSObject>

- (void)orderFood;

- (void)goToTheKichen;
- (void)sayStartCooking;
- (NSString *)thank;
- (void)bringFoodToTheTable;

@end

#endif /* ClientProtocol_h */
