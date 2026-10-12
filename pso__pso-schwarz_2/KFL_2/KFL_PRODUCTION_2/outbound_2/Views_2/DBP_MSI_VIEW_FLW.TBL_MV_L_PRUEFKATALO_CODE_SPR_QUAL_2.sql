CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_l_pruefkatalo_code_spr_qual_2 AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 pruefcode_id,
 version_id,
 spr_id,
 pruefkatalog_code_bez
FROM kfl_production_dbp_view.v_flw_pruefkatalog_code_spr_zu_2 AS V01
WHERE katalogart_id = '9';