CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_delivery (del_packagecapacity, mod_date, date,
item_nr, store, del_amount, country, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT
 del_packagecapacity,
 mod_date,
 DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(del_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS date,
 del_item_nr AS item_nr,
 del_store_nr AS store,
 del_amount,
 country,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_fk_delivery;