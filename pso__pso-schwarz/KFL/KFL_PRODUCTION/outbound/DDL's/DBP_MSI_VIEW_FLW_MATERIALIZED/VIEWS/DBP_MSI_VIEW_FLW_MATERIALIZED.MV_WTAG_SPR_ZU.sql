CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_wtag_spr_zu (wtag_id, wtag_bez) AS SELECT V01.wtag_id
 ,
 V01.wtag_bez
FROM kfl_production_dbp_view.v_wtag_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;