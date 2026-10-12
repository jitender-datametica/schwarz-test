CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tms_tour_entfernung (mandant_id, mandant_id_markt, system_id,
transportation_unit_id, kj_transportation_unit, tour_stop, wup_id_vz, dat_tour, lagernummer_id, tourart_id, richtung_id
, tour_service, tms_fahrzeugtyp_id, tms_tourstatus_id, tms_tour_reihenfolge_nr, spedition_tms_gp_id,
spedition_tms_gp_typ_cd, tms, wup_id_a, nb_id_a, wup_id_b, lieferkunde_tms_gp_typ_cd, tms_standorttyp_id, nb_id_b,
fg_letzter_stop, weg_inkl_rueckweg_rl_km, weg_inkl_rueckweg_rl_km_maut, weg_inkl_rueckweg_rl_min, weg_a_nach_b_km,
weg_a_nach_b_min, rueckweg_rundlauf_km, rueckweg_rundlauf_min, entfernung_markt_vz, entfernung_time_markt_vz,
km_data_complete_fg, ewm_fg) AS SELECT *
FROM kfl_production_dbp_msi_view_log.mv_dt_tms_tour_entfernung AS V01;