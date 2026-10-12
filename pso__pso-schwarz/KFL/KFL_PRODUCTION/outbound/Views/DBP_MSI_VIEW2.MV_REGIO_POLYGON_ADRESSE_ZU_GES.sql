CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_adresse_zu_ges (mandant_id, wup_id, nb_id, land_id
, bundesland_id, gemeinde_id, umland_id, naturpark_id, naturraum_id, dummy_id, dummy2_id) AS SELECT A02.mandant_id,
 A02.wup_id,
 0 AS nb_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 30
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS land_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 20
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS bundesland_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 10
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS gemeinde_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 40
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS umland_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 50
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS naturpark_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 60
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS naturraum_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 70
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS dummy_id,
 COALESCE(MAX(CASE
    WHEN A01.regio_stufe_id = 80
    THEN A01.regio_polygon_id
    ELSE NULL
    END), - 1) AS dummy2_id
FROM kfl_production_dbp_view.v_regio_polygon_adresse_zu AS A01
 INNER JOIN kfl_production_dbp_view.v_wup AS A02 ON A01.mandant_id = A02.mandant_id AND A01.adresse_id = A02.adresse_id
WHERE A02.mandant_id = 1
GROUP BY A02.mandant_id,
 A02.wup_id;