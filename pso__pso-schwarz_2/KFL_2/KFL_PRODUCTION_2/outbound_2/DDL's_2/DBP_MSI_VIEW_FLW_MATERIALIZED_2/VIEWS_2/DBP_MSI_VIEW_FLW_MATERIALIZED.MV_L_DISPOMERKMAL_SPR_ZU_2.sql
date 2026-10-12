CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_dispomerkmal_spr_zu_2 (mandant_id, dispomerkmal,
spr_id, dispomerkmal_bez) AS SELECT V01.mandant_id,
 V01.dispomerkmal,
 V01.spr_id,
 V01.dispomerkmal_bez
FROM kfl_production_dbp_view.v_dispomerkmal_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id;