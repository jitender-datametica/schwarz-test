CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_art_gp_zu_ges_1 (mandant_id, art_id, gp_id, land_id,
bundesland_id, gemeinde_id, umland_id, naturpark_id, naturraum_id, dummy_id, dummy2_id) AS SELECT mandant_id,
 art_id,
 gp_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 30
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS land_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 20
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS bundesland_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 10
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS gemeinde_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 40
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS umland_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 50
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS naturpark_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 60
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS naturraum_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 70
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS dummy_id,
 COALESCE(MAX(CASE
    WHEN regio_stufe_id = 80
    THEN regio_polygon_id
    ELSE NULL
    END), - 1) AS dummy2_id
FROM kfl_production_dbp_view.v_regio_polygon_art_gp_zu_1
WHERE mandant_id = 1
GROUP BY mandant_id,
 art_id,
 gp_id;