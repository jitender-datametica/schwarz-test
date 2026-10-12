CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_ges_vertriebsltg_1 (country_uid, land_iso, land_bez,
verteiltag_id) AS SELECT country_uid,
 land_iso,
 land_bez,
 verteiltag_id
FROM kfl_production_dbp_view.v_geku_ges_vertriebsltg_1;