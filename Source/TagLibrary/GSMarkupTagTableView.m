/* -*-objc-*-
   GSMarkupTagTableView.m

   Copyright (C) 2003 Free Software Foundation, Inc.

   Author: Nicola Pero <n.pero@mi.flashnet.it>
   Date: April 2003

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

#include "GSMarkupTagTableView.h"
#include "GSMarkupTagTableColumn.h"


#ifndef GNUSTEP
# include <Foundation/Foundation.h>
# include <AppKit/AppKit.h>
# include "GNUstep.h"
#else
# include <Foundation/NSString.h>
# include <Foundation/NSDictionary.h>
# include <AppKit/NSTableView.h>
#endif

@implementation GSMarkupTagTableView

+ (NSString *) tagName
{
  return @"tableView";
}

+ (Class) defaultPlatformObjectClass
{
  return [NSTableView class];
}

- (void) platformObjectInit
{
  [super platformObjectInit];

  /* dataSource and delegate are outlets.  */

  /* doubleAction */
  {
    NSString *doubleAction = [_attributes objectForKey: @"doubleAction"];
  
    if (doubleAction != nil)
      {
	[(NSTableView *)_platformObject 
			setDoubleAction: NSSelectorFromString (doubleAction)];
      }
  }  

  /* allowsColumnReordering */
  {
    int value = [self boolValueForAttribute: @"allowsColumnReordering"];

    if (value == 1)
      {
	[(NSTableView *)_platformObject setAllowsColumnReordering: YES];
      }
    else if (value == 0)
      {
	[(NSTableView *)_platformObject setAllowsColumnReordering: NO];
      }
  }
  
  /* allowsColumnResizing */
  {
    int value = [self boolValueForAttribute: @"allowsColumnResizing"];

    if (value == 1)
      {
	[(NSTableView *)_platformObject setAllowsColumnResizing: YES];
      }
    else if (value == 0)
      {
	[(NSTableView *)_platformObject setAllowsColumnResizing: NO];
      }
  }

  /* allowsMultipleSelection */
  {
    int value = [self boolValueForAttribute: @"allowsMultipleSelection"];

    if (value == 1)
      {
	[(NSTableView *)_platformObject setAllowsMultipleSelection: YES];
      }
    else if (value == 0)
      {
	[(NSTableView *)_platformObject setAllowsMultipleSelection: NO];
      }
  }

  /* allowsEmptySelection */
  {
    int value = [self boolValueForAttribute: @"allowsEmptySelection"];

    if (value == 1)
      {
	[(NSTableView *)_platformObject setAllowsEmptySelection: YES];
      }
    else if (value == 0)
      {
	[(NSTableView *)_platformObject setAllowsEmptySelection: NO];
      }
  }

  /* allowsColumnSelection */
  {
    int value = [self boolValueForAttribute: @"allowsColumnSelection"];

    if (value == 1)
      {
	[(NSTableView *)_platformObject setAllowsColumnSelection: YES];
      }
    else if (value == 0)
      {
	[(NSTableView *)_platformObject setAllowsColumnSelection: NO];
      }
  }

  /* backgroundColor */
  {
    NSColor *c = [self colorValueForAttribute: @"backgroundColor"];
    if (c != nil)
      {
	[(NSTableView *)_platformObject setBackgroundColor: c];
      }
  }

  /* drawsGrid */
  {
    int value = [self boolValueForAttribute: @"drawsGrid"];

    if (value == 1)
      {
	[(NSTableView *)_platformObject setDrawsGrid: YES];
      }
    else if (value == 0)
      {
	[(NSTableView *)_platformObject setDrawsGrid: NO];
      }
  }

  /* gridColor */
  {
    NSColor *c = [self colorValueForAttribute: @"gridColor"];
    if (c != nil)
      {
	[(NSTableView *)_platformObject setGridColor: c];
      }
  }
  
  /* Now the contents.  An array of tableColumn objects.  */
  {
    int i, numberOfColumns;
    numberOfColumns = [_content count];

    for (i = 0; i < numberOfColumns; i++)
      {
	GSMarkupTagTableColumn *column = [_content objectAtIndex: i];
	
	if (column != nil 
	    && [column isKindOfClass: [GSMarkupTagTableColumn class]])
	  {
	    [(NSTableView *)_platformObject addTableColumn: 
			      [column platformObject]];
	  }
      }
  }
}

- (void) platformObjectAfterInit
{
  [super platformObjectAfterInit];

  /* Adjust columns/table to fit.  */
  [(NSTableView *)_platformObject sizeToFit];  

  /* autosaveName */
  {
    NSString *autosaveName = [_attributes objectForKey: @"autosaveName"];
    if (autosaveName != nil)
      {
	/* Please note that setting the autosaveName should also read
	 * the saved columns' ordering and width (and the table's
	 * one!).  This is why we do this after all columns have been
	 * loaded, and after we've called sizeToFit.  */
	[(NSTableView *)_platformObject setAutosaveName: autosaveName];

	/* If an autosaveName is set, automatically turn on using it!  */
	[(NSTableView *)_platformObject setAutosaveTableColumns: YES];
      }
  }  
}

@end
