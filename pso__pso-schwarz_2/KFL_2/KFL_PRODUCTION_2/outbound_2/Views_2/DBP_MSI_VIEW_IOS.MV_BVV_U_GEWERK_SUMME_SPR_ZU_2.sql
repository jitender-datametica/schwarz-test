CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_u_gewerk_summe_spr_zu_2 AS SELECT DISTINCT CASE
  WHEN V01.bvv_leist_id BETWEEN 7 AND 17
  THEN 1
  WHEN V01.bvv_leist_id BETWEEN 18 AND 85
  THEN 2
  WHEN V01.bvv_leist_id BETWEEN 87 AND 123
  THEN 3
  WHEN V01.bvv_leist_id BETWEEN 125 AND 158
  THEN 4
  WHEN V01.bvv_leist_id = 5
  THEN 5
  WHEN V01.bvv_leist_id BETWEEN 1 AND 3
  THEN 6
  WHEN V01.bvv_leist_id BETWEEN 159 AND 162
  THEN 7
  WHEN V01.bvv_leist_id BETWEEN 163 AND 165
  THEN 8
  ELSE V01.bvv_leist_id
  END AS bvv_u_gewerk_summe_id,
  CASE
  WHEN CASE
    WHEN V01.bvv_leist_id BETWEEN 7 AND 17
    THEN 1
    WHEN V01.bvv_leist_id BETWEEN 18 AND 85
    THEN 2
    WHEN V01.bvv_leist_id BETWEEN 87 AND 123
    THEN 3
    WHEN V01.bvv_leist_id BETWEEN 125 AND 158
    THEN 4
    WHEN V01.bvv_leist_id = 5
    THEN 5
    WHEN V01.bvv_leist_id BETWEEN 1 AND 3
    THEN 6
    WHEN V01.bvv_leist_id BETWEEN 159 AND 162
    THEN 7
    WHEN V01.bvv_leist_id BETWEEN 163 AND 165
    THEN 8
    ELSE V01.bvv_leist_id
    END = 1
  THEN 'Infrastruktur'
  WHEN CASE
    WHEN V01.bvv_leist_id BETWEEN 7 AND 17
    THEN 1
    WHEN V01.bvv_leist_id BETWEEN 18 AND 85
    THEN 2
    WHEN V01.bvv_leist_id BETWEEN 87 AND 123
    THEN 3
    WHEN V01.bvv_leist_id BETWEEN 125 AND 158
    THEN 4
    WHEN V01.bvv_leist_id = 5
    THEN 5
    WHEN V01.bvv_leist_id BETWEEN 1 AND 3
    THEN 6
    WHEN V01.bvv_leist_id BETWEEN 159 AND 162
    THEN 7
    WHEN V01.bvv_leist_id BETWEEN 163 AND 165
    THEN 8
    ELSE V01.bvv_leist_id
    END = 2
  THEN 'Baukosten/Gebaeude'
  ELSE V02.bvv_gewerk_bez
  END AS bvv_u_gewerk_summe_bez
FROM kfl_production_dbp_view.v_l_bvv_leistung_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_bvv_leistung_spr_zu_2 AS V02 ON V01.bvv_leist_id = V02.bvv_leist_id
WHERE V02.spr_id = 22;