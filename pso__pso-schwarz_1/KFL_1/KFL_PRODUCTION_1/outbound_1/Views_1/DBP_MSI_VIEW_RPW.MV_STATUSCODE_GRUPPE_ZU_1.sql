CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_statuscode_gruppe_zu_1 (system_id, mandant_id, statuscode_id,
statusgruppe_id) AS SELECT 7 AS system_id,
 mandant_id,
 statuscode_id,
 statusgruppe_id
FROM kfl_production_dbp_view.v_statuscode_gruppe_zu_1
WHERE mandant_id = 1;