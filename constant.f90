module constant
    implicit none
    real(8), parameter :: PI = 3.141592653589793
    integer, parameter :: maxAtomicNumber = 118
    character(2) :: symbol(maxAtomicNumber)
    data symbol &
    / "H ","He","Li","Be","B ","C ","N ","O ","F ","Ne","Na","Mg","Al","Si","P ","S ", &
      "Cl","Ar","K ","Ca","Sc","Ti","V ","Cr","Mn","Fe","Co","Ni","Cu","Zn","Ga","Ge", &
      "As","Se","Br","Kr","Rb","Sr","Y ","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd", &
      "In","Sn","Sb","Te","I ","Xe","Cs","Ba","La","Ce","Pr","Nd","Pm","Sm","Eu","Gd", &
      "Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","W ","Re","Os","Ir","Pt","Au","Hg", &
      "Tl","Pb","Bi","Po","At","Rn","Fr","Ra","Ac","Th","Pa","U ","Np","Pu","Am","Cm", &
      "Bk","Cf","Es","Fm","Md","No","Lr","Rf","Db","Sg","Bh","Hs","Mt","Ds","Rg","Cn", &
      "Nh","Fl","Mc","Lv","Ts","Og" /
    
    ! https://pubs.acs.org/doi/10.1021/jp8111556  for main group elements
    !
    ! Inorganic Materials, Vol. 37, No. 9, 2001, pp. 871–885. Translated from Neorganicheskie Materialy, Vol. 37, No. 9, 2001, pp. 1031–1046.
    ! Table 9, upper figures for transition metals
    ! Ce - Lu are interpolated from La and Hf
    ! Ac - Og are all fictitious values
    real(8) :: bondi_vdW(maxAtomicNumber)
    data bondi_vdW &
    ! "H ","He","Li","Be","B ","C ","N ","O ","F ","Ne","Na","Mg","Al","Si","P ","S ", &
    / 1.10,1.40,1.81,1.53,1.92,1.70,1.55,1.52,1.47,1.54,2.27,1.73,1.84,2.10,1.80,1.80, &
    ! "Cl","Ar","K ","Ca","Sc","Ti","V ","Cr","Mn","Fe","Co","Ni","Cu","Zn","Ga","Ge", &
      1.75,1.88,2.75,2.31,2.30,2.15,2.05,2.05,2.05,2.05,2.00,2.00,2.00,2.10,1.87,2.11, &
    ! "As","Se","Br","Kr","Rb","Sr","Y ","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd", &
      1.85,1.90,1.83,2.02,3.03,2.49,2.40,2.30,2.15,2.10,2.05,2.05,2.00,2.05,2.10,2.20, &
    ! "In","Sn","Sb","Te","I ","Xe","Cs","Ba","La","Ce","Pr","Nd","Pm","Sm","Eu","Gd", &
      1.93,2.17,2.06,2.06,1.98,2.16,3.43,2.68,2.50,2.48,2.47,2.45,2.43,2.42,2.40,2.38, &
    ! "Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","W ","Re","Os","Ir","Pt","Au","Hg", &
      2.37,2.35,2.33,2.32,2.30,2.28,2.27,2.25,2.20,2.10,2.05,2.00,2.00,2.05,2.10,2.05, &
    ! "Tl","Pb","Bi","Po","At","Rn","Fr","Ra","Ac","Th","Pa","U ","Np","Pu","Am","Cm", &
      1.96,2.02,2.07,1.97,2.02,2.20,3.48,2.83,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40, &
    ! "Bk","Cf","Es","Fm","Md","No","Lr","Rf","Db","Sg","Bh","Hs","Mt","Ds","Rg","Cn", &
      2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40,2.40, &
    ! "Nh","Fl","Mc","Lv","Ts","Og" /
      2.40,2.40,2.40,2.40,2.40,2.40 /

    contains
    integer function atomic_number(element)
        character(2), intent(in) :: element
        integer :: i
    
        atomic_number = 0
        do i = 1, maxAtomicNumber
          if (element == symbol(i)) then
            atomic_number = i
            exit
          end if
        end do
        if (atomic_number == 0) then
          write(6,*) "Error: atomic number for element ", element, " not found"
          call exit(1)
        end if
    end function atomic_number
end module constant
