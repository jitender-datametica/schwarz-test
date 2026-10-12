CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_besch_best_2 (best_beleg_id, mandant_id, in_lief_id,
bestellart_id, bestell_typ_id, artikelart_id, abweichung_fg, einkaufsorganisation_id, dat_best_beleg, einkaeufer_grp_id
, buchungskreis_id, dat_aenderung, k_shop_fg, bsak_dat_buch, dat_buch, best_angepasst_fg, lagerbest_auto_fg,
lagerbest_man_fg) AS SELECT V01.best_beleg_id,
 V01.mandant_id,
 V01.in_lief_id,
 V01.bestellart_id,
 V01.bestell_typ_id,
 V01.artikelart_id,
 V01.abweichung_fg,
 V01.einkaufsorganisation_id,
 V01.dat_best_beleg,
 V01.einkaeufer_grp_id,
 V01.buchungskreis_id,
 V01.dat_aenderung,
 COALESCE(v02.k_shop_fg, 0) AS k_shop_fg,
 v03.bsak_dat_buch,
 v04.dat_buch,
  CASE
  WHEN DATE_DIFF(v03.bsak_dat_buch, v04.dat_buch, DAY) <= 5
  THEN 1
  ELSE 0
  END AS best_angepasst_fg,
  CASE
  WHEN V01.bestellart_id LIKE '1DBS'
  THEN 1
  ELSE 0
  END AS lagerbest_auto_fg,
  CASE
  WHEN V01.bestellart_id LIKE '1MBS'
  THEN 1
  ELSE 0
  END AS lagerbest_man_fg
FROM kfl_production_dbp_view.v_in_besch_best_2 AS V01
 LEFT JOIN (SELECT DISTINCT best_beleg_id,
   mandant_id,
   k_shop_fg
  FROM kfl_production_dbp_view.v_in_besch_best_det_2
  WHERE k_shop_fg = 1) AS v02 ON V01.best_beleg_id = v02.best_beleg_id AND V01.mandant_id = v02.mandant_id
 LEFT JOIN (SELECT best_beleg_id,
   mandant_id,
   MAX(bsak_dat_buch) AS bsak_dat_buch
  FROM kfl_production_dbp_view.v_in_besch_best_det_2
  GROUP BY best_beleg_id,
   mandant_id) AS v03 ON V01.best_beleg_id = v03.best_beleg_id AND V01.mandant_id = v03.mandant_id
 LEFT JOIN (SELECT mandant_id,
   best_beleg_id,
   MAX(dat_buch) AS dat_buch
  FROM kfl_production_dbp_view.v_in_best_belegfluss_2
  GROUP BY best_beleg_id,
   mandant_id) AS v04 ON V01.best_beleg_id = v04.best_beleg_id AND V01.mandant_id = v04.mandant_id
WHERE V01.memory_fg = 0
 AND (V01.einkaufsorganisation_id IN (9200, 9300, 9500) OR V01.einkaufsorganisation_id = 9000 AND V01.mandant_id = 1 OR
          V01.einkaufsorganisation_id = 8010 AND V01.mandant_id = 2 OR V01.einkaufsorganisation_id = 8020 AND V01.mandant_id
          = 5 OR V01.einkaufsorganisation_id = 8030 AND V01.mandant_id = 6 OR V01.einkaufsorganisation_id = 8050 AND V01
       .mandant_id = 3 OR V01.einkaufsorganisation_id = 8070 AND V01.mandant_id = 7 OR V01.einkaufsorganisation_id =
     8090 AND V01.mandant_id = 8);