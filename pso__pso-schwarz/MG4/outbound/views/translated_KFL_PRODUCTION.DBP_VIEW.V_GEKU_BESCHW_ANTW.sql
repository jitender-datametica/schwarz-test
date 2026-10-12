CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_beschw_antw (beschwerde_antwort_id, geku_massnahme_uid,
berechtigt_fg, avg_fg, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.geku_beschw_antw;