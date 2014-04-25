//
//  MDViewController.m
//  MDSpreadViewDemo
//
//  Created by Dimitri Bouniol on 10/15/11.
//  Copyright (c) 2012 Mochi Development, Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software, associated artwork, and documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  1. The above copyright notice and this permission notice shall be included in
//     all copies or substantial portions of the Software.
//  2. Neither the name of Mochi Development, Inc. nor the names of its
//     contributors or products may be used to endorse or promote products
//     derived from this software without specific prior written permission.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  
//  Mochi Dev, and the Mochi Development logo are copyright Mochi Development, Inc.
//  
//  Also, it'd be super awesome if you credited this page in your about screen :)
//  

#import "MDViewController.h"

@implementation MDViewController
@synthesize spreadView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    NSLog(@"Too little memory!");
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    spreadView.sectionColumnHeaderWidth = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        spreadView.contentInset = UIEdgeInsetsMake(64, 20, 84, 20);
    }
    spreadView.scrollIndicatorInsets = spreadView.contentInset;
    
//    spreadView.allowsRowHeaderSelection = YES;
//    spreadView.allowsColumnHeaderSelection = YES;
//    spreadView.allowsCornerHeaderSelection = YES;
    
//    spreadView.contentInset = UIEdgeInsetsMake(44*3, 300, 44*3, 300);
//    spreadView.clipsToBounds = NO;
//    spreadView.columnWidth = spreadView.rowHeight;
    [spreadView reloadData];
// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSpreadView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    [spreadView release];
    [super dealloc];
}

#pragma mark - Spread View Datasource

- (NSInteger)spreadView:(MDSpreadView *)aSpreadView numberOfColumnsInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)spreadView:(MDSpreadView *)aSpreadView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0 || section == 2) return 0;
    return 100;
}

- (NSInteger)numberOfColumnSectionsInSpreadView:(MDSpreadView *)aSpreadView
{
    return 10000;
}

- (NSInteger)numberOfRowSectionsInSpreadView:(MDSpreadView *)aSpreadView
{
    return 10000;
}

#pragma mark Heights
// Comment these out to use normal values (see MDSpreadView.h)
- (CGFloat)spreadView:(MDSpreadView *)aSpreadView heightForRowAtIndexPath:(MDIndexPath *)indexPath
{
    return 25+indexPath.row; // 165 cells gives 60 fps. 250 cells gives 50 fps. 600 cells gives 25 fps
}
//
- (CGFloat)spreadView:(MDSpreadView *)aSpreadView heightForRowHeaderInSection:(NSInteger)rowSection
{
//    if (rowSection == 0 || rowSection == 2) return 0; // uncomment to hide this header!
    
    if (rowSection == 1) return 0;
    return 22;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView heightForRowFooterInSection:(NSInteger)rowSection
{
//    if (rowSection == 0 || rowSection == 2) return 0; // uncomment to hide this header!
    if (rowSection <= 2) return 0;
    return 22;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView widthForColumnAtIndexPath:(MDIndexPath *)indexPath
{
//    return 220+indexPath.column*5;
    return 140+indexPath.row;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView widthForColumnHeaderInSection:(NSInteger)columnSection
{
//    if (columnSection == 2) return 0; // uncomment to hide this header!
    if (columnSection == 1) return 0;
    return MIN(110+columnSection*5, 230);
//    return 22;
}

- (CGFloat)spreadView:(MDSpreadView *)aSpreadView widthForColumnFooterInSection:(NSInteger)columnSection
{
    if (columnSection <= 2) return 0; // uncomment to hide this header!
    return MIN(110+columnSection*5, 230);
//    return 22;
}

#pragma Cells
- (MDSpreadViewCell *)spreadView:(MDSpreadView *)aSpreadView cellForRowAtIndexPath:(MDIndexPath *)rowPath forColumnAtIndexPath:(MDIndexPath *)columnPath
{
    if (rowPath.row >= 25) return nil; // use spreadView:objectValueForRowAtIndexPath:forColumnAtIndexPath below instead
    
    static NSString *cellIdentifier = @"Cell";

    MDSpreadViewCell *cell = [aSpreadView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[MDSpreadViewCell alloc] initWithStyle:MDSpreadViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Test Row %ld-%ld (%ld-%ld)", (long)(rowPath.section+1), (long)(rowPath.row+1), (long)(columnPath.section+1), (long)(columnPath.row+1)];
    cell.textLabel.textColor = [UIColor colorWithRed:(arc4random()%100)/200. green:(arc4random()%100)/200. blue:(arc4random()%100)/200. alpha:1];

    return cell;
}
//
//- (MDSpreadViewCell *)spreadView:(MDSpreadView *)aSpreadView cellForHeaderInRowSection:(NSInteger)rowSection forColumnSection:(NSInteger)columnSection
//{
//    static NSString *cellIdentifier = @"CornerHeaderCell";
//    
//    MDSpreadViewHeaderCell *cell = (MDSpreadViewHeaderCell *)[aSpreadView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[[MDSpreadViewHeaderCell alloc] initWithStyle:MDSpreadViewHeaderCellStyleCorner reuseIdentifier:cellIdentifier] autorelease];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"Cor %d-%d", columnSection+1, rowSection+1];
//    
//    return cell;
//}
//
//- (MDSpreadViewCell *)spreadView:(MDSpreadView *)aSpreadView cellForHeaderInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
//{
//    static NSString *cellIdentifier = @"RowHeaderCell";
//    
//    MDSpreadViewHeaderCell *cell = (MDSpreadViewHeaderCell *)[aSpreadView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[[MDSpreadViewHeaderCell alloc] initWithStyle:MDSpreadViewHeaderCellStyleRow reuseIdentifier:cellIdentifier] autorelease];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"Row Header %d (%d-%d)", section+1, columnPath.section+1, columnPath.row+1];
//    
//    return cell;
//}
//
//- (MDSpreadViewCell *)spreadView:(MDSpreadView *)aSpreadView cellForHeaderInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath
//{
//    static NSString *cellIdentifier = @"ColumnHeaderCell";
//    
//    MDSpreadViewHeaderCell *cell = (MDSpreadViewHeaderCell *)[aSpreadView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[[MDSpreadViewHeaderCell alloc] initWithStyle:MDSpreadViewHeaderCellStyleColumn reuseIdentifier:cellIdentifier] autorelease];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%d (%d-%d)", section+1, rowPath.section+1, rowPath.row+1];
//    
//    return cell;
//}

// either do that ^^ for advanced customization, or this vv and let the cell take care of all the details
// both can be combined if you wanted, by returning nil to the above methods

- (id)spreadView:(MDSpreadView *)aSpreadView titleForHeaderInRowSection:(NSInteger)rowSection forColumnSection:(NSInteger)columnSection
{
    return [NSString stringWithFormat:@"H Cor %ld-%ld", (long)(columnSection+1), (long)(rowSection+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForHeaderInRowSection:(NSInteger)rowSection forColumnFooterSection:(NSInteger)columnSection
{
    return [NSString stringWithFormat:@"B Cor %ld-%ld", (long)(columnSection+1), (long)(rowSection+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForHeaderInColumnSection:(NSInteger)columnSection forRowFooterSection:(NSInteger)rowSection
{
    return [NSString stringWithFormat:@"A Cor %ld-%ld", (long)(columnSection+1), (long)(rowSection+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForFooterInRowSection:(NSInteger)rowSection forColumnSection:(NSInteger)columnSection
{
    return [NSString stringWithFormat:@"F Cor %ld-%ld", (long)(columnSection+1), (long)(rowSection+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForHeaderInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
{
    return [NSString stringWithFormat:@"H Row %ld (%ld-%ld)", (long)(section+1), (long)(columnPath.section+1), (long)(columnPath.row+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForHeaderInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath
{
    return [NSString stringWithFormat:@"H Col %ld (%ld-%ld)", (long)(section+1), (long)(rowPath.section+1), (long)(rowPath.row+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForFooterInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
{
    return [NSString stringWithFormat:@"F Row %ld (%ld-%ld)", (long)(section+1), (long)(columnPath.section+1), (long)(columnPath.row+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView titleForFooterInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath
{
    return [NSString stringWithFormat:@"F Col %ld (%ld-%ld)", (long)(section+1), (long)(rowPath.section+1), (long)(rowPath.row+1)];
}

- (id)spreadView:(MDSpreadView *)aSpreadView objectValueForRowAtIndexPath:(MDIndexPath *)rowPath forColumnAtIndexPath:(MDIndexPath *)columnPath
{
    return [NSString stringWithFormat:@"Cell %ld-%ld (%ld-%ld)", (long)(rowPath.section+1), (long)(rowPath.row+1), (long)(columnPath.section+1), (long)(columnPath.row+1)];
}

- (void)spreadView:(MDSpreadView *)aSpreadView didSelectCellForRowAtIndexPath:(MDIndexPath *)rowPath forColumnAtIndexPath:(MDIndexPath *)columnPath
{
//    [spreadView deselectCellForRowAtIndexPath:rowPath forColumnAtIndexPath:columnPath animated:YES];
    NSLog(@"Selected %@ x %@", rowPath, columnPath);
}

- (MDSpreadViewSelection *)spreadView:(MDSpreadView *)aSpreadView willHighlightCellWithSelection:(MDSpreadViewSelection *)selection
{
    return [MDSpreadViewSelection selectionWithRow:selection.rowPath column:selection.columnPath mode:MDSpreadViewSelectionModeRowAndColumn];
}

- (MDSpreadViewSelection *)spreadView:(MDSpreadView *)aSpreadView willSelectCellWithSelection:(MDSpreadViewSelection *)selection
{
    return [MDSpreadViewSelection selectionWithRow:selection.rowPath column:selection.columnPath mode:MDSpreadViewSelectionModeRowAndColumn];
}

#pragma mark - Debug stuff
// not actually part of MDSpreadView!

- (IBAction)scrollToTop:(id)sender
{
    [spreadView scrollRectToVisible:UIEdgeInsetsInsetRect(CGRectMake(spreadView.contentOffset.x, -spreadView.contentInset.top, spreadView.bounds.size.width, spreadView.bounds.size.height), spreadView.contentInset) animated:YES];
}

- (IBAction)scrollToBottom:(id)sender
{
    [spreadView scrollRectToVisible:UIEdgeInsetsInsetRect(CGRectMake(spreadView.contentOffset.x, spreadView.contentSize.height-spreadView.bounds.size.height+spreadView.contentInset.bottom, spreadView.bounds.size.width, spreadView.bounds.size.height), spreadView.contentInset) animated:YES];
}

- (IBAction)scrollToLeft:(id)sender
{
    [spreadView scrollRectToVisible:UIEdgeInsetsInsetRect(CGRectMake(-spreadView.contentInset.left, spreadView.contentOffset.y, spreadView.bounds.size.width, spreadView.bounds.size.height), spreadView.contentInset) animated:YES];
}

- (IBAction)scrollToRight:(id)sender
{
    [spreadView scrollRectToVisible:UIEdgeInsetsInsetRect(CGRectMake(spreadView.contentSize.width-spreadView.bounds.size.width+spreadView.contentInset.right, spreadView.contentOffset.y, spreadView.bounds.size.width, spreadView.bounds.size.height), spreadView.contentInset) animated:YES];
}

- (IBAction)reload:(id)sender
{
    [spreadView reloadData];
}

@end
