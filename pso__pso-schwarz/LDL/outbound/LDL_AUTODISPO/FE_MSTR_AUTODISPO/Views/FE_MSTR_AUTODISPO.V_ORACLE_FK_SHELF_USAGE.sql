CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_shelf_usage (country, date, item_nr, store,
shc_unit_id, shelfcapacity, corrected_std, capped_std, capped_shelf_usage, actual_shelf_usage, row_count) AS SELECT
 COALESCE(A11.country, A12.country, A13.country) AS country,
 COALESCE(A11.sh_date, A13.fss_date) AS date,
 COALESCE(LPAD(SUBSTR(CAST(A11.sh_item_nr AS STRING), 1, 39), 7, '0'), A12.cap_item_nr, A13.fss_item_nr) AS item_nr,
 COALESCE(A11.sh_store_nr, A12.cap_store_nr, A13.fss_store_nr) AS store,
 COALESCE(CASE
   WHEN COALESCE(A11.sh_qty_aoc, - 1) <> - 1
   THEN A11.sh_aoc_shc_unit_id
   ELSE A11.sh_wawi_shc_unit_id
   END, A12.cap_unit_id) AS shc_unit_id,
   COALESCE(A11.sh_qty_aoc, A11.sh_qty_wawi) * A12.cap_packagecapacity * CAST(A12.cap_quantity AS FLOAT64) AS
 shelfcapacity,
 A13.fss_quantity AS corrected_std,
 LEAST(COALESCE(A11.sh_qty_aoc, A11.sh_qty_wawi) * A12.cap_packagecapacity * CAST(A12.cap_quantity AS FLOAT64), A13.fss_quantity
  ) AS capped_std,
  CASE
  WHEN COALESCE(A11.sh_qty_aoc, A11.sh_qty_wawi) * A12.cap_packagecapacity * CAST(A12.cap_quantity AS FLOAT64) = 0
  THEN 0
  ELSE LEAST(COALESCE(A11.sh_qty_aoc, A11.sh_qty_wawi) * A12.cap_packagecapacity * CAST(A12.cap_quantity AS FLOAT64),
    A13.fss_quantity) / (COALESCE(A11.sh_qty_aoc, A11.sh_qty_wawi) * A12.cap_packagecapacity * CAST(A12.cap_quantity AS FLOAT64)
     )
  END AS capped_shelf_usage,
  CASE
  WHEN COALESCE(A11.sh_qty_aoc, A11.sh_qty_wawi) * A12.cap_packagecapacity * CAST(A12.cap_quantity AS FLOAT64) = 0
  THEN 0
  ELSE A13.fss_quantity / (COALESCE(A11.sh_qty_aoc, A11.sh_qty_wawi) * A12.cap_packagecapacity * CAST(A12.cap_quantity AS FLOAT64)
     )
  END AS actual_shelf_usage,
 1 AS row_count
FROM ldl_autodispo_core.t_oracle_v_dim_shc_date AS A11
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_capacity AS A12 ON A11.country = A12.country AND LPAD(SUBSTR(CAST(A11.sh_item_nr AS STRING)
       , 1, 39), 7, '0') = A12.cap_item_nr AND A11.sh_store_nr = A12.cap_store_nr AND CASE
    WHEN COALESCE(A11.sh_qty_aoc, - 1) <> - 1
    THEN A11.sh_aoc_shc_unit_id
    ELSE A11.sh_wawi_shc_unit_id
    END = A12.cap_unit_id
 FULL JOIN ldl_autodispo_core.t_oracle_v_fk_store_stock AS A13 ON A11.country = A13.country AND A11.sh_date = A13.fss_date
      AND LPAD(SUBSTR(CAST(A11.sh_item_nr AS STRING), 1, 39), 7, '0') = A13.fss_item_nr AND A11.sh_store_nr = A13.fss_store_nr
   
WHERE A12.deleted = 0;