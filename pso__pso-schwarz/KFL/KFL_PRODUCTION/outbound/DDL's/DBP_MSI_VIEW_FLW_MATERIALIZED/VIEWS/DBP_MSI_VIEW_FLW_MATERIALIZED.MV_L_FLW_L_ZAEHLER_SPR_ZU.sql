CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_l_zaehler_spr_zu (mandant_id, zaehler_id,
spr_id, zaehler_bez) AS SELECT V01.mandant_id,
 V01.zaehler_id,
 V01.spr_id,
 V01.zaehler_bez
FROM kfl_production_dbp_view.v_flw_zaehler_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;