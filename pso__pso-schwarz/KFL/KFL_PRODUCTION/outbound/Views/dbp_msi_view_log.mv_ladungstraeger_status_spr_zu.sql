CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ladungstraeger_status_spr_zu AS SELECT
 ladungstraeger_status_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ladungstraeger_status_bez
   ELSE NULL
   END) AS ladungstraeger_status_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN ladungstraeger_status_bez
   ELSE NULL
   END) AS ladungstraeger_status_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ladungstraeger_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ladungstraeger_status_bez
    ELSE NULL
    END)) AS ladungstraeger_status_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ladungstraeger_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ladungstraeger_status_bez
    ELSE NULL
    END)) AS ladungstraeger_status_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ladungstraeger_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ladungstraeger_status_bez
    ELSE NULL
    END)) AS ladungstraeger_status_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ladungstraeger_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ladungstraeger_status_bez
    ELSE NULL
    END)) AS ladungstraeger_status_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ladungstraeger_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ladungstraeger_status_bez
    ELSE NULL
    END)) AS ladungstraeger_status_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ladungstraeger_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ladungstraeger_status_bez
    ELSE NULL
    END)) AS ladungstraeger_status_bez_bg
FROM kfl_production_dbp_view.v_ladungstraeger_status_spr_zu AS V01
GROUP BY ladungstraeger_status_id;