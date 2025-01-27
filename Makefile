# variables
HDOBJECTS = jphide.o bf.o
SKOBJECTS = jpseek.o bf.o
CROBJECTS = jpcrack.o bf.o

## flags
CFLAGS_COMMON = -O2

### big-endian Blowfish only flags
BE_CFLAGS = -DBF_BE
### little-endian Blowfish only flags
### (might break Blowfish which is big-endian by default)
LE_CFLAGS = -DBF_LE

JP_CFLAGS = $(CFLAGS_COMMON) \
	    -I./jpeg-8a
BF_CFLAGS = $(CFLAGS_COMMON)

#LDFLAGS = -L./jpeg-8a/.libs
LDFLAGS = -L/usr/local/lib
LDLIBS = -ljpeg


## programs
INSTALL = install
INSTALL_DIR = $(INSTALL) -d -m 0755
INSTALL_BIN = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 0644

## install paths
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# targets
TARGETS = jphide jpseek jpcrack
all: $(TARGETS)
jphide: $(HDOBJECTS)
jpseek: $(SKOBJECTS)
jpcrack: $(CROBJECTS)

# object rules
bf.o:			CFLAGS=$(BF_CFLAGS)
jphide.o jpseek.o jpcrack.o:	CFLAGS=$(JP_CFLAGS)

# dependencies
bf.c: bf.h bf_config.h
jphide.c: ltable.h version.h bf.h
jpseek.c: ltable.h version.h bf.h
jpcrack.c: ltable.h version.h bf.h

# other targets
clean:
	$(RM) \
		$(TARGETS) \
		$(HDOBJECTS) \
		$(SKOBJECTS) \
		$(CROBJECTS)

distclean: clean
	$(RM) *~ .*~ \#*\#

install: all
	$(INSTALL_DIR) $(DESTDIR)$(BINDIR)
	$(INSTALL_BIN) $(TARGETS) $(DESTDIR)$(BINDIR)

.PHONY: all clean distclean install

#jphide.o: jphide.c cdjpeg.h jinclude.h jconfig.h jpeglib.h jmorecfg.h jerror.h cderror.h jversion.h ltable.h
#jpseek.o: jpseek.c cdjpeg.h jinclude.h jconfig.h jpeglib.h jmorecfg.h jerror.h cderror.h jversion.h ltable.h
