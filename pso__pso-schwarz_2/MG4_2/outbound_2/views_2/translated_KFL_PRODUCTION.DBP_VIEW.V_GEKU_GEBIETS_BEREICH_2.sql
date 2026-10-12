CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_gebiets_bereich_2 (gebiets_bereich_uid, verteilgebiet_uid,
gebiets_betreuer_uid, gebiets_bereich_bez, td_update, td_insert) AS SELECT gebiets_bereich_uid,
 verteilgebiet_uid,
 gebiets_betreuer_uid,
 gebiets_bereich_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_gebiets_bereich_2;