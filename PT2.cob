        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. PT2.
AUTHOR. John Stephen Johnson.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
        SELECT PT2FILE ASSIGN TO "NEWEMP.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        ACCESS IS SEQUENTIAL.
DATA DIVISION.
FILE SECTION.
FD PT2FILE.
01 PEmployeeAttributes.
        02 PEMPNUM PIC X(7).
        02 PEMPLNAME PIC X(12).
        02 PEMPFNAME PIC X(13).
        02 PEMPTYPE PIC X(6).
        02 PEMPTITLE PIC X(17).
        02 PSPACES PIC X(5).
        02 PEMPSSNF3 PIC X(3).
        02 PEMPSSNN3 PIC X(3).
        02 PEMPSSNL3 PIC X(3).
        02 PDOTS PIC X(24).
        02 PMON PIC X(2).
        02 PDAY PIC X(2).
        02 PYEAR PIC X(4).
        02 PRATE PIC 9(11).
        02 PSTATUS PIC X(1).

01 PLINECOUNT PIC 9(2).
01 PLINECALC PIC 9(3).      
01 PEVEN PIC 9(2) VALUE 2.
01 PREM PIC 9(2).

WORKING-STORAGE SECTION.
01 SEmployeeA.
        02 SEMPNUM PIC X(7).
        02 SEMPLNAME PIC X(12).
        02 SEMPFNAME PIC X(13).
        02 SEMPTYPE PIC X(6).
        02 SEMPTITLE PIC X(17).
        02 SSPACES PIC X(5).
        02 SEMPSSNF3 PIC X(3).
        02 SEMPSSNN3 PIC X(3).
        02 SEMPSSNL3 PIC X(3).
        02 SDOTS PIC X(24).
        02 SMON PIC X(2).
        02 SDAY PIC X(2).
        02 SYEAR PIC X(4).
        02 SRATE PIC 9(11).
        02 SSTATUS PIC X(1).

01 SHEMPCOUNT PIC 9(3).
01 SSEMPCOUNT PIC 9(3).
01 SAVGHCALC  PIC 9(8).
01 SAVGSCALC  PIC 9(8).
01 HOURLYAVG  PIC 9(7).
01 SALARYAVG  PIC 9(7).
01 SLINECOUNT PIC 9(2).
01 SLINECALC PIC 9(3).
01 SEVEN PIC 9(2) VALUE 2.
01 SREM PIC 9(2).
01 DELIM PIC X(30).
01 PGNUM PIC 9(3) VALUE 1.
01 TODAY-DATE.
      03 YR   PIC 9(4).
      03 MN   PIC 9(2).
      03 DY   PIC 9(2).
01 FileEnd PIC A(1).

PROCEDURE DIVISION.
      DISPLAY SPACES 
      MOVE FUNCTION CURRENT-DATE TO TODAY-DATE
      DISPLAY MN"/"DY"/"YR 
      SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES 
      SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES
      SPACES SPACES SPACES SPACES SPACES SPACES SPACES "THE BEST IS YET TO COME, INC." SPACES SPACES SPACES SPACES SPACES 
      SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES 
      SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES "PAGE" SPACES PGNUM

      DISPLAY SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES 
      SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES 
      SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES
      SPACES "EMPLOYEE CLASSIFICATION AND PAY"

DISPLAY SPACES
DISPLAY SPACES
DISPLAY "SSN" SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES 
SPACES SPACES SPACES SPACES "LAST" SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES
SPACES SPACES SPACES SPACES SPACES "FIRST"
SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES 
"EMP ID" SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES
SPACES SPACES "TITLE" SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES
SPACES SPACES SPACES SPACES SPACES SPACES SPACES"TYPE"
SPACES SPACES SPACES SPACES "DATE" SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES "RATE"
SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES "ST"
DISPLAY SPACES 
OPEN INPUT PT2FILE.        
        PERFORM UNTIL FileEnd='Y'
            READ PT2FILE INTO SEmployeeA 
                AT END MOVE 'Y' TO FileEnd
                NOT AT END COMPUTE SLINECOUNT = SLINECOUNT + 1
                DIVIDE SEVEN INTO SLINECOUNT GIVING SLINECALC REMAINDER SREM


                IF SREM = 0 THEN
                DISPLAY SEMPSSNF3 "-" SEMPSSNN3 "-" SEMPSSNL3 WITH NO ADVANCING
                    STRING SEMPLNAME
                        DELIMITED BY SPACE INTO DELIM
                    MOVE DELIM TO SEMPLNAME
                    MOVE 0 TO DELIM
                
                
                DISPLAY SPACES SPACES SPACES SPACES SPACES SPACES SEMPLNAME
                SPACES SPACES SPACES SEMPFNAME SPACES SPACES SPACES SPACES SPACES SPACES SPACES SEMPNUM
                SPACES SPACES SPACES SPACES SPACES SPACES SPACES SPACES
                SPACES SPACES SPACES SEMPTITLE SPACES SPACES
                SEMPTYPE SPACES SPACES SPACES SPACES SPACES SMON "/" SDAY "/" SYEAR
                SRATE SPACES SPACES SPACES SPACES SPACES SSTATUS


                 IF SSTATUS = "H" THEN
                  COMPUTE SHEMPCOUNT = SHEMPCOUNT + 1
                  COMPUTE SAVGHCALC = SAVGHCALC + SRATE
                 ELSE
                  COMPUTE SSEMPCOUNT = SSEMPCOUNT + 1
                  COMPUTE SAVGSCALC = SAVGSCALC + SRATE
                 
                 DIVIDE SHEMPCOUNT INTO SAVGHCALC GIVING HOURLYAVG
                 DIVIDE SSEMPCOUNT INTO SAVGSCALC GIVING SALARYAVG

                 
                 
           END-READ
        END-PERFORM
DISPLAY SPACES
DISPLAY SPACES 
DISPLAY "NUMBER OF EMPLOYEE RECORDS READ:" SPACES SPACES SLINECALC
DISPLAY "NUMBER OF HOURLY EMPLOYEES:" SPACES SPACES SPACES SPACES SPACES SPACES SPACES SHEMPCOUNT SPACES SPACES SPACES 
"AVERAGE HOURLY RATE:" SPACES SPACES SPACES SPACES SPACES "$" HOURLYAVG
DISPLAY "NUMBER OF SALARIED EMPLOYEES:" SPACES SPACES SPACES SPACES SPACES SSEMPCOUNT SPACES SPACES SPACES 
"AVERAGE SALARIED RATE:" SPACES SPACES SPACES "$" SALARYAVG
CLOSE PT2FILE.
        
STOP RUN.
