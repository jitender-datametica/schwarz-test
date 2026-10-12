CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_sales_1 (mod_date, sales_quantity, date, sales_value,
sales_price, sales_receipt_nr, deleted, item_nr, store, country_1, source_extraction_tmsp, snflk_insert_tmsp,
snflk_update_tmsp) AS SELECT mod_date,
 sales_quantity,
 date_ AS date,
 sales_value,
 sales_price,
 sales_receipt_nr,
 deleted,
 sales_item_nr AS item_nr,
 sales_store_nr AS store,
 country_1,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_fk_sales_1
WHERE deleted = 0;