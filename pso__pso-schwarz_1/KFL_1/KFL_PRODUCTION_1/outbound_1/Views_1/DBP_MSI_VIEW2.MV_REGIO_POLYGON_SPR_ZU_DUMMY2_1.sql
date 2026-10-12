CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_spr_zu_dummy2_1 (mandant_id, regio_stufe_id,
dummy2_id, spr_id, dummy2_bez) AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id AS dummy2_id,
 spr_id,
 regio_polygon_bez AS dummy2_bez
FROM kfl_production_dbp_view.v_regio_polygon_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22
 AND regio_stufe_id = 80
UNION DISTINCT
SELECT 1 AS mandant_id,
 80 AS regio_stufe_id,
 - 1 AS dummy2_id,
 22 AS spr_id,
 ' ' AS dummy2_bez;