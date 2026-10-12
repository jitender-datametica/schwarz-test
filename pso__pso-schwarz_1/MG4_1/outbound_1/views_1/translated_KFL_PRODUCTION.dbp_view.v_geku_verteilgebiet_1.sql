CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_verteilgebiet_1 (verteilgebiet_uid, gebietsleiter_uid,
verteilgebiet_bez, mandant_id, nils_verteilgebiet_id, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.geku_verteilgebiet_1;