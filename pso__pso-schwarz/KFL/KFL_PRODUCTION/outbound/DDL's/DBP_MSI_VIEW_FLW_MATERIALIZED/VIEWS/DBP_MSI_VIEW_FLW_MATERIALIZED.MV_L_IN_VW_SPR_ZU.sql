CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_in_vw_spr_zu (mandant_id, in_vw_id, spr_id,
vw_bez) AS SELECT V01.mandant_id,
 V01.flw_vw_id AS in_vw_id,
 V01.spr_id,
 V01.vw_bez
FROM kfl_production_dbp_view.v_flw_vw_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;