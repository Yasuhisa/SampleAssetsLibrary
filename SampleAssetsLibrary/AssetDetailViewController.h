//
//  AssetDetailViewController.h
//  SampleAssetsLibrary
//
//  Created by yasuhisa.arakawa on 2015/01/21.
//  Copyright (c) 2015年 Classmethod, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;

/**
 *  選択されたアセットを表示する画面クラスです。
 */
@interface AssetDetailViewController : UIViewController

/**
 *  選択されたアセット
 */
@property (nonatomic, strong) ALAsset *selectedAsset;

@end
