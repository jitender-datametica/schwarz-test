CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_pruefkatalo_code_qual_1 (mandant_id, katalogart_id,
codegruppe_id, werk_id, pruefcode_id, auswahlmenge) AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id,
 werk_id,
 pruefcode_id,
 auswahlmenge
FROM kfl_production_dbp_view.v_flw_l_pruefkatalog_code_1 AS V01
WHERE katalogart_id = '9';