CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_problemmeldung_obj (system_id, mandant_id, zus_obj_id) AS
SELECT 7 AS system_id,
 mandant_id,
 zus_obj_id
FROM kfl_production_dbp_view.v_l_problemmeldung_obj
WHERE mandant_id = 1;