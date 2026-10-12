CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_spr_zu_umland (mandant_id, regio_stufe_id,
umland_id, spr_id, umland_bez) AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id AS umland_id,
 spr_id,
 regio_polygon_bez AS umland_bez
FROM kfl_production_dbp_view.v_regio_polygon_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22
 AND regio_stufe_id = 40
UNION DISTINCT
SELECT 1 AS mandant_id,
 40 AS regio_stufe_id,
 - 1 AS umland_id,
 22 AS spr_id,
 ' ' AS umland_bez;