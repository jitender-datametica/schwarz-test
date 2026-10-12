CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_codegruppe_los_1 (mandant_id, katalogart_id,
codegruppe_id) AS SELECT mandant_id,
 katalogart_id,
 codegruppe_id
FROM kfl_production_dbp_view.v_flw_l_codegruppe_1 AS V01
WHERE katalogart_id = '1';