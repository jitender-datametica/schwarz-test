CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_frage_katalog (amx_frage_katalog_id, amx_system_id,
kmr_quelle_id, hauptbereich_id, teilbereich_id, frage_nr, int_frage_id, amx_frage_bez, amx_handlung_typ_id) AS SELECT
 amx_frage_katalog_id,
 amx_system_id,
 1 AS kmr_quelle_id,
 hauptbereich_id,
 teilbereich_id,
 frage_nr,
 SUBSTR(frage_nr, 6, 25) AS int_frage_id,
 amx_frage_bez,
 amx_handlung_typ_id
FROM kfl_production_dbp_view.v_amx_frage_katalog;