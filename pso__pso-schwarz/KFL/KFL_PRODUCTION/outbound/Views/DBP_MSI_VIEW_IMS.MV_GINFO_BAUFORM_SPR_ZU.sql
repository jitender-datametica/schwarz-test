CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_ginfo_bauform_spr_zu AS SELECT ginfo_bauform_id,
 ginfo_bauform_bez
FROM kfl_production_dbp_view.v_ginfo_bauform_spr_zu
WHERE spr_id = 22;