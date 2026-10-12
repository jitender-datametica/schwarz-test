CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_spr_zu_naturraum (mandant_id, regio_stufe_id,
naturraum_id, spr_id, naturraum_bez) AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id AS naturraum_id,
 spr_id,
 regio_polygon_bez AS naturraum_bez
FROM kfl_production_dbp_view.v_regio_polygon_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22
 AND regio_stufe_id = 60
UNION DISTINCT
SELECT 1 AS mandant_id,
 60 AS regio_stufe_id,
 - 1 AS naturraum_id,
 22 AS spr_id,
 ' ' AS naturraum_bez;