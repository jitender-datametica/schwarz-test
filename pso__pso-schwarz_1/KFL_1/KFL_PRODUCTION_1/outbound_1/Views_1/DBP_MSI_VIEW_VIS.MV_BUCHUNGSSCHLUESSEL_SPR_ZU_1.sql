CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_buchungsschluessel_spr_zu_1 AS SELECT buchungsschluessel_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN buchungsschluessel_bez
   ELSE NULL
   END) AS buchungsschluessel_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN buchungsschluessel_bez
   ELSE NULL
   END) AS buchungsschluessel_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN buchungsschluessel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN buchungsschluessel_bez
    ELSE NULL
    END)) AS buchungsschluessel_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN buchungsschluessel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN buchungsschluessel_bez
    ELSE NULL
    END)) AS buchungsschluessel_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN buchungsschluessel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN buchungsschluessel_bez
    ELSE NULL
    END)) AS buchungsschluessel_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN buchungsschluessel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN buchungsschluessel_bez
    ELSE NULL
    END)) AS buchungsschluessel_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN buchungsschluessel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN buchungsschluessel_bez
    ELSE NULL
    END)) AS buchungsschluessel_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN buchungsschluessel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN buchungsschluessel_bez
    ELSE NULL
    END)) AS buchungsschluessel_bez_bg
FROM kfl_production_dbp_v_ods.v_buchungsschluessel_spr_zu_1
GROUP BY buchungsschluessel_id;