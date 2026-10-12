CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_spr_zu_land_2 (mandant_id, regio_stufe_id, land_id,
spr_id, land_bez) AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id AS land_id,
 spr_id,
 regio_polygon_bez AS land_bez
FROM kfl_production_dbp_view.v_regio_polygon_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22
 AND regio_stufe_id = 30
UNION DISTINCT
SELECT 1 AS mandant_id,
 30 AS regio_stufe_id,
 - 1 AS land_id,
 22 AS spr_id,
 ' ' AS land_bez;