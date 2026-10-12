CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_entladestelle (mandant_id, entladestelle_id, gatename) AS
SELECT mandant_id,
 entladestelle_id,
 gatename
FROM kfl_production_dbp_view.v_l_entladestelle;