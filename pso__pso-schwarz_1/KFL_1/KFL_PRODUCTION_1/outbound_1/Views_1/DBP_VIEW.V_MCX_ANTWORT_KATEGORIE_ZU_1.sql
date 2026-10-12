CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_antwort_kategorie_zu_1 AS SELECT antwort_id,
 umfrage_id,
 kat_id,
 gesamt_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_antwort_kategorie_zu_1;