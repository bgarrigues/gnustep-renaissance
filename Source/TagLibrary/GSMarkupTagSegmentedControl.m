/* -*-objc-*-
   GSMarkupTagSegmentedControl.m

   Copyright (C) 2002 Free Software Foundation, Inc.

   Author: Benoît Garrigues <bgarrigues@gmail.com>
   Date: January 2012

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
#include "GSMarkupTagSegmentedControl.h"
#include "GSMarkupTagImage.h"
#include "GSMarkupTagMenu.h"


#ifndef GNUSTEP
# include <Foundation/Foundation.h>
# include <AppKit/AppKit.h>
# include "GNUstep.h"
#else
# include <Foundation/NSString.h>
# include <AppKit/NSImage.h>
#endif

@implementation GSMarkupTagSegmentedControl

+ (NSString *) tagName
{
  return @"segmentedControl";
}

+ (Class) platformObjectClass
{
  return [NSSegmentedControl class];
}

- (id) initPlatformObject: (id)platformObject
{
  platformObject = [super initPlatformObject: platformObject];

  /* default values */
  [platformObject setSegmentStyle: NSSegmentStyleAutomatic];
  [[platformObject cell] setTrackingMode: NSSegmentSwitchTrackingSelectOne];

  /* segmentStyle */
  {
    NSString *segmentStyle = [_attributes objectForKey: @"segmentStyle"];
   
    if (segmentStyle != nil && [segmentStyle length] > 0)
      {
        switch ([segmentStyle characterAtIndex: 0])
          {
            case 'a':
              if ([segmentStyle isEqualToString: @"automatic"])
                {
                  [platformObject setSegmentStyle: NSSegmentStyleAutomatic];
                }
              break;
            case 'c':
              if ([segmentStyle isEqualToString: @"capsule"])
                {
                  [platformObject setSegmentStyle: NSSegmentStyleCapsule];
                }
              break;
            case 'r':
              if ([segmentStyle isEqualToString: @"rounded"])
                {
                  [platformObject setSegmentStyle: NSSegmentStyleRounded];
                }
              else if ([segmentStyle isEqualToString: @"roundRect"])
                {
                  [platformObject setSegmentStyle: NSSegmentStyleRoundRect];
                }
              break;
            case 's':
              if ([segmentStyle isEqualToString: @"smallSquare"])
                {
                  [platformObject setSegmentStyle: NSSegmentStyleSmallSquare];
                }
              break;
            case 't':
              if ([segmentStyle isEqualToString: @"texturedRounded"])
                {
                  [platformObject setSegmentStyle: NSSegmentStyleTexturedRounded];
                }
              else if ([segmentStyle isEqualToString: @"texturedSquare"])
                {
                  [platformObject setSegmentStyle: NSSegmentStyleTexturedSquare];
                }
              break;
          }
      }
  }

  /* trackingMode */
  {
    NSString *trackingMode = [_attributes objectForKey: @"trackingMode"];
   
    if (trackingMode != nil && [trackingMode length] > 0)
      {
        switch ([trackingMode characterAtIndex: 0])
          {
            case 'm':
              if ([trackingMode isEqualToString: @"momentary"])
                {
                  [[platformObject cell] setTrackingMode: NSSegmentSwitchTrackingMomentary];
                }
              break;
            case 's':
              if ([trackingMode isEqualToString: @"selectOne"])
                {
                  [[platformObject cell] setTrackingMode: NSSegmentSwitchTrackingSelectOne];
                }
              if ([trackingMode isEqualToString: @"selectAny"])
                {
                  [[platformObject cell] setTrackingMode: NSSegmentSwitchTrackingSelectAny];
                }
              break;
	  }
      }
  }

  /* Add content */
  {
    int count = [_content count];
    int index;

    [platformObject setSegmentCount: count];

    for (index = 0; index < count; index++)
      {
	id segment = [_content objectAtIndex: index];

	if ([segment isKindOfClass: [GSMarkupTagSegmentItem class]])
	  {
	    [segment setAttributesOfSegmentedControl: platformObject forSegment: index];
	  }
      }
  }

  return platformObject;
}

@end

@implementation GSMarkupTagSegmentItem

+ (NSString *) tagName
{
  return @"segmentItem";
}

- (id) initPlatformObject: (id)platformObject
{
  return platformObject;
}

- (void) setAttributesOfSegmentedControl: (NSSegmentedControl*)control
			      forSegment: (int)segment
{
  /* label */
  {
    NSString *label = [self localizedStringValueForAttribute: @"label"];
    if (label != nil)
      {
	[control setLabel: label forSegment: segment];
      }
  }

  /* image */
  {
    NSString *image = [_attributes objectForKey: @"image"];
    if (image != nil)
      {
	[control setImage: [NSImage imageNamed: image] forSegment: segment];
      }
  }

  /* menu */
  {
    if (_content != nil && [_content count] > 0)
      {
	id item = [_content objectAtIndex: 0];
	if (item != nil && [item isKindOfClass: [GSMarkupTagMenu class]])
	  {
	    [control setMenu: [item platformObject] forSegment: segment];
	  }
      }
  }

  /* imageScaling */
  {
    NSString *imageScaling = [_attributes objectForKey: @""];
   
    if (imageScaling != nil && [imageScaling length] > 0)
      {
        switch ([imageScaling characterAtIndex: 0])
          {
            case 'a':
              if ([imageScaling isEqualToString: @"axesIndependently"])
                {
                  [[control cell] setImageScaling: NSImageScaleAxesIndependently];
                }
              break;
            case 'n':
              if ([imageScaling isEqualToString: @"none"])
                {
                  [[control cell] setImageScaling: NSImageScaleNone];
                }
              break;
            case 'p':
              if ([imageScaling isEqualToString: @"proportionallyDown"])
                {
                  [[control cell] setImageScaling: NSImageScaleProportionallyDown];
                }
              if ([imageScaling isEqualToString: @"proportionallyUpOrDown"])
                {
                  [[control cell] setImageScaling: NSImageScaleProportionallyUpOrDown];
                }
              break;
	  }
      }
  }

  /* width */
  {
    NSString *width = [_attributes objectForKey: @"width"];
    if (width != nil)
      {
	[control setWidth: [width floatValue] forSegment: segment];
      }
  }

  /* selected */
  if ([self boolValueForAttribute: @"selected"] == 1)
    {
      [control setSelected: YES forSegment: segment];
    }

  /* enabled */
  if ([self boolValueForAttribute: @"enabled"] == 1)
    {
      [control setEnabled: YES forSegment: segment];
    }

  /* toolTip */
  {
    NSString *tooltip = [_attributes objectForKey: @"toolTip"];
    if (tooltip != nil)
      {
	[[control cell] setToolTip: tooltip forSegment: segment];
      }
  }

  /* tag */
  {
    NSString *tag = [_attributes objectForKey: @"tag"];
    if (tag != nil)
      {
	[[control cell] setTag: [tag intValue] forSegment: segment];
      }
  }
}

+ (NSArray *) localizableAttributes
{
  return [NSArray arrayWithObjects: @"label", @"toolTip", nil];
}

@end
