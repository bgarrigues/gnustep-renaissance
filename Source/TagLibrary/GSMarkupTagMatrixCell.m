/* -*-objc-*-
   GSMarkupTagMatrixCell.m

   Copyright (C) 2002 Free Software Foundation, Inc.

   Author: Nicola Pero <n.pero@mi.flashnet.it>
   Date: March-November 2002

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
#include "GSMarkupTagMatrixCell.h"

#ifndef GNUSTEP
# include <Foundation/Foundation.h>
# include <AppKit/AppKit.h>
# include "GNUstep.h"
#else
# include <Foundation/NSDictionary.h>
# include <Foundation/NSString.h>
# include <AppKit/NSButtonCell.h>
#endif

@implementation GSMarkupTagMatrixCell

+ (NSString *) tagName
{
  return @"matrixCell";
}

+ (Class) platformObjectClass
{
  return [NSButtonCell class];
}

- (id) initPlatformObject: (id)platformObject
{
  platformObject = [platformObject init];

  [platformObject setButtonType: NSRadioButton];
  [platformObject setBordered: NO];
  [platformObject setImagePosition: NSImageLeft]; 

  /* title */
  {
    NSString *title = [self localizedStringValueForAttribute: @"title"];
  
    if (title == nil)
      {
	title = @"";
      }

    [platformObject setTitle: title];
  }

  /* action */
  {
    NSString *action = [_attributes objectForKey: @"action"];
  
    if (action != nil)    
      {
	SEL selector = NSSelectorFromString (action);
	if (selector == NULL)
	  {
	    NSLog (@"Warning: <%@> has non-existing action '%@'.  Ignored.",
		   [[self class] tagName], action);
	  }
	else
	  {
	    [platformObject setAction: selector];
	  }
      }
  }

  /* editable */
  {
    int editable = [self boolValueForAttribute: @"editable"];
    
    if (editable == 1)
      {
	[platformObject setEditable: YES];
      }
    else if (editable == 0)
      {
	[platformObject setEditable: NO];
      }
  }

  /* selectable */
  {
    int selectable = [self boolValueForAttribute: @"selectable"];
    
    if (selectable == 1)
      {
	[platformObject setSelectable: YES];
      }
    else if (selectable == 0)
      {
	[platformObject setSelectable: NO];
      }
  }  

  /* tag */
  {
    NSString *tag = [_attributes objectForKey: @"tag"];
    if (tag != nil)
      {
	[(NSCell *)platformObject setTag: [tag intValue]];
      }
  }

  /* image */
  {
    NSString *image = [_attributes objectForKey: @"image"];

    if (image != nil)
      {
	[platformObject setImage: [NSImage imageNamed: image]];
      }
  }

  /* imagePosition */
  {
    NSString *imagePosition = [_attributes objectForKey: @"imagePosition"];
   
    if (imagePosition != nil  &&  [imagePosition length] > 0)
      {
	
	switch ([imagePosition characterAtIndex: 0])
	  {
	  case 'a':
	    if ([imagePosition isEqualToString: @"above"])
	      {
		[platformObject setImagePosition: NSImageAbove];
	      }
	    break;
	  case 'b':
	    if ([imagePosition isEqualToString: @"below"])
	      {
		[platformObject setImagePosition: NSImageBelow];
	      }
	    break;
	  case 'l':
	    if ([imagePosition isEqualToString: @"left"])
	      {
		[platformObject setImagePosition: NSImageLeft];
	      }
	    break;
	  case 'o':
	    if ([imagePosition isEqualToString: @"overlaps"])
	      {
		[platformObject setImagePosition: NSImageOverlaps];
	      }
	    break;
	  case 'r':
	    if ([imagePosition isEqualToString: @"right"])
	      {
		[platformObject setImagePosition: NSImageRight];
	      }
	    break;
	    /* FIXME/TODO - what about imageOnly ? */
	  case 'i':
	    if ([imagePosition isEqualToString: @"imageOnly"])
	      {
		[platformObject setImagePosition: NSImageOnly];
	      }
	    break;
	  }
      }
  }

  /* alternateTitle */
  {
    NSString *t = [self localizedStringValueForAttribute: @"alternateTitle"];

    if (t != nil)
      {
	[platformObject setAlternateTitle: t];
      }
  }

  /* alternateImage */
  {
    NSString *image = [_attributes objectForKey: @"alternateImage"];

    if (image != nil)
      {
	[platformObject setAlternateImage: [NSImage imageNamed: image]];
      }
  }

  /* type */
  {
    NSString *type = [_attributes objectForKey: @"type"];
#ifndef GNUSTEP
    BOOL needsSettingBorderAndBezel = YES;
#endif

    if (type != nil)
      {
	/* We follow here the organization of button types used in
	 * Apple Mac OS X.  The button types are quite well organized
	 * according to their function.  If only the names were
	 * simpler to remember. :-)
	 */
	switch ([type characterAtIndex: 0])
	  {
	  case 'm': 
	    /* This is a standard button (for example, an 'OK' button
	     * at the bottom of a panel).  It highlights when you click,
	     * and unhighlights when the mouse goes up.  The highlighting
	     * is done by the system.
	     */
	    if ([type isEqualToString: @"momentaryPushIn"])
	      {
		[platformObject setButtonType: NSMomentaryPushInButton];
	      }

	    /* This is a standard button, the same as momentaryPushIn,
	     * but it does not change the border when highlighting.
	     */
	    if ([type isEqualToString: @"momentaryLight"])
	      {
		[platformObject setButtonType: NSMomentaryLightButton];
	      }

	    /* This is a standard button, the same as momentaryPushIn,
	     * but it does the highlighting by displaying the
	     * alternateTitle and alternateImage.
	     */
	    if ([type isEqualToString: @"momentaryChange"])
	      {
		[platformObject setButtonType: NSMomentaryChangeButton];
	      }
	    break;
	    
	  case 'p':
	    /* This is a button which you click, and it gets pushed on.
	     * When you click again, it's pushed off back again.  The
	     * 'pushing' is done by the system.
	     */
	    if ([type isEqualToString: @"pushOnPushOff"])
	      {
		[platformObject setButtonType: NSPushOnPushOffButton];
	      }
	    break;
	    
	  case 'o':
	    /* This is the same as a pushOnPushOff, but when you click on
             * the button, the border is not changed like with the
             * 'momentaryLight' button.
	     */
	    if ([type isEqualToString: @"onOff"])
	      {
		[platformObject setButtonType: NSOnOffButton];
	      }
	    break;

	  case 't':
	    /* This is the same as a pushOnPushOff, but when the button
	     * is 'pushed on', this is shown by displaying the alternateTitle
	     * and alternateImage.
	     */
	    if ([type isEqualToString: @"toggle"])
	      {
		[platformObject setButtonType: NSToggleButton];
	      }
	    break;

	  case 's':
	    /* This type of buttons looks like a check box.  The image
	     * and alternate images are automatically set by the system
	     * to provide this appearance.  This button is a stock
	     * button provided by the system.
	     */
	    if ([type isEqualToString: @"switch"])
	      {
		[platformObject setButtonType: NSSwitchButton];
#ifndef GNUSTEP
		needsSettingBorderAndBezel = NO;
#endif
	      }
	    break;
	    
	  case 'r':
	    /* This type of buttons looks like a radio button. The image
	     * and alternate images are automatically set by the system
	     * to provide this appearance.  This button is a stock
	     * button provided by the system.
	     */
	    if ([type isEqualToString: @"radio"])
	      {
		[platformObject setButtonType: NSRadioButton];
	      }
	    break;
	  }
      }
    else
      {
	/* Make sure we use the same default button type on all
	 * platforms.  */
	[platformObject setButtonType: NSMomentaryPushInButton];
      }
#ifndef GNUSTEP
    /* On Apple Mac OS X, unless we manually set a border/bezel style,
     * the buttons are not displayed properly (nor with the native
     * default style).  We need to set a general style.
     */
    if (needsSettingBorderAndBezel)
      {
	/* For all text buttons, we use NSRoundedBezelStyle.  This is
	 * very good, but the buttons are too spaced (FIXME ??).
	 */
	if ([_attributes objectForKey: @"image"] == nil)
	  {
	    [platformObject setBezelStyle: NSRoundedBezelStyle];
	  }
	else
	  {
	    /* The default for buttons having an icon/image is supposed
	     * to be a RegularSquareBezelStyle.
	     */
	    [platformObject setBezelStyle: NSRegularSquareBezelStyle];

	    /* But judging by Apple's own applications, it seems that
	     * the default style for buttons having an icon/image is
	     * in practice not bordered, so maybe the following is
	     * better.
	     */
	    /* [platformObject setBordered: NO]; */
	  }
      }
#endif
  }

  return platformObject;
}

+ (NSArray *) localizableAttributes
{
  return [NSArray arrayWithObject: @"title"];
}

@end
