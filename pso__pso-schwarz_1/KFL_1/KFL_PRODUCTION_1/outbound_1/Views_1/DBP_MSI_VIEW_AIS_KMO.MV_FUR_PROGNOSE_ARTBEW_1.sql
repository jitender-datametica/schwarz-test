CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_fur_prognose_artbew_1 (wup_id, nb_id, mandant_id, art_id,
dat, menge_prognose, menge_prognose_bef, menge_prognose_max, menge_ofc, vk_menge, vk_menge_af, vk_menge_sa,
diff_menge_af_prognose, gp_id, progn_groesser_fg, menge_af_groesser_fg) AS SELECT V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.art_id,
 V02.dat,
 MIN(CAST(V01.menge_prognose AS NUMERIC)) AS menge_prognose,
 MIN(CAST(V01.menge_prognose_bef AS NUMERIC)) AS menge_prognose_bef,
 MIN(CAST(V01.menge_prognose_max AS NUMERIC)) AS menge_prognose_max,
 MIN(CAST(V01.menge_ofc AS NUMERIC)) AS menge_ofc,
 SUM(CAST(V04.menge AS BIGNUMERIC)) AS menge,
 SUM(CASE
   WHEN V04.bewart_id IN (1001, 1010)
   THEN CAST(V04.menge AS BIGNUMERIC)
   ELSE NULL
   END) AS vk_menge_af,
 SUM(CASE
   WHEN V04.bewart_id = 1002
   THEN CAST(V04.menge AS BIGNUMERIC)
   ELSE NULL
   END) AS vk_menge_sa,
  CASE
  WHEN SUM(CASE
    WHEN V04.bewart_id = 1002
    THEN CAST(V04.menge AS BIGNUMERIC)
    ELSE NULL
    END) IS NOT NULL
  THEN NULL
  ELSE ABS(IFNULL(SUM(CASE
       WHEN V04.bewart_id IN (1001, 1010)
       THEN CAST(V04.menge AS BIGNUMERIC)
       ELSE NULL
       END), 0) - MIN(CAST(V01.menge_prognose AS NUMERIC)))
  END AS diff_menge_af_prognose,
 V03.gp_id,
 V01.progn_groesser_fg,
 V01.menge_af_groesser_fg
FROM kfl_production_dbp_data.fur_prognose_1 AS V01
 INNER JOIN kfl_production_dbp_data.tag_1 AS V02 ON V01.dat = V02.dat
 INNER JOIN kfl_production_dbp_data.art_gp_nm_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.wup_id = V03.wup_id AND
    V01.mandant_id = V03.mandant_id AND V02.dat BETWEEN V03.dat_von AND V03.dat_bis
 LEFT JOIN kfl_production_dbp_data.artbew_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND V01
      .wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V03.gp_id = V04.gp_id AND V02.dat = V04.dat
WHERE V01.mandant_id > 1
 AND V01.dispomerkmal IN ('S2', '10', '12', '14')
 AND V01.listung_id = 1
 AND V01.kdis = 0
 AND (V04.mandant_id <> 5 OR V04.art_id <> 206731500)
 AND (V04.mandant_id <> 2 OR V04.art_id <> 208124500)
 AND (V04.mandant_id <> 3 OR V04.art_id <> 208113690)
 AND (V04.mandant_id <> 6 OR V04.art_id <> 208131570)
 AND (V04.mandant_id NOT IN (4, 7) OR V04.art_id <> 208114740)
 AND (V04.mandant_id <> 8 OR V04.art_id <> 208131640)
GROUP BY V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.art_id,
 V02.dat,
 V03.gp_id,
 V01.progn_groesser_fg,
 V01.menge_af_groesser_fg;