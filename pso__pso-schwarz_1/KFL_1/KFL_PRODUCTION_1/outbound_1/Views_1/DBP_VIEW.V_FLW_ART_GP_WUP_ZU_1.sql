CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_gp_wup_zu_1 AS SELECT mandant_id,
 einkaufs_infosatz_id,
 flw_art_id,
 flw_lief_id,
 einkaufsorganisation_id,
 einkaufs_infosatz_typ_id,
 werk_id,
 loesch_fg,
 dat_erfasst
FROM kfl_production_dbp_data.flw_art_gp_wup_zu_1;