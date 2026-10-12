CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_frage_antwort_zu_2 (frage_id, antwort_id, nok_fg, td_update,
td_insert) AS SELECT frage_id,
 antwort_id,
 nok_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mdl_frage_antwort_zu_2;