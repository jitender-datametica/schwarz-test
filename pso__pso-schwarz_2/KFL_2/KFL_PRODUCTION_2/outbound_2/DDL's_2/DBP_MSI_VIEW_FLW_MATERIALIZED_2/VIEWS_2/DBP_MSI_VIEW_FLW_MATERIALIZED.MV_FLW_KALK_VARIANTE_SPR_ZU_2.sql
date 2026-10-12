CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_flw_kalk_variante_spr_zu_2 (mandant_id,
kalk_variante_id, spr_id, kalk_variante_bez, mandant_kbez) AS SELECT V01.mandant_id,
 V01.kalk_variante_id,
 V01.spr_id,
 V01.kalk_variante_bez,
 V01.mandant_kbez
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_flw_kalk_variante_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id;