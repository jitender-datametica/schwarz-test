CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_minmax (country, mm_wh, mm_gen_time_id,
mm_order_type_id, mm_order_type, mm_packageamount, mm_packageamount_min, mm_packageamount_max, mod_date,
mm_calculationmethod, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp, date_) AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_fk_minmax;