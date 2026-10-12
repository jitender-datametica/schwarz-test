CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit_onprem.f_getadvperiodid(
    pStartDate DATE,
    pEndDate DATE
)
RETURNS INT64
AS (
-- ---------------------------------------------------------------------
-- Function	:	f_GetAdvPeriodID(pStartDate DATE, pEndDate DATE)
-- Input		:   pStartDate DATE --> iff [NULL] then 9
--  				pEndDate DATE --> iff [NULL] then 9
-- Return		:	Parameter INTEGER --> Default is [-1]
-- Convert		:	None    
-- Description	: 	Retrieves the Adv Period ID Special Format 24 --> Tuesday to Thursday
-- Example		:	SELECT f_GetAdvPeriodID(''2021-10-02'',''2021-10-08'') AS ADV_PERIOD_ID
-- ------------------------------------------------------------------------
-- 
-- History:
-- 1.0  2021-07-01 Andreas Kurz    Initial version
-- 1.1  2021-08-30 Mike Davis      Checks, formatting
-- 1.2	2021-09-13 Massimo Morelli Fixed SCHEMA, added COMMIT

  IF(
    pStartDate IS NULL OR pEndDate IS NULL OR pStartDate > pEndDate,
    -1,
    (MOD(EXTRACT(DAYOFWEEK FROM pStartDate) + 5, 7) + 1) * 10
    + (MOD(EXTRACT(DAYOFWEEK FROM pEndDate) + 5, 7) + 1)
  )
);