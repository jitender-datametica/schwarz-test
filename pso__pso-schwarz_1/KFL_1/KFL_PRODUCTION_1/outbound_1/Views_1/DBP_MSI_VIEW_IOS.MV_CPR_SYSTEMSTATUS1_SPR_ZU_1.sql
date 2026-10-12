CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_systemstatus1_spr_zu_1 (cpr_systemstatus1_id,
cpr_systemstatus1_bez, cpr_systemstatus1_bez_cz, cpr_systemstatus1_bez_sk, cpr_systemstatus1_bez_hr,
cpr_systemstatus1_bez_pl, cpr_systemstatus1_bez_ro, cpr_systemstatus1_bez_en, cpr_systemstatus1_bez_bg) AS SELECT
 cpr_systemstatus1_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN cpr_systemstatus1_bez
   ELSE NULL
   END) AS cpr_systemstatus1_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END)) AS cpr_systemstatus1_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END)) AS cpr_systemstatus1_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END)) AS cpr_systemstatus1_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END)) AS cpr_systemstatus1_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END)) AS cpr_systemstatus1_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END)) AS cpr_systemstatus1_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_systemstatus1_bez
    ELSE NULL
    END)) AS cpr_systemstatus1_bez_bg
FROM kfl_production_dbp_view.v_cpr_systemstatus1_spr_zu_1 AS V01
WHERE cpr_systemstatus1_id IN (1, 2, 3, 4)
GROUP BY cpr_systemstatus1_id;