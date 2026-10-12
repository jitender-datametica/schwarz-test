CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_pm (pm_id, pm_bez, mandant_id, spr_id) AS
SELECT V01.pm_id,
 V01.pm_bez,
 V01.mandant_id,
 V01.spr_id
FROM kfl_production_dbp_view.v_pm AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2);