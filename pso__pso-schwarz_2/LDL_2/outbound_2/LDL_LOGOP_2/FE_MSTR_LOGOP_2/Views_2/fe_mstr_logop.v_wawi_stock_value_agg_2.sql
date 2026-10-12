CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_stock_value_agg_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item_2 nr'), reported_date OPTIONS(description='T1001 Date'), pieceqty_cal
OPTIONS(description='Stock Expected'), pieceqty_real OPTIONS(description='Stock Counted'), pieceqty_diff
OPTIONS(description='Stock Difference'), valid_seq OPTIONS(description='Valid Sequences of Tech Differences'),
retail_price OPTIONS(description='Retail Price from Bestandartikel_2'), dwh_load_id OPTIONS(description='Load id'),
dwh_created OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'),
dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to OPTIONS(description='Valid to date'), deleted_fg
OPTIONS(description='Flag if record is deleted')) AS WITH BASE_STOCK AS (SELECT *
  FROM ldl_logop_fe_mstr_logop.v_wawi_stock_value_add_2 AS BAS), FLAGGED_STOCK AS (SELECT client_id,
   wh_id,
   artikelnr,
   reported_date,
   pieceqty_diff,
    CASE
    WHEN ABS(pieceqty_diff) > 1
    THEN 1
    ELSE 0
    END AS diff_non_zero,
   LAG(CASE
     WHEN ABS(pieceqty_diff) > 1
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, artikelnr ORDER BY reported_date IS NULL, reported_date)
   AS prev_diff_non_zero,
   MAX(reported_date) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_reported_date
  FROM BASE_STOCK), COUNTED_STOCK AS (SELECT client_id,
   wh_id,
   artikelnr,
   reported_date,
   pieceqty_diff,
   diff_non_zero,
   prev_diff_non_zero,
   max_reported_date,
    CASE
    WHEN reported_date = max_reported_date AND diff_non_zero = 1 AND prev_diff_non_zero = 1
    THEN 1
    ELSE 0
    END AS valid_fg
  FROM FLAGGED_STOCK), VALID_STOCK AS (SELECT client_id,
   wh_id,
   artikelnr,
   reported_date,
   pieceqty_diff,
   diff_non_zero,
   prev_diff_non_zero,
   max_reported_date,
   valid_fg,
    CASE
    WHEN (SUM(valid_fg) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, artikelnr ORDER BY reported_date IS NULL
         DESC, reported_date DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 0
    THEN 0
    ELSE CASE
     WHEN diff_non_zero = 0
     THEN 0
     ELSE 1
     END
    END AS valid_seq,
   SUM(CASE
     WHEN diff_non_zero = 0
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, artikelnr ORDER BY reported_date IS NULL DESC,
      reported_date DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS zero_count
  FROM COUNTED_STOCK), ADJUSTED_VALIDITY AS (SELECT client_id,
   wh_id,
   artikelnr,
   reported_date,
   pieceqty_diff,
   diff_non_zero,
   prev_diff_non_zero,
   max_reported_date,
   valid_fg,
   valid_seq,
   zero_count,
    CASE
    WHEN zero_count > 0
    THEN 0
    ELSE valid_seq
    END AS adj_valid_seq
  FROM VALID_STOCK) (SELECT bs.client_id,
   bs.wh_id,
   bs.artikelnr,
   bs.reported_date,
   bs.pieceqty_cal,
   bs.pieceqty_real,
   bs.pieceqty_diff,
   av.adj_valid_seq AS valid_seq,
   bs.retail_price,
   bs.dwh_load_id,
   bs.dwh_created,
   bs.dwh_updated,
   bs.dwh_valid_from,
   bs.dwh_valid_to,
   bs.deleted_fg
  FROM BASE_STOCK AS bs
   INNER JOIN ADJUSTED_VALIDITY AS av ON bs.client_id = av.client_id AND bs.wh_id = av.wh_id AND bs.artikelnr = av.artikelnr
       AND bs.reported_date = av.reported_date);