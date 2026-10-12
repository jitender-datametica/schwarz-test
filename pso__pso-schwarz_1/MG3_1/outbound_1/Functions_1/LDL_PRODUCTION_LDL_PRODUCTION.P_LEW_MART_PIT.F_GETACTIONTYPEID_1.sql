CREATE OR REPLACE FUNCTION `ldl_production_p_lew_mart_pit.f_getactiontypeid`(
  pBuyingListTypeID INT64,
  pItemGrpIntSrcCD STRING
)
RETURNS INT64
AS (
  IF(
    pBuyingListTypeID <= -1
      OR pBuyingListTypeID IS NULL
      OR SAFE_CAST(pItemGrpIntSrcCD AS INT64) IS NULL,
    -1,
    IF(
      pBuyingListTypeID IN (7, 8, 16),
      IF(
        SAFE_CAST(pItemGrpIntSrcCD AS INT64) IN (7, 70),
        2,
        3
      ),
      -- PV not present → return -1
      -- @2nd Increment need to be corrected 1 and than joined to SFO PV Info
      -1
    )
  )
);
