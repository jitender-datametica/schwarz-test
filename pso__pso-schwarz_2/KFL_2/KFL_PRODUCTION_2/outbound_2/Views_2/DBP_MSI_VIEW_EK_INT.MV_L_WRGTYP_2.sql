CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_l_wrgtyp_2 AS SELECT DISTINCT land_id,
 wrg_id_land AS wrg_id,
 1 AS wrgtyp_id
FROM kfl_production_dbp_msi_view_ek_int.mv_land_2
UNION ALL
SELECT DISTINCT land_id,
 'EUR' AS wrg_id,
 2 AS wrgtyp_id
FROM kfl_production_dbp_msi_view_ek_int.mv_land_2;