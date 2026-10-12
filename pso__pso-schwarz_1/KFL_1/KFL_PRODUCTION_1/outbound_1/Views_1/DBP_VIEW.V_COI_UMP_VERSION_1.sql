CREATE OR REPLACE VIEW kfl_production_dbp_view.v_coi_ump_version_1 AS SELECT mandant_id,
 gj_plan,
 version_id,
 datzeit_upload,
 dat_planwerte_ist_ab
FROM kfl_production_dbp_data.coi_ump_version_1;