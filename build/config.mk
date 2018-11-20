INC+=

## See if FFTW3_HOME is set; if so, use it
ifdef FFTW3_HOME
	INC+=-I${FFTW3_HOME}/include
	LIBFFTW=-L${FFTW3_HOME}/lib -lfftw3
else
	LIBFFTW=-lfftw3
endif

#CFLAGS:=-Wall -g -std=c99 -O3 -fpic -fstrict-aliasing -Wstrict-aliasing -D_GNU_SOURCE
#CFLAGS:=-Wall -O3 -fpic -fstrict-aliasing -Wstrict-aliasing -I/Users/boyle/.continuum/anaconda3/include
CFLAGS:=-Wall -std=c89 -O3 -fpic -fstrict-aliasing -Wstrict-aliasing -I/Users/boyle/.continuum/anaconda3/include -Wextra -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wno-declaration-after-statement -Wno-unused-parameter

# Optional portions of code
#CFLAGS+= -DUSE_FITSIO
#CFLAGS+= -DUSE_HEALPIX

CC:=gcc $(CFLAGS)

# Libraries for optional portions
#LIBGSL=-lgsl -lgslcblas
#LIBFITSIO=-lcfitsio
#LIBCHEALPIX=-lchealpix
# In e.g. RHEL/Fedora this is provided by the gsl-devel, cfitsio-devel, and chealpix-devel package
