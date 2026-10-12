CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_kostenstelle_per_2 (mandant_id, kostenstelle_id,
kostenstellenart_id, krk_id, kostenstelle_bez, wup_id, standort, kjmo_von, kjmo_bis) AS SELECT v01.mandant_id,
 v01.kostenstelle_id,
 v01.kostenstellenart_id,
 v01.krk_id,
 V02.kostenstelle_bez,
 V03.wup_id,
 V03.wup_stadt AS standort,
 v01.kjmo_von,
 v01.kjmo_bis
FROM (SELECT mandant_id,
   kostenstelle_id,
   kostenstellenart_id,
   krk_id,
    CASE
    WHEN SUBSTR(kostenstelle_id, 1, 4) BETWEEN '0000' AND '9999'
    THEN SUBSTR(kostenstelle_id, 1, 4)
    ELSE NULL
    END AS wup_id,
    SUBSTR(SUBSTR(CAST(dat_von AS STRING), 1, 20), 1, 4) || SUBSTR(SUBSTR(CAST(dat_von AS STRING), 1, 20), 6, 2) AS
   kjmo_von,
    SUBSTR(SUBSTR(CAST(dat_bis AS STRING), 1, 20), 1, 4) || SUBSTR(SUBSTR(CAST(dat_bis AS STRING), 1, 20), 6, 2) AS
   kjmo_bis
  FROM kfl_production_dbp_view.v_in_kostenstelle_per_2) AS v01
 LEFT JOIN kfl_production_dbp_view.v_in_kostenstelle_spr_zu_per_2 AS V02 ON v01.mandant_id = V02.mandant_id AND v01.kostenstelle_id
      = V02.kostenstelle_id AND V02.dat_bis = DATE '9999-12-31' AND V02.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V03 ON v01.mandant_id = V03.mandant_id AND CAST(v01.wup_id AS FLOAT64) = V03
   .wup_id
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V04 ON V04.dat = CURRENT_DATE
WHERE V04.kjmo BETWEEN ROUND(CAST(v01.kjmo_von AS BIGNUMERIC), 0) AND (ROUND(CAST(v01.kjmo_bis AS BIGNUMERIC), 0));