program vdW_volume
    use constant
    implicit none
    integer :: argNum
    character(200) :: filename
    integer :: nAtom
    integer :: i, j
    character(2), allocatable :: element(:)
    real(8), allocatable :: xyz(:,:), radius(:)
    real(8) :: d, volume

    argNum = command_argument_count()
    if (argNum == 1) then
        call get_command_argument(1, filename)
        write(6,*) 'Read in file : ', trim(filename)
    else
        write(6,*) 'Usage: ./vvdW.x filename.xyz'
        stop
    end if

    open(10, file=trim(filename), status='old')
    read(10,*) nAtom
    allocate(element(nAtom), xyz(3,nAtom), radius(nAtom))
    read(10,*)
    do i = 1, nAtom
        read(10,*) element(i), xyz(:,i)
    end do
    close(10)

    do i = 1, nAtom
        j = atomic_number(element(i))
        radius(i) = bondi_vdW(j)
    end do

    volume = 0d0
    !$OMP PARALLEL DO PRIVATE(i, j, d) REDUCTION(+:volume)
    do i = 1, nAtom
        volume = volume + sphere_volume(radius(i))
        do j = 1, i - 1
            d = norm2(xyz(:,i) - xyz(:,j))
            volume = volume + intersection_volume(radius(i), radius(j), d)
        end do
    end do
    !$OMP END PARALLEL DO
    deallocate(element, xyz, radius)
    write(6,'(A,F16.8)') ' Volume (Å^3) : ', volume

    contains
    pure real(8) function sphere_volume(r)
        real(8), intent(in) :: r
        sphere_volume = 4 * PI * r**3 / 3
    end function sphere_volume

    ! calculate intersection volume of two spheres
    pure real(8) function intersection_volume(r1, r2, d)
        real(8), intent(in) :: r1, r2, d
        if (d >= r1 + r2) then
            intersection_volume = 0d0
        else
            intersection_volume = PI * (r1 + r2 - d)**2 * (d**2 + 2 * d * (r1 + r2) - 3 * (r1 - r2)**2) / (12 * d)
        end if
    end function intersection_volume
end program vdW_volume
