CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_sm (sm_id, sm_bez, mandant_id) AS SELECT V01.sm_id
 ,
 V01.sm_bez,
 V01.mandant_id
FROM kfl_production_dbp_view.v_sm AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2)
 AND V01.sm_id <> -9;