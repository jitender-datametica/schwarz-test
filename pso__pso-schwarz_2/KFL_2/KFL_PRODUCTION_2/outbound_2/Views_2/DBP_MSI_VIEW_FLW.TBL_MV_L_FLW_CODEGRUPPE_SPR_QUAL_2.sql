CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_l_flw_codegruppe_spr_qual_2 AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 spr_id,
 codegruppe_bez
FROM kfl_production_dbp_view.v_flw_codegruppe_spr_zu_2 AS V01
WHERE katalogart_id = '9';