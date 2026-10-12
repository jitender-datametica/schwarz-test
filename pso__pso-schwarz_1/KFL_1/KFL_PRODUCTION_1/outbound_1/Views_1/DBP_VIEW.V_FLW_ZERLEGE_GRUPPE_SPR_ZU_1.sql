CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_zerlege_gruppe_spr_zu_1 AS SELECT mandant_id,
 zerlege_gruppe_id,
 spr_id,
 zerlege_gruppe_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_zerlege_gruppe_spr_zu_1;