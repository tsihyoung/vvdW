# vvdW

Calculate van der Waals volume

## Building

Run `make all` or `make ifort`;

Or use following commands to compile manually:

- gfortran

`gfortran -fopenmp -O2 constant.f90 vvdW.f90 -o vvdW.x`

- ifort

`ifort -qopenmp -O2 constant.f90 vvdW.f90 -o vvdW.x`
