CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_bew_ziel_spr_zu_2 AS SELECT mandant_id,
 flw_ziel_id,
 domaene_bez,
 spr_id,
 flw_ziel_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_bew_ziel_spr_zu_2;