CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_auslastungsgrund_2 AS SELECT mandant_id,
 auslastungsgrund_id,
 sap_auslastungsgrund,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_auslastungsgrund_2;