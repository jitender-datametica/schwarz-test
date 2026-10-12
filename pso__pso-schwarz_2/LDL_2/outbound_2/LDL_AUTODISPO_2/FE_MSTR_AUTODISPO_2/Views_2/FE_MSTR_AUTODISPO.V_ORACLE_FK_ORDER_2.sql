CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_order_2 (item_nr, deleted, ord_storecalculation_id,
store, ord_unit_id, country_2, ord_order_type, ord_case_size, date, generation_date, ord_quantity, ord_unit_quantity,
ord_pieces_quantity, pallet_sports, quantity_in_boxes, avg_quantity) AS SELECT ord_item_nr AS item_nr,
 deleted,
 ord_storecalculation_id,
 ord_store_nr AS store,
 ord_unit_id,
 country_2,
 ord_order_type,
 ord_case_size,
 DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(ord_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS date,
 DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(ord_gen_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS
 generation_date,
 ord_quantity,
 ord_unit_quantity,
 ord_pieces_quantity,
  CASE
  WHEN ord_unit_id = 2
  THEN CAST(ROUND(ord_quantity, 0) AS INTEGER) / 2
  WHEN ord_unit_id = 3
  THEN CAST(CAST(ROUND(ord_quantity, 0) AS INTEGER) AS BIGNUMERIC)
  ELSE NULL
  END AS pallet_sports,
  ord_pieces_quantity / ord_case_size AS quantity_in_boxes,
 ROUND(AVG(ord_pieces_quantity / ord_case_size) OVER (PARTITION BY country_2, CAST(ord_store_nr AS STRING), ord_item_nr,
     ord_order_type, CAST(ord_unit_id AS STRING), EXTRACT(DAYOFWEEK FROM DATE(DATE_ADD(CAST('0000-01-01' AS DATE),
         INTERVAL CAST(ord_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY))) - 1 ORDER BY DATE(DATE_ADD(CAST('0000-01-01' AS DATE)
       ,INTERVAL CAST(ord_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY)) IS NULL, DATE(DATE_ADD(CAST('0000-01-01' AS DATE)
       ,INTERVAL CAST(ord_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY)) ROWS BETWEEN 11 PRECEDING AND CURRENT ROW), 2
  ) AS avg_quantity
FROM ldl_autodispo_core.t_oracle_v_fk_order_2
WHERE deleted = 0;