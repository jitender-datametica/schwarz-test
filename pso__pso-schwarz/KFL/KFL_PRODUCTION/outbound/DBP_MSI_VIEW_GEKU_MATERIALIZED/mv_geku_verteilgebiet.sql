CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_geku_verteilgebiet (verteilgebiet_uid,
gebietsleiter_uid, verteilgebiet_bez) AS SELECT verteilgebiet_uid,
 gebietsleiter_uid,
 verteilgebiet_bez
FROM dbp_view.v_geku_verteilgebiet;