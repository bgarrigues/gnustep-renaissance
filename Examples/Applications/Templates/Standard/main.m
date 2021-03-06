/*
 * This file is part of Renaissance's Template Standard Application.
 * You can use it as a starting point for your own programs, no matter
 * what their copyright is.  You can remove this notice and replace it
 * with your own.  This file is in the public domain.
 */

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include <Renaissance/Renaissance.h>

/* Dummy function pointer needed to link Renaissance.dll on Windows.  */
int (*linkRenaissanceIn)(int, const char **) = GSMarkupApplicationMain;

#include "MainController.h"

int main (int argc, const char **argv, char** env)
{
  CREATE_AUTORELEASE_POOL (pool);

  [NSApplication sharedApplication];
  [NSApp setDelegate: [MainController new]];

#ifdef GNUSTEP
  [NSBundle loadGSMarkupNamed: @"MainMenu-GNUstep"  owner: [NSApp delegate]];
#else
  [NSBundle loadGSMarkupNamed: @"MainMenu-OSX"  owner: [NSApp delegate]];
#endif

  [NSApp run];
  RELEASE (pool);
    
  return 0;
}
