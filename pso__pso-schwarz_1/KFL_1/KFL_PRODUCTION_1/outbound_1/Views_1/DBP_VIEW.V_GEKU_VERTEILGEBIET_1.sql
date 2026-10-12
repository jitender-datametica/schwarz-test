CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_verteilgebiet_1 AS SELECT verteilgebiet_uid,
 gebietsleiter_uid,
 verteilgebiet_bez,
 mandant_id,
 nils_verteilgebiet_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_verteilgebiet_1;