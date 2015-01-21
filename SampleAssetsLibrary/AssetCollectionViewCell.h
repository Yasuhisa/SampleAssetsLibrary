//
//  AssetCollectionViewCell.h
//  SampleAssetsLibrary
//
//  Created by yasuhisa.arakawa on 2015/01/21.
//  Copyright (c) 2015年 Classmethod, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  取得したアセットのサムネイルを表示するセルクラスです。
 */
@interface AssetCollectionViewCell : UICollectionViewCell

/**
 *  サムネイル
 */
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@end
