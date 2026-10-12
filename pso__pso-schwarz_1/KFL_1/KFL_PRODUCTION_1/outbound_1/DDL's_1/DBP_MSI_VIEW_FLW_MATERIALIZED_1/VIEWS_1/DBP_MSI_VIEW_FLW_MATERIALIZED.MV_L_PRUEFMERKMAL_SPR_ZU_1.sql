CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_pruefmerkmal_spr_zu_1 (mandant_id, werk_id,
stp_merkmal_id, spr_id, merkmal_bez) AS SELECT V01.mandant_id,
 V01.werk_id,
 V01.stp_merkmal_id,
 V01.spr_id,
 V01.merkmal_bez
FROM kfl_production_dbp_view.v_flw_pruefmerkmal_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;