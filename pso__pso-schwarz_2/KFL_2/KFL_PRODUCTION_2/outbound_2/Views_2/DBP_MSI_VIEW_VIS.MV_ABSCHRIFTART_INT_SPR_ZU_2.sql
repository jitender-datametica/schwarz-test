CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abschriftart_int_spr_zu_2 AS SELECT abschriftart_int_id,
 TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) AS abschriftart,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftart_int_bez
   ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
   END) AS abschriftart_int_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftart_int_bez
   ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
   END) AS abschriftart_int_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abschriftart_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_int_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
    END)) AS abschriftart_int_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abschriftart_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_int_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
    END)) AS abschriftart_int_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abschriftart_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_int_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
    END)) AS abschriftart_int_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abschriftart_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_int_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
    END)) AS abschriftart_int_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abschriftart_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_int_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
    END)) AS abschriftart_int_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abschriftart_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_int_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
    END)) AS abschriftart_int_bez_bg,
   TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) || ' ' || MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_int_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
    END) AS abschriftart_int,
   TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN abschriftart_int_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_int_bez
     ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
     END)) AS abschriftart_int_cz,
   TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN abschriftart_int_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_int_bez
     ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
     END)) AS abschriftart_int_sk,
   TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN abschriftart_int_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_int_bez
     ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
     END)) AS abschriftart_int_hr,
   TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN abschriftart_int_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_int_bez
     ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
     END)) AS abschriftart_int_pl,
   TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN abschriftart_int_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_int_bez
     ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
     END)) AS abschriftart_int_ro,
   TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39)) || ' ' || COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN abschriftart_int_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_int_bez
     ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_int_id AS STRING), 1, 39))
     END)) AS abschriftart_int_bg
FROM kfl_production_dbp_view.v_abschriftart_int_spr_zu_2 AS V01
GROUP BY abschriftart_int_id;