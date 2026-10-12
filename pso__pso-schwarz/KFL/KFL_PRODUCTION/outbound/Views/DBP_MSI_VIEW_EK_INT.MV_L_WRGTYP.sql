CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_l_wrgtyp AS SELECT DISTINCT land_id,
 wrg_id_land AS wrg_id,
 1 AS wrgtyp_id
FROM kfl_production_dbp_msi_view_ek_int.mv_land
UNION ALL
SELECT DISTINCT land_id,
 'EUR' AS wrg_id,
 2 AS wrgtyp_id
FROM kfl_production_dbp_msi_view_ek_int.mv_land;