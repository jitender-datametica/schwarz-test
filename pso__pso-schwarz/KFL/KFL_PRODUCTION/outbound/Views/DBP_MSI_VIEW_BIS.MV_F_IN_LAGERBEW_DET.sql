CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_lagerbew_det (mandant_id, lagerbew_beleg_id, kj,
lagerbew_beleg_pos_id, in_art_id, in_lief_id, werk_id, best_beleg_id, best_beleg_pos_id, dat_buch, dat_lief_tat,
lagerbew_beleg_storno_id, soll_haben_kz, menge_bstmg, menge_erf, erfsngs_menge_einh_id, menge_bme, erste_we_fg,
in_bewart_id) AS SELECT V02.mandant_id,
 V02.lagerbew_beleg_id,
 V02.kj,
 V02.lagerbew_beleg_pos_id,
 V02.in_art_id,
 V02.in_lief_id,
 V02.werk_id,
 V02.best_beleg_id,
 V02.best_beleg_pos_id,
 V01.dat_buch,
 v03.dat_lief_tat,
 V02.lagerbew_beleg_storno_id,
 V02.soll_haben_kz,
 V02.menge_bstmg,
 V02.menge_erf,
 V02.erfsngs_menge_einh_id,
 ROUND(CAST(TRUNC(CAST(V02.menge_erf / ROUND(CAST(V04.umrech_faktor AS BIGNUMERIC), 5) AS BIGNUMERIC)) AS BIGNUMERIC), 5
  ) AS menge_bme,
  CASE
  WHEN V01.dat_erfasst = v03.dat_lief_tat
  THEN 1
  ELSE 0
  END AS erste_we_fg,
 V02.in_bewart_id
FROM kfl_production_dbp_view.v_in_lagerbew AS V01
 INNER JOIN kfl_production_dbp_view.v_in_lagerbew_det AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lagerbew_beleg_id
     = V02.lagerbew_beleg_id AND V01.kj = V02.kj
 LEFT JOIN (SELECT V020.mandant_id,
   V020.best_beleg_id,
   V020.best_beleg_pos_id,
   MIN(V010.dat_erfasst) AS dat_lief_tat
  FROM kfl_production_dbp_view.v_in_lagerbew AS V010
   INNER JOIN kfl_production_dbp_view.v_in_lagerbew_det AS V020 ON V010.mandant_id = V020.mandant_id AND V010.lagerbew_beleg_id
       = V020.lagerbew_beleg_id AND V010.kj = V020.kj
  GROUP BY V020.mandant_id,
   V020.best_beleg_id,
   V020.best_beleg_pos_id) AS v03 ON V02.mandant_id = v03.mandant_id AND V02.best_beleg_id = v03.best_beleg_id AND V02.best_beleg_pos_id
    = v03.best_beleg_pos_id
 LEFT JOIN kfl_production_dbp_view.v_in_art_umrech_faktor AS V04 ON V02.mandant_id = V04.mandant_id AND V02.in_art_id =
    V04.in_art_id AND V02.erfsngs_menge_einh_id = V04.altnv_menge_einh_id
 INNER JOIN kfl_production_dbp_view.v_in_art AS E ON V02.mandant_id = E.mandant_id AND V02.in_art_id = E.in_art_id
WHERE E.artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG')
 OR SUBSTR(E.in_art_nr, 1, 1) = 'W'
 OR E.in_art_id = - 1;