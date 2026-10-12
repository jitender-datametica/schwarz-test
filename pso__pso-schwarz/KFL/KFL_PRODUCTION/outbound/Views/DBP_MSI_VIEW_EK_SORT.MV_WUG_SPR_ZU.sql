CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_wug_spr_zu AS SELECT V01.mandant_id,
 V01.wug_id,
 V01.wg_id,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.wug_bez
    ELSE NULL
    END), 'N/A') AS wug_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.wug_bez
    ELSE NULL
    END), 'N/A') AS wug_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_bg,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_ro
FROM kfl_production_dbp_view.v_wug_spr_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_filter_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_id = V02.wg_id
WHERE V02.wg_filter_id = 11
GROUP BY V01.mandant_id,
 V01.wug_id,
 V01.wg_id
UNION DISTINCT
SELECT mandant_id,
 - 1 AS wug_id,
 - 1 AS wg_id,
 'N/A' AS wug_bez,
 'N/A' AS wug_bez_de,
 'N/A' AS wug_bez_bg,
 'N/A' AS wug_bez_cz,
 'N/A' AS wug_bez_sk,
 'N/A' AS wug_bez_hr,
 'N/A' AS wug_bez_pl,
 'N/A' AS wug_bez_ro
FROM kfl_production_dbp_view.v_mandant;