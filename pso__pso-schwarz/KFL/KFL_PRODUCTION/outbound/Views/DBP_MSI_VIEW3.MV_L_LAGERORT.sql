CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lagerort AS SELECT V01.lagerort_id,
 V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 COALESCE(V02.lagernummer_id, CASE
   WHEN V01.mandant_id = 1 AND V01.nb_id = - 111
   THEN '-' || SUBSTR(SUBSTR(CAST(V01.wup_id AS STRING), 1, 39), 2, 4)
   WHEN V01.mandant_id <> 1 AND V01.nb_id = - 111
   THEN '-' || SUBSTR(SUBSTR(CAST(V01.wup_id AS STRING), 1, 39), 1, 3)
   ELSE '-99'
   END) AS lagernummer_id
FROM kfl_production_dbp_view.v_l_lagerort AS V01
 LEFT JOIN kfl_production_dbp_view.v_l_lagernummer AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
      AND V01.nb_id = V02.nb_id AND V01.lagernummer_id = V02.lagernummer_id
WHERE V01.lagerort_id NOT IN ('-1', '-2', '-3');