//
//  MenuItemDetailTableViewController.m
//  streats-iOS
//
//  Created by Anas Merbouh on 2019-05-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MenuItemDetailTableViewController.h"
#import "SVProgressHUD.h"
#import "MenuItem.h"
#import "MenuItemController.h"

@interface MenuItemDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addPictureTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIStackView *ingredientsContainerStackView;

- (void)openCamera;
- (void)populateViews;
- (void)configureTitleLabels;
- (void)showErrorAlertControllerWithMessage:(NSString *)message;
- (void)showImageUploadErrorAlertControllerWithMessage:(NSString *)message;
- (IBAction)handleDoneBarButtonItemTaped:(UIBarButtonItem *)sender;

@end

@implementation MenuItemDetailTableViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self populateViews];
    [self configureTitleLabels];
    [self.navigationItem setTitle:self.menuItem.name];
}

#pragma mark - Methods

- (void)openCamera
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // Configure the image picker.
    [imagePickerController setDelegate:self];
    [imagePickerController setAllowsEditing:YES];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];

    // Present the image picker.
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

- (void)populateViews
{
    [self.nameLabel setText:self.menuItem.name];
    [self.priceLabel setText:self.menuItem.priceString];
    
    // Clear the ingredients container stack view.
    for (UIView * arrangedSubview in self.ingredientsContainerStackView.arrangedSubviews) {
        [self.ingredientsContainerStackView removeArrangedSubview:arrangedSubview];
        [arrangedSubview removeFromSuperview];
    }
    
    // Check if we have the ingredients data and act accordingly.
    if (self.menuItem.ingredients != NULL) {
        for (NSString *ingredient in self.menuItem.ingredients) {
            UILabel * ingredientLabel = [UILabel new];

            // Configure the label...
            [ingredientLabel setText:ingredient];
            [ingredientLabel setNumberOfLines:0];
            [ingredientLabel setTextAlignment:NSTextAlignmentRight];
            
            // Add the label to the ingredients stack view.
            [self.ingredientsContainerStackView addArrangedSubview:ingredientLabel];
        }
    } else {
        UILabel * missingIngredientsLabel =[[UILabel alloc] init];
        
        // Configure the label...
        [missingIngredientsLabel setText:NSLocalizedString(@"noIngredientsData", NULL)];
        [missingIngredientsLabel setTextAlignment:NSTextAlignmentRight];
        
        // Add the label to the ingredients stack view.
        [self.ingredientsContainerStackView addArrangedSubview:missingIngredientsLabel];
    }
}

- (void)configureTitleLabels
{
    [self.nameTitleLabel setText:NSLocalizedString(@"name", NULL)];
    [self.priceTitleLabel setText:NSLocalizedString(@"price", NULL)];
    [self.ingredientsTitleLabel setText:NSLocalizedString(@"ingredients", NULL)];
    [self.addPictureTitleLabel setText:NSLocalizedString(@"addPicture", NULL)];
}

- (void)showErrorAlertControllerWithMessage:(NSString *)message
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"oops", NULL) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Configure the alert controller.
    UIAlertAction * dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:dismissAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)showImageUploadErrorAlertControllerWithMessage:(NSString *)message
{
    NSString *fullMessage = [NSString stringWithFormat:NSLocalizedString(@"imageUploadErrorMessage", NULL), message];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"oops", NULL) message:fullMessage preferredStyle:UIAlertControllerStyleAlert];
    
    // Configure the alert controller.
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:dismissAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (IBAction)handleDoneBarButtonItemTaped:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self openCamera];
        } else {
            [self showErrorAlertControllerWithMessage:NSLocalizedString(@"cameraNotAvailableOnDevice", NULL)];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"priceSubjectToChange", NULL);
    } else if (section == 1) {
        return NSLocalizedString(@"menuItemImageUploadDisclaimer", NULL);
    }
    
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return UITableViewAutomaticDimension;
    }
    
    return 44;
}

#pragma mark - Image Picker Controller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
    
    // Show the activity indicator.
    [SVProgressHUD show];
    
    // Get an instance of the MenuItemController class.
    MenuItemController * menuItemController = [[MenuItemController alloc] initWithMenuItem:self.menuItem];
    
    // Upload the image.
    [menuItemController uploadItemImage:image correspondingVendorIdentifier:self.vendorIdentifier completionHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            // Handle the response.
            if (error != NULL) {
                [picker dismissViewControllerAnimated:YES completion:NULL];
                [self showImageUploadErrorAlertControllerWithMessage:error.localizedDescription];
            } else {
                [picker dismissViewControllerAnimated:YES completion:NULL];
            }
        });
    }];
}

@end
