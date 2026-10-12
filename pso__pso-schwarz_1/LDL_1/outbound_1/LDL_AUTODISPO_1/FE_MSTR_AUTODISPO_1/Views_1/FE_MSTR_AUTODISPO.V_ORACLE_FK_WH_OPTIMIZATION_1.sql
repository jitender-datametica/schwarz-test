CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_wh_optimization_1 (country_1, store_wh, store_nr, item_nr
, date, ord_order_type, ord_storecalculation_id, opt_type_name, order_quantity_in_boxes, opt_before, opt_after,
ord_unit_id, minmax, cutback, wh_next_delivery, r_n) AS SELECT fo.country_1,
 DS.store_wh,
 fo.store_nr,
 fo.item_nr,
 fo.date,
 fo.ord_order_type,
 fo.ord_storecalculation_id,
 fo.opt_type_name,
 fo.order_quantity_in_boxes,
 fo.opt_before,
 fo.opt_after,
 fo.ord_unit_id,
  CASE
  WHEN fo.opt_type_name = 'Warehouse Adjustment'
  THEN fo.opt_before - fo.opt_after
  ELSE NULL
  END AS minmax,
  CASE
  WHEN fo.opt_type_name = 'Warehouse Stock'
  THEN fo.opt_before - fo.opt_after
  ELSE NULL
  END AS cutback,
 COALESCE(DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(FWD.wdel_time_id AS FLOAT64) - 365.25 * 4712 - 2
     AS INTEGER) DAY)), CAST('0000-01-01' AS DATE)) AS wh_next_delivery,
 ROW_NUMBER() OVER (PARTITION BY fo.date, fo.opt_type_name, CAST(fo.ord_storecalculation_id AS STRING), fo.country_1, CAST(DS.store_wh AS STRING)
    , CAST(fo.store_nr AS STRING), fo.item_nr ORDER BY FWD.wdel_time_id IS NULL, FWD.wdel_time_id) AS r_n
FROM (SELECT country_1,
    generation_date AS date,
    ord_order_type,
    store AS store_nr,
    item_nr,
    ord_storecalculation_id,
     ord_pieces_quantity / ord_case_size AS order_quantity_in_boxes,
    CAST(NULL AS BIGNUMERIC) AS opt_before,
    CAST(NULL AS BIGNUMERIC) AS opt_after,
    ord_unit_id,
    'Finalorder' AS opt_type_name,
    'fk_order' AS tabl
   FROM ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_order_1
   UNION ALL
   SELECT country_1,
    date,
    opt_order_type AS ord_order_type,
    store AS store_nr,
    item_nr,
    opt_storecalculation_id AS ord_storecalculation_id,
    CAST(NULL AS NUMERIC) AS order_quantity_in_boxes,
    opt_before,
    opt_after,
    opt_unit_id AS ord_unit_id,
    opt_type_name,
    'fk_optimization' AS tabl
   FROM ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_optimization_1) AS fo
 INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_store_1 AS DS ON fo.store_nr = DS.store_nr AND fo.country_1 = DS.country_1
   
 LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_wh_delivery_1 AS FWD ON CAST(FWD.wdel_wh_nr AS FLOAT64) = DS.store_wh AND fo.item_nr
      = FWD.wdel_item_nr AND DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(FWD.wdel_time_id AS FLOAT64) -
         365.25 * 4712 - 2 AS INTEGER) DAY) > fo.date AND fo.country_1 = FWD.country_1
WHERE fo.ord_order_type IN ('CALCULATION', 'PRECALCULATION')
 AND fo.opt_type_name IN ('Finalorder', 'Warehouse Stock', 'Warehouse Adjustment')
QUALIFY (ROW_NUMBER() OVER (PARTITION BY fo.date, fo.opt_type_name, CAST(fo.ord_storecalculation_id AS STRING), fo.country_1
      , CAST(DS.store_wh AS STRING), CAST(fo.store_nr AS STRING), fo.item_nr ORDER BY FWD.wdel_time_id IS NULL, FWD.wdel_time_id
      )) = 1;