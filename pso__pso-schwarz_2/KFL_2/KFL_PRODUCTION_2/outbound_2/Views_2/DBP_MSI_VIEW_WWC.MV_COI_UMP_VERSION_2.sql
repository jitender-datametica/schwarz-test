CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_coi_ump_version_2 (mandant_id, gj_plan, version_id,
datzeit_upload, dat_planwerte_ist_ab) AS SELECT mandant_id,
 gj_plan,
 version_id,
 datzeit_upload,
 dat_planwerte_ist_ab
FROM kfl_production_dbp_view.v_coi_ump_version_2;