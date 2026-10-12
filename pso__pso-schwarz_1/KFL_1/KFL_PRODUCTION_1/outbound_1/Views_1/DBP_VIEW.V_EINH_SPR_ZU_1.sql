CREATE OR REPLACE VIEW kfl_production_dbp_view.v_einh_spr_zu_1 AS SELECT einh_id,
 mandant_id,
 spr_id,
 einh_bez_kaufm,
 einh_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.einh_spr_zu_1;