CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_beschw_antw_2 AS SELECT beschwerde_antwort_id,
 geku_massnahme_uid,
 berechtigt_fg,
 avg_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_beschw_antw_2;