CREATE OR REPLACE VIEW kfl_production_dbp_view.v_verursacher_spr_zu AS SELECT mandant_id,
 verursacher_id,
 spr_id,
 verursacher_bez,
 system_id
FROM kfl_production_dbp_data.verursacher_spr_zu;