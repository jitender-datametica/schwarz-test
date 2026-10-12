CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_massnahme AS SELECT massnahme_id,
 massnahmenart_id,
 massnahme_akt_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_massnahme;