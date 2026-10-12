CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_sonderabwicklung_spr_zu_1 AS SELECT sonderabwicklung_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN sonderabwicklung_bez
   ELSE NULL
   END) AS sonderabwicklung_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN sonderabwicklung_bez
   ELSE NULL
   END) AS sonderabwicklung_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN sonderabwicklung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sonderabwicklung_bez
    ELSE NULL
    END)) AS sonderabwicklung_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN sonderabwicklung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sonderabwicklung_bez
    ELSE NULL
    END)) AS sonderabwicklung_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN sonderabwicklung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sonderabwicklung_bez
    ELSE NULL
    END)) AS sonderabwicklung_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN sonderabwicklung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sonderabwicklung_bez
    ELSE NULL
    END)) AS sonderabwicklung_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN sonderabwicklung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sonderabwicklung_bez
    ELSE NULL
    END)) AS sonderabwicklung_bez_b
FROM kfl_production_dbp_view.v_sonderabwicklung_spr_zu_1 AS V01
GROUP BY sonderabwicklung_id
UNION DISTINCT
SELECT '-1' AS sonderabwicklung_id,
 '' AS sonderabwicklung_bez,
 '' AS sonderabwicklung_bez_de,
 '' AS sonderabwicklung_bez_sk,
 '' AS sonderabwicklung_bez_hr,
 '' AS sonderabwicklung_bez_pl,
 '' AS sonderabwicklung_bez_ro,
 '' AS sonderabwicklung_bez_b;