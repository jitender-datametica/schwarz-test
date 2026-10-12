CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_gp_kondit_wup_zu_per_1 AS SELECT mandant_id,
 kondition_applikation_id,
 konditionsart_id,
 flw_lief_id,
 flw_art_id,
 einkaufsorganisation_id,
 werk_id,
 einkaufs_infosatz_typ_id,
 kondition_id,
 dat_bis,
 dat_von
FROM kfl_production_dbp_data.flw_art_gp_kondit_wup_zu_per_1;