CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_transportation_unit_entfernung (mandant_id, mandant_id_markt,
transportation_unit_id, kj_transportation_unit, tour_stop, wup_id_vz, nb_id_vz, dat_tour, lagernummer_id, tdl_id,
sonderabwicklung_id, belos_tourart_id, belos_tourstatus_id, fleischwerk_fg, distribution_abr_fg, rundlauf_transport_fg,
wup_id_a, nb_id_a, wup_id_b, nb_id_b, erster_scan_an_tour_stop, fg_letzter_stop, weg_inkl_rueckweg_rl_km,
weg_inkl_rueckweg_rl_km_maut, weg_inkl_rueckweg_rl_min, weg_a_nach_b_km, weg_a_nach_b_min, rueckweg_rundlauf_km,
rueckweg_rundlauf_min, entfernung_markt_vz, entfernung_time_markt_vz, km_data_complete_fg) AS SELECT *
FROM kfl_production_dbp_msi_view_log.mv_dt_transportation_unit_entfernung;