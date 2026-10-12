CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hwg_int_spr_zu_1 AS SELECT arthiertyp_id,
 hwg_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN hwg_bez
   ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
   END) AS hwg_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN hwg_bez
   ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
   END) AS hwg_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END)) AS hwg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END)) AS hwg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END)) AS hwg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END)) AS hwg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END)) AS hwg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END)) AS hwg_bez_bg,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END) AS hwg_id_bez,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN hwg_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN hwg_bez
     ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
     END)) AS hwg_id_bez_cz,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN hwg_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN hwg_bez
     ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
     END)) AS hwg_id_bez_sk,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN hwg_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN hwg_bez
     ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
     END)) AS hwg_id_bez_hr,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN hwg_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN hwg_bez
     ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
     END)) AS hwg_id_bez_pl,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN hwg_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN hwg_bez
     ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
     END)) AS hwg_id_bez_ro,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN hwg_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN hwg_bez
     ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
     END)) AS hwg_id_bez_bg,
   MAX(TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))) || ' ' || MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE TRIM(SUBSTR(CAST(hwg_id AS STRING), 1, 39))
    END) AS hwg_id_bez_de
FROM kfl_production_dbp_view.v_hwg_spr_zu_1 AS HWG
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 hwg_id;