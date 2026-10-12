CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_trennprozess_spr_zu (trennprozess_id,
trennprozess_bez) AS SELECT V01.trennprozess_id,
 V01.trennprozess_bez
FROM kfl_production_dbp_view.v_flw_trennprozess_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
GROUP BY V01.trennprozess_id,
 V01.trennprozess_bez;