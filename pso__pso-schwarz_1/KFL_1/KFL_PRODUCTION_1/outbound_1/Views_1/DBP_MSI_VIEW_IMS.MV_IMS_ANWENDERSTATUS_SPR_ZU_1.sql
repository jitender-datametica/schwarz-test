CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_ims_anwenderstatus_spr_zu_1 AS SELECT anwenderstatus_id,
 mandant_id,
 anwenderstatus_bez_kurz,
 anwenderstatus_bez
FROM kfl_production_dbp_view.v_ims_anwenderstatus_spr_zu_1
WHERE spr_id = 22;