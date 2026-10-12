/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for CNTL_PROCESSING_PARAM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-30 Mike Davis      Checks, formatting
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA, added COMMIT
#  1.3  2024-02-13 Andreas Kurz 	Changed Format to:
#										YYYYWW + YYYYMMDD + YYYYMMDD
#  1.4  2024-03-27 Nikolai Toknov 	Changed Format to:
#										YYYYWW + MMDD + MMDD to avoid an error in MSTR (Cannot convert value in the driver from type:FIXED(null,null) to type:Long, value=202403202401182024012401.. 
#																						Error in Process method of Component: QueryEngineServer, ... Error Code= -2147212544.)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE 		LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA          P_LEW_MART_PIT_1;
 */

/* 
---------------------------------------------------------------------
Function	:	f_GetAdvPeriodID(pAdvWeekID INTEGER, pStartDate DATE, pEndDate DATE)
Input		:   pAdvWeekID INTEGER
				pStartDate DATE --> iff [NULL] then 9
				pEndDate DATE --> iff [NULL] then 9
Return		:	Parameter INTEGER --> Default is [-1]
Convert		:	None    
Description	: 	Retrieves the Adv Period ID Special Format 24 --> Tuesday to Thursday
Example		:	SELECT f_GetAdvPeriodID('2021-10-02','2021-10-08) AS ADV_PERIOD_ID
------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_getadvperiodid(
  pAdvWeekID INT64,
  pStartDate DATE,
  pEndDate DATE
)
RETURNS INT64
AS (
  IF(
    pStartDate IS NULL OR pEndDate IS NULL OR pStartDate > pEndDate OR pAdvWeekID < 0,
    -1,
    SAFE_CAST(
      CONCAT(
        CAST(pAdvWeekID AS STRING),
        FORMAT_DATE('%y%m%d', pStartDate),
        FORMAT_DATE('%y%m%d', pEndDate)
      ) AS INT64
    )
  )
);

-- End of f_GetAdvPeriodID 

/*
SELECT
	DATE_PART(dayofweekiso, inp.adv_period_start_dt::DATE)::INTEGER * 10::INTEGER
	+
	DATE_PART(dayofweekiso, inp.adv_period_end_dt::DATE)::INTEGER
	,f_GetAdvPeriodID(inp.adv_period_start_dt::DATE,inp.adv_period_end_dt::DATE) AS ADV_PERIOD_ID
FROM 
(
SELECT
	  to_date('2021-10-25','YYYY-MM_1-DD') AS adv_period_start_dt
	, to_date('2021-10-28','YYYY-MM_1-DD') AS adv_period_end_dt
) inp
;

--SELECT f_GetAdvPeriodID(202110,'2021-10-02'::DATE,'2021-10-08'::DATE) AS ADV_PERIOD_ID
*/

/* --- EOF - END OF FILE --- */