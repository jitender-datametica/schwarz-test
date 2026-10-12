CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_einh_spr_zu AS SELECT mandant_id,
 einh_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN einh_bez
   ELSE NULL
   END) AS einh_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN einh_bez
   ELSE NULL
   END) AS einh_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN einh_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez
    ELSE NULL
    END)) AS einh_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN einh_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez
    ELSE NULL
    END)) AS einh_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN einh_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez
    ELSE NULL
    END)) AS einh_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN einh_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez
    ELSE NULL
    END)) AS einh_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN einh_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez
    ELSE NULL
    END)) AS einh_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN einh_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez
    ELSE NULL
    END)) AS einh_bez_bg
FROM kfl_production_dbp_view.v_einh_spr_zu AS V01
GROUP BY mandant_id,
 einh_id
UNION ALL
SELECT mandant_id,
 SUBSTR('LGB', 1, 3) AS einh_id,
 'Leergutbon' AS einh_bez,
 'Leergutbon' AS einh_bez_de,
 'Leergutbon' AS einh_bez_cz,
 'Leergutbon' AS einh_bez_pl,
 'Leergutbon' AS einh_bez_sk,
 'Leergutbon' AS einh_bez_hr,
 'Leergutbon' AS einh_bez_ro,
 'Leergutbon' AS einh_bez_bg
FROM kfl_production_dbp_view.v_mandant
WHERE (mandant_id, SUBSTR('LGB', 1, 3)) NOT IN (SELECT (mandant_id, einh_id)
   FROM kfl_production_dbp_view.v_einh_spr_zu);