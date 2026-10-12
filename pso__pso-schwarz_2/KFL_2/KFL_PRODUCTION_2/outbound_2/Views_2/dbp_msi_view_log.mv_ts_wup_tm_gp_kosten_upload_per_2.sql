CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ts_wup_tm_gp_kosten_upload_per_2 AS SELECT mandant_id,
 tms_gp_id,
 tms_gp_typ_cd,
 wup_id,
 nb_id,
 kosten_upload_fg,
 dat_bis,
 dat_von
FROM kfl_production_dbp_msi_data.ts_wup_tm_gp_kosten_upload_per_2;