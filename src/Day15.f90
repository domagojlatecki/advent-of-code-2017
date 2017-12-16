PROGRAM Day15
    integer :: arg_count
    integer :: first
    integer :: second
    integer :: num_same
    character(len=16) :: arg

    arg_count = COMMAND_ARGUMENT_COUNT()

    IF (arg_count /= 2) THEN
        PRINT *, "Two arguemnts are expected"
        CALL EXIT(1)
    END IF

    CALL GETARG(1, arg)
    READ(arg, *) first

    CALL GETARG(2, arg)
    READ(arg, *) second

    num_same = 0

    DO i = 1, 40000000, 1
        first = MOD(int8(first) * 16807, 2147483647)
        second = MOD(int8(second) * 48271, 2147483647)

        IF (IAND(first, z'FFFF') == IAND(second, z'FFFF')) THEN
            num_same = num_same + 1
        END IF
    END DO

    PRINT *, num_same
END PROGRAM Day15
