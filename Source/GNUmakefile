#
#  Copyright (C) 2002 Free Software Foundation, Inc.
#
#  Author: Nicola Pero <n.pero@mi.flashnet.it>
#
#  This file is part of GNUstep Renaissance.
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Library General Public
#  License as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
#  Library General Public License for more details.
#
#  You should have received a copy of the GNU Library General Public
#  License along with this library; see the file COPYING.LIB.
#  If not, write to the Free Software Foundation,
#  59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

include $(GNUSTEP_MAKEFILES)/common.make

NATIVE_LIBRARY_NAME = Renaissance
VERSION = 0.9.0

# We link/merge all the code in the subdirectories into the
# Renaissance library.  It's in subdirectories to keep things clean
# and easier to understand.  It's also possible that for very
# advanced/perverse usages you might need to build only a part of
# Renaissance in a separate library ... I've provided makefiles to do
# it.  Go into AutoLayout or Markup (the part you need standalone),
# and type 'make -f GNUmakefile.standalone' in there, to build them as
# standalone libraries.

Renaissance_SUBPROJECTS = AutoLayout Markup TagLibrary

# All the other headers are installed by the subprojects.
Renaissance_HEADER_FILES = Renaissance.h Markup.h GNUstep.h
Renaissance_HEADER_FILES_INSTALL_DIR = Renaissance

include $(GNUSTEP_MAKEFILES)/native-library.make
