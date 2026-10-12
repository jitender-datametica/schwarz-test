CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_belegklasse (system_id, mandant_id, belegklasse_id, td_update,
td_insert) AS SELECT system_id,
 mandant_id,
 belegklasse_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_belegklasse;