CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ewm_exception_spr_zu_2 AS SELECT mandant_id,
 lagernummer_id,
 ewm_exception_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ewm_exception_bez
   ELSE NULL
   END) AS ewm_exception_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN ewm_exception_bez
   ELSE NULL
   END) AS ewm_exception_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ewm_exception_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ewm_exception_bez
    ELSE NULL
    END)) AS ewm_exception_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ewm_exception_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ewm_exception_bez
    ELSE NULL
    END)) AS ewm_exception_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ewm_exception_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ewm_exception_bez
    ELSE NULL
    END)) AS ewm_exception_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ewm_exception_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ewm_exception_bez
    ELSE NULL
    END)) AS ewm_exception_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ewm_exception_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ewm_exception_bez
    ELSE NULL
    END)) AS ewm_exception_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ewm_exception_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ewm_exception_bez
    ELSE NULL
    END)) AS ewm_exception_bez_bg
FROM kfl_production_dbp_view.v_ewm_exception_spr_zu_2 AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4
GROUP BY mandant_id,
 lagernummer_id,
 ewm_exception_id
UNION DISTINCT
SELECT mandant_id,
 lagernummer_id,
 '' AS ewm_exception_id,
 '' AS ewm_exception_bez,
 '' AS ewm_exception_bez_de,
 '' AS ewm_exception_bez_cz,
 '' AS ewm_exception_bez_sk,
 '' AS ewm_exception_bez_hr,
 '' AS ewm_exception_bez_pl,
 '' AS ewm_exception_bez_ro,
 '' AS ewm_exception_bez_bg
FROM kfl_production_dbp_view.v_ewm_exception_spr_zu_2 AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4
GROUP BY mandant_id,
 lagernummer_id,
 V01.ewm_exception_id;