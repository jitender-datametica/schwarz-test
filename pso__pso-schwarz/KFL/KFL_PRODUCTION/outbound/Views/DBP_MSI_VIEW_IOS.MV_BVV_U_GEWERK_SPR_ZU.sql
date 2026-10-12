CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_u_gewerk_spr_zu AS SELECT CASE
  WHEN V01.bvv_leist_id BETWEEN 7 AND 11
  THEN 7
  WHEN V01.bvv_leist_id BETWEEN 12 AND 17
  THEN 12
  WHEN V01.bvv_leist_id BETWEEN 18 AND 85
  THEN 18
  WHEN V01.bvv_leist_id BETWEEN 87 AND 123
  THEN 87
  WHEN V01.bvv_leist_id BETWEEN 125 AND 158
  THEN 158
  WHEN V01.bvv_leist_id BETWEEN 159 AND 162
  THEN 159
  WHEN V01.bvv_leist_id BETWEEN 163 AND 165
  THEN 163
  ELSE V01.bvv_leist_id
  END AS bvv_u_gewerk_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.bvv_u_gewerk_bez
   ELSE NULL
   END) AS bvv_u_gewerk_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END)) AS bvv_u_gewerk_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END)) AS bvv_u_gewerk_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END)) AS bvv_u_gewerk_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END)) AS bvv_u_gewerk_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END)) AS bvv_u_gewerk_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END)) AS bvv_u_gewerk_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_u_gewerk_bez
    ELSE NULL
    END)) AS bvv_u_gewerk_bez_bg
FROM kfl_production_dbp_view.v_l_bvv_leistung AS V01
 INNER JOIN kfl_production_dbp_view.v_bvv_leistung_spr_zu AS V02 ON V01.bvv_leist_id = V02.bvv_leist_id
GROUP BY bvv_u_gewerk_id;