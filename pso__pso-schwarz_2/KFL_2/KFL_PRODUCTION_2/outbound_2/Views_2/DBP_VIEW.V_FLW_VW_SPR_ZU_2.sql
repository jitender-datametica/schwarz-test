CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_vw_spr_zu_2 AS SELECT mandant_id,
 flw_vw_id,
 spr_id,
 system_id,
 vw_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_vw_spr_zu_2;