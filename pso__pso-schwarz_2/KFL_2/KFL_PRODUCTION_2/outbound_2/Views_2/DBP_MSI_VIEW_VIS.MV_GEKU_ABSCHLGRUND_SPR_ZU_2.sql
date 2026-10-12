CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_abschlgrund_spr_zu_2 AS SELECT abschlussgrund_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschlussgrund_bez
   ELSE NULL
   END) AS abschlussgrund_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abschlussgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschlussgrund_bez
    ELSE NULL
    END)) AS abschlussgrund_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abschlussgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschlussgrund_bez
    ELSE NULL
    END)) AS abschlussgrund_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abschlussgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschlussgrund_bez
    ELSE NULL
    END)) AS abschlussgrund_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abschlussgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschlussgrund_bez
    ELSE NULL
    END)) AS abschlussgrund_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abschlussgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschlussgrund_bez
    ELSE NULL
    END)) AS abschlussgrund_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abschlussgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschlussgrund_bez
    ELSE NULL
    END)) AS abschlussgrund_bez_bg
FROM kfl_production_dbp_view.v_geku_abschlussgrund_spr_zu_2 AS V01
GROUP BY abschlussgrund_id;