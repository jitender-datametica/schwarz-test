CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_empfehlung_2 (empfehlung_id, amx_system_id, empfehlung_nr,
feststellung_id, zustand_id, dat_soll, dat_abschluss, pruef_feld_id, td_insert, td_update) AS SELECT *
FROM kfl_production_dbp_data.amx_empfehlung_2;