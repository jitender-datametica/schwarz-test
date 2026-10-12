CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_codegruppe_spr_qual_1 (mandant_id,
katalogart_id, codegruppe_id, spr_id, codegruppe_bez) AS SELECT V01.mandant_id,
 V01.katalogart_id,
 V01.codegruppe_id,
 V01.spr_id,
 V01.codegruppe_bez
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_l_flw_codegruppe_spr_qual_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;