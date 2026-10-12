CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_besitzverhaeltnis_spr_zu_2 AS SELECT V01.besitzverhaeltnis_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.besitzverhaeltnis_bez
   ELSE NULL
   END) AS besitzverhaeltnis_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END)) AS besitzverhaeltnis_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END)) AS besitzverhaeltnis_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END)) AS besitzverhaeltnis_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END)) AS besitzverhaeltnis_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END)) AS besitzverhaeltnis_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END)) AS besitzverhaeltnis_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.besitzverhaeltnis_bez
    ELSE NULL
    END)) AS besitzverhaeltnis_bez_bg
FROM kfl_production_dbp_view.v_l_besitzverhaeltnis_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_besitzverhaeltnis_spr_zu_2 AS V02 ON V01.besitzverhaeltnis_id = V02.besitzverhaeltnis_id
  
GROUP BY V01.besitzverhaeltnis_id
UNION ALL
SELECT ' -1' AS besitzverhaeltnis_id,
 ' ' AS besitzverhaeltnis_bez,
 ' ' AS dm__operand2,
 ' ' AS dm__operand3,
 ' ' AS dm__operand4,
 ' ' AS dm__operand5,
 ' ' AS dm__operand6,
 ' ' AS dm__operand7,
 ' ' AS dm__operand8;