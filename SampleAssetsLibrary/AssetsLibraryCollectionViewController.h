//
//  AssetsLibraryCollectionViewController.h
//  SampleAssetsLibrary
//
//  Created by yasuhisa.arakawa on 2015/01/21.
//  Copyright (c) 2015年 Classmethod, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  読み込んだアセットを一覧表示する画面クラスです。
 */
@interface AssetsLibraryCollectionViewController : UICollectionViewController

/**
 *  表示する ALAsset の配列
 */
@property (nonatomic, strong) NSArray *assets;

@end
