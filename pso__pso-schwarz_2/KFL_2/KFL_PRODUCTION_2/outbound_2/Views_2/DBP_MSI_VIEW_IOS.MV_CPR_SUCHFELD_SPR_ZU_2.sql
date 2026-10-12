CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_suchfeld_spr_zu_2 AS SELECT cpr_suchfeld_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN suchfeld_bez
   ELSE NULL
   END) AS suchfeld_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN suchfeld_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN suchfeld_bez
    ELSE NULL
    END)) AS suchfeld_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN suchfeld_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN suchfeld_bez
    ELSE NULL
    END)) AS suchfeld_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN suchfeld_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN suchfeld_bez
    ELSE NULL
    END)) AS suchfeld_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN suchfeld_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN suchfeld_bez
    ELSE NULL
    END)) AS suchfeld_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN suchfeld_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN suchfeld_bez
    ELSE NULL
    END)) AS suchfeld_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN suchfeld_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN suchfeld_bez
    ELSE NULL
    END)) AS suchfeld_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN suchfeld_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN suchfeld_bez
    ELSE NULL
    END)) AS suchfeld_bez_bg
FROM kfl_production_dbp_view.v_cpr_suchfeld_spr_zu_2 AS V01
GROUP BY cpr_suchfeld_id;