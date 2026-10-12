CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_entladestelle_2 AS SELECT mandant_id,
 entladestelle_id,
 gatename,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_entladestelle_2;