CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_spr_zu_bundesland (mandant_id, regio_stufe_id,
bundesland_id, spr_id, bundesland_bez) AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id AS bundesland_id,
 spr_id,
 regio_polygon_bez AS bundesland_bez
FROM kfl_production_dbp_view.v_regio_polygon_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22
 AND regio_stufe_id = 20
UNION DISTINCT
SELECT 1 AS mandant_id,
 20 AS regio_stufe_id,
 - 1 AS bundesland_id,
 22 AS spr_id,
 ' ' AS bundesland_bez;