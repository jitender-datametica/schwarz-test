CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_vz_1 (mandant_id, vz_id, nb_id, vz_bez) AS SELECT V01.mandant_id
 ,
 V01.wup_id AS vz_id,
 V01.nb_id,
  CASE
  WHEN V01.wup_id = - 1
  THEN 'ZENTRAL GENERELL'
  WHEN V01.wup_id = - 2
  THEN 'DEZENTRAL'
  ELSE V01.wup_standort
  END AS wup_standort
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN (SELECT v01.mandant_id,
   v01.vz_wup_id,
   v01.wup_plz,
    CASE
    WHEN CAST(v01.wup_plz AS FLOAT64) < 20000 OR v01.vz_wup_id = 6907
    THEN '1'
    WHEN CAST(v01.wup_plz AS INTEGER) BETWEEN 20000 AND 59999
    THEN '3'
    ELSE '2'
    END AS zu_id,
   V02.wup_id,
   V02.nb_id
  FROM (SELECT mandant_id,
     vz_wup_id,
     wup_plz,
      CASE
      WHEN CAST(wup_plz AS FLOAT64) < 20000 OR vz_wup_id = 6907
      THEN '1'
      WHEN CAST(wup_plz AS INTEGER) BETWEEN 20000 AND 59999
      THEN '3'
      ELSE '2'
      END AS zu_id
    FROM kfl_production_dbp_view.v_wup_1 AS V01
    WHERE vz_wup_id = wup_id
     AND wup_typ_id = 2
     AND nb_id = - 111
     AND mandant_id = 1) AS v01
   LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON v01.vz_wup_id = V02.vz_wup_id AND v01.mandant_id = V02.mandant_id)
 AS v02 ON V01.vz_wup_id = v02.wup_id
WHERE V01.wup_typ_id IN (- 1, 2)
 AND V01.mandant_id = 1
 AND V01.wup_id IN (6902, 6903, 6905, 6906, 6907, 6908, 6909)
UNION ALL
SELECT mandant_id,
 wup_id AS vz_id,
 nb_id,
 wup_standort AS vz_bez
FROM kfl_production_dbp_view.v_wup_1 AS V01
WHERE nb_id = - 111
 AND (mandant_id = 2 AND wup_id IN (9200, 9300) OR mandant_id = 3 AND wup_id IN (9110, 9140, 9160, 9180, 9460, 9760) OR
        mandant_id = 5 AND wup_id IN (9020, 9120) OR mandant_id = 6 AND wup_id IN (9030, 9130) OR mandant_id = 7 AND
      wup_id IN (6100, 6200, 9100, 9200) OR mandant_id = 8 AND wup_id IN (6100));