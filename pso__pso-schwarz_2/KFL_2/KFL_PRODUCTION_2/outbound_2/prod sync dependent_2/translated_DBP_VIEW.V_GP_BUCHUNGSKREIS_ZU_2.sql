CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_buchungskreis_zu_2 (system_id, gp_id, einkaufsorganisation_id,
buchungskreis_id, mandant_id, zahlsperre_id, td_update, td_insert) AS SELECT system_id,
 gp_id,
 einkaufsorganisation_id,
 buchungskreis_id,
 mandant_id,
 zahlsperre_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.gp_buchungskreis_zu_2;