CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artkz_loesch_1 AS SELECT mandant_id,
 loesch_id,
 MAX(CASE
   WHEN spr_id = 22 AND loesch_id <> ''
   THEN loesch_bez
   WHEN spr_id = 22 AND loesch_id = ''
   THEN 'leer/empty'
   ELSE NULL
   END) AS loesch_bez,
 MAX(CASE
   WHEN spr_id = 22 AND loesch_id <> ''
   THEN loesch_bez
   WHEN spr_id = 22 AND loesch_id = ''
   THEN 'leer/empty'
   ELSE NULL
   END) AS loesch_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 124 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 22 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 108 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 22 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 65 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 22 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 90 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 22 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 95 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 22 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 18 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND loesch_id <> ''
    THEN loesch_bez
    WHEN spr_id = 22 AND loesch_id = ''
    THEN 'leer/empty'
    ELSE NULL
    END)) AS loesch_bez_bg
FROM kfl_production_dbp_view.v_artkz_loesch_1 AS V01
GROUP BY mandant_id,
 loesch_id
UNION ALL
SELECT mandant_id,
 '' AS loesch_id,
 'leer/empty' AS loesch_bez,
 'leer/empty' AS loesch_bez_de,
 'leer/empty' AS loesch_bez_cz,
 'leer/empty' AS loesch_bez_sk,
 'leer/empty' AS loesch_bez_hr,
 'leer/empty' AS loesch_bez_pl,
 'leer/empty' AS loesch_bez_ro,
 'leer/empty' AS loesch_bez_bg
FROM kfl_production_dbp_view.v_mandant_1 AS V02
WHERE mandant_id <> 1
GROUP BY mandant_id;