CREATE OR REPLACE FUNCTION ldl_production_p_lew_mart_pit.f_getpricerange(
  p_min_price NUMERIC,
  p_max_price NUMERIC
)
RETURNS STRING
AS (
  IF(
    ROUND(p_min_price, 2) = ROUND(p_max_price, 2),

    REPLACE(
      REPLACE(
        FORMAT("%.2f", p_max_price),  
      ",", ""),                      
    ".", ""),                        
    CONCAT(
      REPLACE(
        REPLACE(FORMAT("%.2f", p_min_price), ",", ""),
      ".", ""),
      " – ",
      REPLACE(
        REPLACE(FORMAT("%.2f", p_max_price), ",", ""),
      ".", "")
    )
  )
);
