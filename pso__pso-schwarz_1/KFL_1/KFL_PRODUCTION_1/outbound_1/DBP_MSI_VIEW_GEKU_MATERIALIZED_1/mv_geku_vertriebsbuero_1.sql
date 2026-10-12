CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_geku_vertriebsbuero_1 (vertriebsbuero_uid,
country_uid, vertriebsbuero_bez) AS SELECT vertriebsbuero_uid,
 country_uid,
 vertriebsbuero_bez
FROM dbp_view.v_geku_vertriebsbuero_1;