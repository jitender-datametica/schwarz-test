CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_flaeche_status_1 AS SELECT mandant_id,
 flaeche_status_id,
 flaeche_status_bez,
 spr_id
FROM kfl_production_dbp_data.ivs_l_flaeche_status_1;