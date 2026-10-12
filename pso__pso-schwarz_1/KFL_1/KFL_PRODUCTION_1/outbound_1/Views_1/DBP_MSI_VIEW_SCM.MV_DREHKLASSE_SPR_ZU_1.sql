CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_drehklasse_spr_zu_1 AS SELECT mandant_id,
 drehklasse_kz,
 MAX(CASE
   WHEN spr_id = 22
   THEN drehklasse_bez
   ELSE NULL
   END) AS drehklasse_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN drehklasse_bez
   ELSE NULL
   END) AS drehklasse_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN drehklasse_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN drehklasse_bez
    ELSE NULL
    END)) AS drehklasse_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN drehklasse_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN drehklasse_bez
    ELSE NULL
    END)) AS drehklasse_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN drehklasse_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN drehklasse_bez
    ELSE NULL
    END)) AS drehklasse_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN drehklasse_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN drehklasse_bez
    ELSE NULL
    END)) AS drehklasse_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN drehklasse_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN drehklasse_bez
    ELSE NULL
    END)) AS drehklasse_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN drehklasse_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN drehklasse_bez
    ELSE NULL
    END)) AS drehklasse_bez_bg
FROM kfl_production_dbp_view.v_drehklasse_spr_zu_1
GROUP BY mandant_id,
 drehklasse_kz;