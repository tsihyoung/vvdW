.PHONY:	all, ifort, debug, clean
all:
	gfortran -Wno-line-truncation -ffree-line-length-none -fopenmp -O2 constant.f90 vvdW.f90 -o vvdW.x
ifort:
	ifort -qopenmp -O2 constant.f90 vvdW.f90 -o vvdW.x
debug:
	gfortran -Wno-line-truncation -ffree-line-length-none -g -O2 constant.f90 vvdW.f90 -o vvdW.x
clean:
	rm -f *.o *.mod vvdW.x
