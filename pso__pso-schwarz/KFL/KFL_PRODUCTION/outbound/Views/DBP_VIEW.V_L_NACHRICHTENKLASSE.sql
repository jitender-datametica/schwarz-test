CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_nachrichtenklasse AS SELECT mandant_id,
 nachrichtenklasse_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_nachrichtenklasse;