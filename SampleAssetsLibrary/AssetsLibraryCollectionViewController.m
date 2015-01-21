//
//  AssetsLibraryCollectionViewController.m
//  SampleAssetsLibrary
//
//  Created by yasuhisa.arakawa on 2015/01/21.
//  Copyright (c) 2015年 Classmethod, Inc. All rights reserved.
//

#import "AssetsLibraryCollectionViewController.h"
#import "AssetCollectionViewCell.h"
#import "AssetDetailViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

// 一行に何個のサムネイルを表示したいか
static NSInteger const AssetsCollectionViewCellCountInRow   = 4;
// 隣り合うサムネイルとの間隔
static CGFloat const AssetsCollectionViewCellPaddingSize    = 2.0f;

@interface AssetsLibraryCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) BOOL isAllAssetsLoaded;

@end

@implementation AssetsLibraryCollectionViewController

static NSString * const AssetsLibraryAssetCellIdentifier = @"AssetCell";

#pragma mark - Lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *assetNib = [UINib nibWithNibName:NSStringFromClass([AssetCollectionViewCell class]) bundle:nil];
    [self.collectionView registerNib:assetNib forCellWithReuseIdentifier:AssetsLibraryAssetCellIdentifier];
}

- (void)viewDidLayoutSubviews
{
    if (!self.isAllAssetsLoaded) {
        self.isAllAssetsLoaded = YES;
        // アセットの読み込み完了後に最新の画像までスクロールします。
        // 最新の画像は表示領域の最下部に表示されます。
        NSIndexPath *latestIndexPath = [NSIndexPath indexPathForRow:self.assets.count - 1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:latestIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionBottom
                                            animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Segue method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AssetDetail"]) {
        AssetDetailViewController *assetDetailViewController = segue.destinationViewController;
        // 選択されたインデックスのアセットを詳細画面へ渡します。
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        assetDetailViewController.selectedAsset = self.assets[selectedIndexPath.item];
    }
}

#pragma mark - UICollectionViewDataSourceDelegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AssetsLibraryAssetCellIdentifier forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.item];
    cell.thumbnail.image = [UIImage imageWithCGImage:asset.thumbnail];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate method

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"AssetDetail" sender:self];
}

#pragma mark - UICollectionViewDelegateFlowLayout method

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellSize = (self.collectionView.frame.size.width - AssetsCollectionViewCellPaddingSize * AssetsCollectionViewCellCountInRow) / AssetsCollectionViewCellCountInRow;
    return CGSizeMake(cellSize, cellSize);
}

@end
