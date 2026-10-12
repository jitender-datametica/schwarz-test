CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_optimization_1 (country_1, date, opt_storecalculation_id
, opt_order_type, item_nr, store, opt_type_name, opt_before, opt_after, opt_unit_id, cutback, mod_date, deleted,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT country_1,
 DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(opt_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS date,
 opt_storecalculation_id,
 opt_order_type,
 opt_item_nr AS item_nr,
 opt_store_nr AS store,
 opt_type_name,
 opt_before,
 opt_after,
 opt_unit_id,
  CASE
  WHEN opt_type_name = 'Warehouse Stock'
  THEN opt_before - opt_after
  ELSE NULL
  END AS cutback,
 mod_date,
 deleted,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_fk_optimization_1
WHERE deleted = 0;