CREATE OR REPLACE FUNCTION ldl_production_p_lew_mart_pit.f_getpitadvperiodenddate(
  pWawiAdvStartDate DATE,
  pAdpAdvStartDate DATE,
  pAdpAdvEndDate DATE,
  pDays INT64
) RETURNS DATE 
AS (
  IF(
    pWawiAdvStartDate = pAdpAdvStartDate
    AND pAdpAdvEndDate <= DATE_ADD(pWawiAdvStartDate, INTERVAL pDays DAY)
    AND pAdpAdvEndDate >= pAdpAdvStartDate,
    pAdpAdvEndDate,
    DATE_ADD(pWawiAdvStartDate, INTERVAL pDays DAY)
  )
);