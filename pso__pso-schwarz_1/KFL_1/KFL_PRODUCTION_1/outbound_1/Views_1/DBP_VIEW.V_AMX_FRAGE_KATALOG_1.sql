CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_frage_katalog_1 AS SELECT amx_frage_katalog_id,
 amx_system_id,
 hauptbereich_id,
 teilbereich_id,
 frage_nr,
 amx_frage_bez,
 amx_handlung_typ_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_frage_katalog_1;