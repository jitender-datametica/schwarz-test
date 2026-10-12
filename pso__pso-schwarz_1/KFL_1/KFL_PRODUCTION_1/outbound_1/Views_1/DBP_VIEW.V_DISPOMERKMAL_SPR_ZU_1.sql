CREATE OR REPLACE VIEW kfl_production_dbp_view.v_dispomerkmal_spr_zu_1 AS SELECT mandant_id,
 dispomerkmal,
 spr_id,
 dispomerkmal_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.dispomerkmal_spr_zu_1;