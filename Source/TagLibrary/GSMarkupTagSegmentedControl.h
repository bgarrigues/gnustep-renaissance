/* -*-objc-*-
   GSMarkupTagSegmentedControl.h

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

#ifndef _GNUstep_H_GSMarkupTagSegmentedControl
#define _GNUstep_H_GSMarkupTagSegmentedControl

#include "GSMarkupTagControl.h"

@interface GSMarkupTagSegmentedControl : GSMarkupTagControl
@end

@interface GSMarkupTagSegmentItem : GSMarkupTagObject

- (void) setAttributesOfSegmentedControl: (NSSegmentedControl*)control
			      forSegment: (int)segment;

@end

#endif /* _GNUstep_H_GSMarkupTagSegmentedControl */
