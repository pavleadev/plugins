// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "FIAPRequestHandler.h"
#import "InAppPurchasePlugin.h"

NS_ASSUME_NONNULL_BEGIN
@interface SKProductSubscriptionPeriodStub : SKProductSubscriptionPeriod
- (instancetype)initWithMap:(NSDictionary *)map;
@end

@interface SKProductDiscountStub : SKProductDiscount
- (instancetype)initWithMap:(NSDictionary *)map;
@end

@interface SKProductStub : SKProduct
- (instancetype)initWithMap:(NSDictionary *)map;
@end

@interface SKProductRequestStub : SKProductsRequest
- (instancetype)initWithProductIdentifiers:(NSSet<NSString *> *)productIdentifiers;
- (instancetype)initWithFailureError:(NSError *)error;
@end

@interface SKProductsResponseStub : SKProductsResponse
- (instancetype)initWithMap:(NSDictionary *)map;
@end

@interface InAppPurchasePluginStub : InAppPurchasePlugin
@end

@interface SKPaymentTransactionStub : SKPaymentTransaction
- (instancetype)initWithMap:(NSDictionary *)map;
@end

@interface SKDownloadStub : SKDownload
- (instancetype)initWithMap:(NSDictionary *)map;
@end

@interface SKMutablePaymentStub : SKMutablePayment
- (instancetype)initWithMap:(NSDictionary *)map;
@end

@interface NSErrorStub : NSError
- (instancetype)initWithMap:(NSDictionary *)map;
@end

NS_ASSUME_NONNULL_END
