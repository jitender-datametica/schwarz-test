CREATE OR REPLACE FUNCTION `ldl_production_p_lew_mart_pit.f_getbrandtypecd`(
  p_BUYING_LIST_TYPE_ID INT64
)
RETURNS STRING
AS (
  IF(
    p_BUYING_LIST_TYPE_ID = -1 OR p_BUYING_LIST_TYPE_ID IS NULL,
    'N/A',
    IF(
      p_BUYING_LIST_TYPE_ID IN (1,3,5,7,9,11),
      'M',
      'EM'
    )
  )
);