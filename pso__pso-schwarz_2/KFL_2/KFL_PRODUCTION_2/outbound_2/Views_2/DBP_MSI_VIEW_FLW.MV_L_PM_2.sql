CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_pm_2 (pm_id, pm_bez, mandant_id, spr_id) AS SELECT V01.pm_id,
 V01.pm_bez,
 V01.mandant_id,
 V01.spr_id
FROM kfl_production_dbp_view.v_pm_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2);