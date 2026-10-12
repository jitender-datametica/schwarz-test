CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_fin_gruppe_spr_zu AS -- standard == DE
 -- CZ
 -- SK

-- HR
 -- PL
 -- RO
 -- EN
 -- BG
 -- left aus "normaler" View übernommen
 SELECT V01.fin_gruppe_id,
 V01.fin_kategorie_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.fin_gruppe_bez
   ELSE NULL
   END) AS fin_gruppe_bez,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 124
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END)) AS fin_gruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 108
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END)) AS fin_gruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 65
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END)) AS fin_gruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 90
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END)) AS fin_gruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 95
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END)) AS fin_gruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 24
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END)) AS fin_gruppe_bez_en,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 18
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.fin_gruppe_bez
    ELSE NULL
    END)) AS fin_gruppe_bez_bg
FROM kfl_production_dbp_view.v_l_rpm_fin_gruppe AS V01
 LEFT JOIN kfl_production_dbp_view.v_rpm_fin_gruppe_spr_zu AS V03 ON V01.fin_gruppe_id = V03.fin_gruppe_id AND V01.fin_kategorie_id
    = V03.fin_kategorie_id
GROUP BY V01.fin_gruppe_id,
 V01.fin_kategorie_id;