CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_storecalculations_2 (country_2, storecalculation_id,
order_type, generation_date, mod_date, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_fk_storecalculation_2;