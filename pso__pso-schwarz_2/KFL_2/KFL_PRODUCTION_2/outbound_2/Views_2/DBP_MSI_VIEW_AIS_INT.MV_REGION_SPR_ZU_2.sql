CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_region_spr_zu_2 AS SELECT land_id,
 region_id,
 sap_region_id,
 COALESCE(MAX(CASE
    WHEN mandant_id = 1
    THEN region_name
    ELSE NULL
    END), 'N/A') AS region_name,
 COALESCE(MAX(CASE
    WHEN mandant_id = 1
    THEN region_name
    ELSE NULL
    END), 'N/A') AS region_name_de,
 COALESCE(MAX(CASE
    WHEN mandant_id = 2
    THEN region_name
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN mandant_id = 1
     THEN region_name
     ELSE NULL
     END), 'N/A')) AS region_name_cz,
 COALESCE(MAX(CASE
    WHEN mandant_id = 5
    THEN region_name
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN mandant_id = 1
     THEN region_name
     ELSE NULL
     END), 'N/A')) AS region_name_sk,
 COALESCE(MAX(CASE
    WHEN mandant_id = 6
    THEN region_name
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN mandant_id = 1
     THEN region_name
     ELSE NULL
     END), 'N/A')) AS region_name_hr,
 COALESCE(MAX(CASE
    WHEN mandant_id = 3
    THEN region_name
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN mandant_id = 1
     THEN region_name
     ELSE NULL
     END), 'N/A')) AS region_name_pl,
 COALESCE(MAX(CASE
    WHEN mandant_id = 7
    THEN region_name
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN mandant_id = 1
     THEN region_name
     ELSE NULL
     END), 'N/A')) AS region_name_ro,
 COALESCE(MAX(CASE
    WHEN mandant_id = 8
    THEN region_name
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN mandant_id = 1
     THEN region_name
     ELSE NULL
     END), 'N/A')) AS region_name_bg
FROM kfl_production_dbp_view.v_region_2 AS V01
GROUP BY land_id,
 region_id,
 sap_region_id;