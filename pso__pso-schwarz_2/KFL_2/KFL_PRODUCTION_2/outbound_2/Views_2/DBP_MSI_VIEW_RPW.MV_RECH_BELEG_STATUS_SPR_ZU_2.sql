CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_rech_beleg_status_spr_zu_2 (system_id, mandant_id,
rech_beleg_status_id, spr_id, rech_beleg_status_bez) AS SELECT 7 AS system_id,
 mandant_id,
 rech_beleg_status_id,
 spr_id,
 rech_beleg_status_bez
FROM kfl_production_dbp_view.v_rech_beleg_status_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1;