CREATE OR REPLACE FUNCTION `ldl_production_p_lew_mart_pit.f_getadvperiodid`(
  pAdvWeekID INT64,
  pStartDate DATE,
  pEndDate DATE
)
RETURNS INT64
AS (
  IF(
    pStartDate IS NULL 
      OR pEndDate IS NULL
      OR pStartDate > pEndDate
      OR pAdvWeekID < 0,
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
