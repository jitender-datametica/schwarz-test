CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_spr_zu_gemeinde_1 (mandant_id, regio_stufe_id,
gemeinde_id, spr_id, gemeinde_bez) AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id AS gemeinde_id,
 spr_id,
 regio_polygon_bez AS gemeinde_bez
FROM kfl_production_dbp_view.v_regio_polygon_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22
 AND regio_stufe_id = 10
UNION DISTINCT
SELECT 1 AS mandant_id,
 10 AS regio_stufe_id,
 - 1 AS gemeinde_id,
 22 AS spr_id,
 ' ' AS gemeinde_bez;