CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_statusgruppe_1 (mandant_id, statusgruppe_id, system_id) AS
SELECT mandant_id,
 statusgruppe_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_statusgruppe_1
WHERE mandant_id = 1;