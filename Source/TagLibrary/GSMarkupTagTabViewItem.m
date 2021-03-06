/* -*-objc-*-
   GSMarkupTagTabViewItem.m

   Copyright (C) 2008-2010 Free Software Foundation, Inc.

   Author: Xavier Glattard <xavier.glattard@online.fr>
   Date: March 2008

   Author: Nicola Pero <nicola.pero@meta-innovation.com>
   Date: May 2010

   This file is part of GNUstep Renaissance

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; see the file COPYING.LIB.
   If not, write to the Free Software Foundation,
   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/
#include <TagCommonInclude.h>
#include "GSMarkupTagTabView.h"
#include "GSMarkupTagTabViewItem.h"
#include "GSMarkupTagObjectAdditions.h"


#ifndef GNUSTEP
# include <Foundation/Foundation.h>
# include <AppKit/AppKit.h>
# include "GNUstep.h"
#else
# include <Foundation/NSString.h>
# include <AppKit/NSCell.h>
# include <AppKit/NSImage.h>
# include <AppKit/NSTabView.h>
# include <AppKit/NSTabViewItem.h>
# include <AppKit/NSView.h>
#endif

@implementation GSMarkupTagTabViewItem
+ (NSString *) tagName
{
  return @"tabViewItem";
}

- (id) allocPlatformObject
{
  return [NSTabViewItem alloc];
}

- (id) initPlatformObject: (id)platformObject
{
  /* identifier */
  {
    NSString *identifier = [_attributes objectForKey: @"identifier"];

    /* If no 'identifier' was set, use the 'id' if set.  */
    if (identifier == nil)
      {
	identifier = [_attributes objectForKey: @"id"];
      }

    platformObject = [platformObject initWithIdentifier: identifier];
  }

  /* label */
  {
    NSString *label = [self localizedStringValueForAttribute: @"label"];
    
    if (label != nil)
      {
	[platformObject setLabel: label];
      }
  }

  /* toolTip */
  {
    NSString *toolTip = [self localizedStringValueForAttribute: @"toolTip"];
    if (toolTip != nil)
      {
	/* Only some implementations (GNUstep GUI >= TODO and Apple
	 * Mac OS X 10.6) support setToolTip: for NSTabViewItem.  They
	 * should all have the selector, so we can check at runtime
	 * :-)
	 */
	if ([platformObject respondsToSelector: @selector(setToolTip:)])
	  {
	    [platformObject setToolTip: toolTip];
	  }
      }
  }

  /* The 'color' attribute is deprecated even by Apple; don't support
   * it.
   */

  /* Add content.  The content is a single object, which is set using
   * setView:.  If you want to put multiple views, you need to use an
   * autolayout container (eg, a <hbox> or <vbox>) with content (if
   * you want to use a static layout, you could use a <view> with
   * subviews).
   */
  {
    int count = [_content count];
    NSView *view = nil;
    
    if (count >= 1)
      {
	GSMarkupTagView *v = [_content objectAtIndex: 0];
	view = [v platformObject];
      }

    if (view != nil  &&  [view isKindOfClass: [NSView class]])
      {
	[platformObject setView: view];
      }
  }

  return platformObject;
}

+ (NSArray *) localizableAttributes
{
  return [NSArray arrayWithObjects: @"label", @"toolTip", nil];
}

@end
