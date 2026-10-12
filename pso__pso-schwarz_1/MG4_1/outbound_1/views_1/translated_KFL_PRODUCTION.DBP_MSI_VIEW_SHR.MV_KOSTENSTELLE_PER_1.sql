CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_kostenstelle_per_1 (mandant_id, kostenstelle_id,
kostenstellenart_id, krk_id, kostenstelle_bez, wup_id, standort, kjmo_von, kjmo_bis) AS SELECT v01.mandant_id,
 v01.kostenstelle_id,
 v01.kostenstellenart_id,
 v01.krk_id,
 v02.kostenstelle_bez,
 v03.wup_id,
 v03.wup_stadt AS standort,
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
  FROM kfl_production_dbp_view.v_in_kostenstelle_per_1) AS v01
 LEFT JOIN kfl_production_dbp_view.v_in_kostenstelle_spr_zu_per_1 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.kostenstelle_id
      = v02.kostenstelle_id AND v02.dat_bis = DATE '9999-12-31' AND v02.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS v03 ON v01.mandant_id = v03.mandant_id -- AND v03.dat_von < DATE

   -- AND v03.dat_bis  > DATE
 AND CAST(v01.wup_id AS FLOAT64) = v03.wup_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS v04 ON v04.dat = CURRENT_DATE -- AND v03.dat_von < DATE

  -- AND v03.dat_bis  > DATE

WHERE v04.kjmo BETWEEN CAST(v01.kjmo_von AS INTEGER) AND (CAST(v01.kjmo_bis AS INTEGER));