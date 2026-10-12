CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_frage_kat_pruef_progr_zu AS SELECT frage_kat_pruef_progr_zu_id,
 amx_system_id,
 pruef_programm_id,
 amx_frage_katalog_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_frage_kat_pruef_progr_zu;