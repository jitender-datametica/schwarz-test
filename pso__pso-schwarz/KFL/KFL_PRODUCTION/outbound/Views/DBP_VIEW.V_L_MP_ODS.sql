CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_mp_ods AS SELECT mandant_id,
 mp_ods_id,
 mp_ods_bez
FROM kfl_production_dbp_data.l_mp_ods;