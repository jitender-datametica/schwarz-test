CREATE OR REPLACE FUNCTION FE_MSTR_LIDLDIGITAL.F_COUNT_WORKING_DAYS(DATE1 DATE, DATE2 DATE)
/*
    Count the working days (Mo-Fr) between and including two dates.
    DATE1 must be smaller or equal to DATE2, otherwise, 0 is returned.
    Replicates the functionality of the QlikView function networkdays().
*/
RETURNS NUMBER(38,0)
LANGUAGE SQL
AS $$
        SELECT COUNT(1) FROM
            CORE.T_DIM_CAL_DAY_1 DIM_CD
        WHERE
            DIM_CD.CAL_DT BETWEEN DATE1 AND DATE2
            AND DAY_OF_WEEK_SHORT_NAME IN ('Mo', 'Di', 'Mi', 'Do', 'Fr')
$$
;
