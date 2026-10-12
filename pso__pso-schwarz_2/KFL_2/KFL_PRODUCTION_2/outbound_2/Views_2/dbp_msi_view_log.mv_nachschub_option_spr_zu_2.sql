CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_nachschub_option_spr_zu_2 AS SELECT CAST(SUBSTR(CAST(nachschub_option_id AS STRING), 1, 2) AS INTEGER)
 AS nachschub_option_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN nachschub_option_bez
   ELSE NULL
   END) AS nachschub_option_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN nachschub_option_bez
   ELSE NULL
   END) AS nachschub_option_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN nachschub_option_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN nachschub_option_bez
    ELSE NULL
    END)) AS nachschub_option_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN nachschub_option_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN nachschub_option_bez
    ELSE NULL
    END)) AS nachschub_option_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN nachschub_option_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN nachschub_option_bez
    ELSE NULL
    END)) AS nachschub_option_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN nachschub_option_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN nachschub_option_bez
    ELSE NULL
    END)) AS nachschub_option_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN nachschub_option_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN nachschub_option_bez
    ELSE NULL
    END)) AS nachschub_option_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN nachschub_option_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN nachschub_option_bez
    ELSE NULL
    END)) AS nachschub_option_bez_bg
FROM kfl_production_dbp_view.v_nachschub_option_spr_zu_2 AS V01
GROUP BY V01.nachschub_option_id
UNION DISTINCT
SELECT 0 AS nachschub_option_id,
 '' AS nachschub_option_bez,
 '' AS nachschub_option_bez_de,
 '' AS nachschub_option_bez_cz,
 '' AS nachschub_option_bez_sk,
 '' AS nachschub_option_bez_hr,
 '' AS nachschub_option_bez_pl,
 '' AS nachschub_option_bez_ro,
 '' AS nachschub_option_bez_bg
FROM kfl_production_dbp_view.v_nachschub_option_spr_zu_2;