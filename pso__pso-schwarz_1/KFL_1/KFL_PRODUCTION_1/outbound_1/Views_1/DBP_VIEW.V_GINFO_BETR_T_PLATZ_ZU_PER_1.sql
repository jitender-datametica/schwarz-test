CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ginfo_betr_t_platz_zu_per_1 AS SELECT ginfo_id,
 betreiberart_id,
 dat_von,
 techn_platz_id,
 dat_bis
FROM kfl_production_dbp_data.ginfo_betr_t_platz_zu_per_1;