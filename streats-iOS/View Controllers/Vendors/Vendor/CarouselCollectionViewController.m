//
//  CarouselCollectionViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "CarouselCollectionViewController.h"
#import "CarouselCollectionViewCell.h"

@interface CarouselCollectionViewController ()

// Properties

@property(strong, nonatomic, nullable) NSMutableArray<UIImage *> *pictures;

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

// Methods

- (void)loadPictures;

@end

@implementation CarouselCollectionViewController

static NSString * const reuseIdentifier = @"CarouselCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    UINib *cellsNib = [UINib nibWithNibName:@"CarouselCollectionViewCell" bundle:NULL];
    [self.collectionView registerNib:cellsNib forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self loadPictures];
}

#pragma mark - Methods

- (void)loadView {
    [super loadView];
}

- (void)reloadPictures:(NSArray<NSString *> *)newPictures {
    [self setPicturesDownloadURLs:newPictures];
    [self loadPictures];
}

- (void)loadPictures {
    // Show the loading view if needed.
    if (self.loadingView.isHidden) {
        [self.loadingView setHidden:NO];
    }
    
    // Variable that keeps track of the iterations count.
    __block int iterationsCount = 0;
    
    // Start iterating over the pictures
    for (NSString *picture in self.picturesDownloadURLs) {
        NSURLSessionDataTask *downloadTask = [NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:picture] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            iterationsCount = iterationsCount + 1;
            
            // Use the downloaded data to generate an image.
            if (data != NULL) {
                UIImage *downloadedImage = [UIImage imageWithData:data];
                
                // Make sure that the image could be created from the downloaded data.
                if (downloadedImage != NULL) {
                    if (self.pictures == NULL) {
                        self.pictures = [[NSMutableArray alloc] init];
                    }
                    
                    [self.pictures addObject:downloadedImage];
                }
                
                // If we downloaded all the images, display the carousel.
                if (iterationsCount == self.picturesDownloadURLs.count) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                        [self.loadingView setHidden:YES];
                    });
                }
            }
        }];
        
        // Send the request.
        [downloadTask resume];
    }
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCollectionViewCell *cell = (CarouselCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UIImage *image = [self.pictures objectAtIndex:indexPath.row];
    [cell setImage:image];
    
    return cell;
}

#pragma mark - Collection view delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
