CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_storno AS SELECT bon_id,
 bon_dat,
 mandant_id,
 wup_id,
 bon_nr,
 kasse_nr,
 datei_name,
 1 AS is_in_storno
FROM kfl_production_dbp_v_ods.v_ods_bon_storno;