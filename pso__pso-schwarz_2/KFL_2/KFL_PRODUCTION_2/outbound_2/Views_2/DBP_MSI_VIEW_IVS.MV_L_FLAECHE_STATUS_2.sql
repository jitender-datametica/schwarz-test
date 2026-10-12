CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_flaeche_status_2 AS SELECT flaeche_status_id,
 flaeche_status_bez,
 spr_id,
 mandant_id
FROM kfl_production_dbp_view.v_ivs_l_flaeche_status_2
WHERE spr_id = 22;