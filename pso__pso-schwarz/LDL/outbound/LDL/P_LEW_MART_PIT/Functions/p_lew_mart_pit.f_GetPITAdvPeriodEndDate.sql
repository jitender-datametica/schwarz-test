/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for f_GetPITAdvPeriodEndDate
#-------------------------------------------------------------------------------
# Describtion: f_GetPITAdvPeriodEndDate
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-03-12 Nikolai Toknov    Initial version
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Function	:	f_GetPITAdvPeriodEndDate(pWawiAdvStartDate DATE, pAdpAdvStartDate DATE, pAdpAdvEndDate DATE, pDays INTEGER)
Input		:   pWawiAdvStartDate DATE 
				pAdpAdvStartDate DATE
				pAdpAdvEndDate DATE
				pDays DATE
Return		:	Parameter DATE --> Default is [pWawiAdvStartDate+pDays]
Convert		:	None    
Description	: 	Find end date for adv.period
Example		:	SELECT f_GetPITAdvPeriodEndDate('2022-01-01'::DATE, '2022-01-02'::DATE, '2022-01-05'::DATE, 6 );
------------------------------------------------------------------------
*/
CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_getpitadvperiodenddate(
    p_wawi_advstartdate DATE,
    p_adp_advstartdate DATE,
    p_adp_advenddate DATE,
    p_days INT64
)
RETURNS DATE
AS (
    IF(
        p_wawi_advstartdate = p_adp_advstartdate
        AND p_adp_advenddate <= DATE_ADD(p_wawi_advstartdate, INTERVAL p_days DAY)
        AND p_adp_advenddate >= p_adp_advstartdate,
        p_adp_advenddate,
        DATE_ADD(p_wawi_advstartdate, INTERVAL p_days DAY)
    )
);

-- End of f_GetPITAdvPeriodEndDate


/*
select f_GetPITAdvPeriodEndDate('2022-01-01'::DATE, '2022-01-02'::DATE, '2022-01-05'::DATE, 6 ); 
-- pWawiAdvStartDate<>pAdpAdvStartDate =>  out:= default (pWawiAdvStartDate+6)
-- 2022-01-07

select f_GetPITAdvPeriodEndDate('2022-01-01'::DATE, '2022-01-01'::DATE, '2022-01-05'::DATE, 6 ) ;
-- pWawiAdvStartDate=pAdpAdvStartDate and  pAdpAdvEndDate<pWawiAdvStartDate+6 =>  out:= pAdpAdvEndDate
-- 2022-01-05


select f_GetPITAdvPeriodEndDate('2022-01-01'::DATE, '2022-01-01'::DATE, '2022-01-15'::DATE, 6 );
-- pWawiAdvStartDate=pAdpAdvStartDate and  pAdpAdvEndDate>pWawiAdvStartDate+6 =>   out:= default (pWawiAdvStartDate+6)
-- 2022-01-07


select f_GetPITAdvPeriodEndDate('2022-01-01'::DATE, null, null , 6 ) ;
-- no ADP data =>  out:= default (pWawiAdvStartDate+6)
-- 2022-01-07

select f_GetPITAdvPeriodEndDate('2022-01-01'::DATE, '2022-01-01'::DATE, null , 6 ) ;
-- no ADP data =>  out:= default (pWawiAdvStartDate+6)
-- 2022-01-07
*/

/* --- EOF - END OF FILE --- */
