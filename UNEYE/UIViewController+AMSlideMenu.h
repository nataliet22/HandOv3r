//
//  UIViewController+AMSlideMenu.h
//  AMSlideMenu
//
// Created by : TheTubes 2015
// Copyright (c) TheTubes 2015. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuMainViewController.h"

@interface UIViewController (AMSlideMenu)

/**
 * Getting current vc's  Main Slideing View Controller
 */
- (AMSlideMenuMainViewController *)mainSlideMenu;


/** 
 * Adds left menu top button
 */
- (void)addLeftMenuButton;

/**
 * Adds right menu top button
 */
- (void)addRightMenuButton;

/**
 * Removes left menu top button
 */
- (void)removeLeftMenuButton;

/**
 * Removes right menu top button
 */
- (void)removeRightMenuButton;


//
// ABOVE METHODS MUST BE USED in viewWillAppear:
//

/**
 * Disables Left menu open functionality
 * by Pan gesture recognizer
 */
- (void)disableSlidePanGestureForLeftMenu;

/**
 * Disables Right menu open functionality
 * by Pan gesture recognizer
 */
- (void)disableSlidePanGestureForRightMenu;

/**
 * Enables Left menu open functionality
 * by Pan gesture recognizer
 */
- (void)enableSlidePanGestureForLeftMenu;

/**
 * Disables Right menu open functionality
 * by Pan gesture recognizer
 */
- (void)enableSlidePanGestureForRightMenu;

@end
