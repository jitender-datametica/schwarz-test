CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_gewerke_immo_mobil_spr_zu_1 AS SELECT CASE
  WHEN V01.bvv_leist_id BETWEEN 1 AND 5
  THEN 1
  WHEN V01.bvv_leist_id BETWEEN 7 AND 123
  THEN 7
  WHEN V01.bvv_leist_id BETWEEN 125 AND 165
  THEN 125
  ELSE V01.bvv_leist_id
  END AS bvv_immo_mob_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.bvv_immob_mob_bez
   ELSE NULL
   END) AS bvv_immo_mob_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END)) AS bvv_immo_mob_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END)) AS bvv_immo_mob_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END)) AS bvv_immo_mob_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END)) AS bvv_immo_mob_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END)) AS bvv_immo_mob_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END)) AS bvv_immo_mob_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_immob_mob_bez
    ELSE NULL
    END)) AS bvv_immo_mob_bez_bg
FROM kfl_production_dbp_view.v_l_bvv_leistung_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_bvv_leistung_spr_zu_1 AS V02 ON V01.bvv_leist_id = V02.bvv_leist_id
GROUP BY bvv_immo_mob_id;