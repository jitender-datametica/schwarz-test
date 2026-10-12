CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_dispomerkmal_spr_zu_2 AS SELECT mandant_id,
 dispomerkmal,
 MAX(CASE
   WHEN spr_id = 22
   THEN dispomerkmal_bez
   ELSE NULL
   END) AS dispomerkmal_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN dispomerkmal_bez
   ELSE NULL
   END) AS dispomerkmal_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN dispomerkmal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dispomerkmal_bez
    ELSE NULL
    END)) AS dispomerkmal_bez_bg
FROM kfl_production_dbp_view.v_dispomerkmal_spr_zu_2 AS V01
GROUP BY mandant_id,
 dispomerkmal;