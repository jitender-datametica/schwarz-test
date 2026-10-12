CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_truckfilling_1 (country_1, store_nr, trf_deliverydate_id
, date, storecalculation_id, order_type, trf_palettecount, mod_date, source_extraction_tmsp, snflk_insert_tmsp,
snflk_update_tmsp) AS SELECT country_1,
 trf_store_nr AS store_nr,
 trf_deliverydate_id,
 trf_deliverydate AS date,
 trf_storecalculation_id AS storecalculation_id,
 'TRUCKFILLING' AS order_type,
 trf_palettecount,
 mod_date,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_fk_truckfilling_1;