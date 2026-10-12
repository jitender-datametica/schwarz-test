CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_gp_teilsortiment_spr_zu AS SELECT mandant_id,
 gp_id,
 gp_teilsortiment_id,
 einkaufsorganisation_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN gp_teilsortiment_bez
   ELSE NULL
   END) AS gp_teilsortiment_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN gp_teilsortiment_bez
   ELSE NULL
   END) AS gp_teilsortiment_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN gp_teilsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN gp_teilsortiment_bez
    ELSE NULL
    END)) AS gp_teilsortiment_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN gp_teilsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN gp_teilsortiment_bez
    ELSE NULL
    END)) AS gp_teilsortiment_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN gp_teilsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN gp_teilsortiment_bez
    ELSE NULL
    END)) AS gp_teilsortiment_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN gp_teilsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN gp_teilsortiment_bez
    ELSE NULL
    END)) AS gp_teilsortiment_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN gp_teilsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN gp_teilsortiment_bez
    ELSE NULL
    END)) AS gp_teilsortiment_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN gp_teilsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN gp_teilsortiment_bez
    ELSE NULL
    END)) AS gp_teilsortiment_bez_bg
FROM kfl_production_dbp_view.v_gp_teilsortiment_spr_zu AS V01
WHERE gp_teilsortiment_id <> ''
GROUP BY mandant_id,
 gp_id,
 gp_teilsortiment_id,
 einkaufsorganisation_id
UNION ALL
SELECT mandant_id,
 gp_id,
 '' AS gp_teilsortiment_id,
 einkaufsorganisation_id,
 'leer/empty' AS gp_teilsortiment_bez,
 'leer/empty' AS gp_teilsortiment_bez_de,
 'leer/empty' AS gp_teilsortiment_bez_cz,
 'leer/empty' AS gp_teilsortiment_bez_sk,
 'leer/empty' AS gp_teilsortiment_bez_hr,
 'leer/empty' AS gp_teilsortiment_bez_pl,
 'leer/empty' AS gp_teilsortiment_bez_ro,
 'leer/empty' AS gp_teilsortiment_bez_bg
FROM kfl_production_dbp_view.v_gp AS V02;