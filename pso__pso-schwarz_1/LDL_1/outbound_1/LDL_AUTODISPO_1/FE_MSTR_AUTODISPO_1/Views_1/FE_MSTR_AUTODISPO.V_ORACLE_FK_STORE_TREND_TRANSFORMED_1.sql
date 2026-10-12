CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_store_trend_transformed_1 (country_1, date, store_nr,
store_wh, itemno, fst_percent, fst_storetrend_id, fst_trendtype, scenario, snflk_insert_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_fk_store_trend_transformed_1;