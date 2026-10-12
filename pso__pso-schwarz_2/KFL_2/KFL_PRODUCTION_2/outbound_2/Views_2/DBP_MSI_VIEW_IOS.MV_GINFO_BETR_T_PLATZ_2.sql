CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ginfo_betr_t_platz_2 AS SELECT GB.betreiberart_id,
 L.betreiberart_bez,
 GB.techn_platz_id,
 GB.dat_von,
 GB.dat_bis
FROM kfl_production_dbp_view.v_ginfo_betr_t_platz_zu_per_2 AS GB
 INNER JOIN kfl_production_dbp_view.v_l_ginfo_betreiberart_2 AS L ON GB.betreiberart_id = L.betreiberart_id
WHERE GB.dat_bis = DATE '9999-12-31';