CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.tbl_mv_f_in_best_fi_beleg_det AS SELECT V01.mandant_id,
 V01.in_fi_beleg_id,
 V01.in_fi_beleg_pos_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.dat_buch,
 V02.buchung_schl_id AS bsak_bschl_id,
 V01.buchung_schl_id AS bseg_bschl_id,
  CASE
  WHEN V01.soll_haben_kz = 'S'
  THEN 1
  ELSE - 1
  END AS ind_vz,
  V01.menge_fi_beleg * CASE
   WHEN V01.soll_haben_kz = 'S'
   THEN 1
   ELSE - 1
   END AS bestell_menge_fi_beleg,
 v03.in_art_id,
 v03.in_lief_id,
 v03.werk_id,
 V01.werk_id AS rech_werk_id,
 V01.in_art_id AS rech_in_art_id,
 v03.bestellart_id,
 v03.rech_plan_id,
 v03.endrech_fg,
 v03.einkaufsorganisation_id,
 v03.buchungskreis_id,
 v03.dat_von_rb,
 V01.betrag_fi_beleg,
 V05.umrechnungskurs
FROM kfl_production_dbp_view.v_in_fi_beleg_det AS V01
 INNER JOIN kfl_production_dbp_view.v_in_fi_beleg_kred AS V02 ON V01.mandant_id = V02.mandant_id AND V01.in_fi_beleg_id
     = V02.in_fi_beleg_id AND V01.gj = V02.gj AND V01.buchungskreis_id = V02.buchungskreis_id
 INNER JOIN (SELECT V031.mandant_id,
   V031.best_beleg_id,
   V031.best_beleg_pos_id,
   V031.endrech_fg,
   V031.rech_plan_id,
   V032.bestellart_id,
   V031.betrag_pos_netto_best_wrg,
   V031.menge_best_bme,
   V032.in_lief_id,
   V031.in_art_id,
   V032.einkaufsorganisation_id,
   V031.werk_id,
   V032.buchungskreis_id,
   V032.dat_von_rb
  FROM kfl_production_dbp_view.v_in_besch_best_det AS V031
   INNER JOIN kfl_production_dbp_view.v_in_besch_best AS V032 ON V031.best_beleg_id = V032.best_beleg_id AND V031.mandant_id
      = V032.mandant_id
   INNER JOIN kfl_production_dbp_view.v_in_art AS V033 ON V031.in_art_id = V033.in_art_id AND V031.mandant_id = V033.mandant_id
     
  WHERE (V032.dat_von_rb IS NOT NULL OR V031.rech_plan_id IS NOT NULL)
   AND V032.memory_fg = 0
   AND (V033.artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG') OR SUBSTR(V033.in_art_nr, 1, 1) = 'W' OR V033.in_art_id =
      - 1)) AS v03 ON V01.best_beleg_id = v03.best_beleg_id AND V01.best_beleg_pos_id = v03.best_beleg_pos_id AND V01.mandant_id
    = v03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V05 ON V01.wrg_id = V05.von_wrg_id AND V01.dat_buch BETWEEN V05.dat_von
     AND V05.dat_bis AND V05.kurstyp_id = 9 AND V05.nach_wrg_id = 'EUR'
WHERE V01.buchung_schl_id IN ('40', '50', '70', '75', '80', '81', '82', '83', '84', '85', '86', '89', '90', '91', '92',
   '93', '94', '95', '96', '99')
 AND V02.offen_posten_fg = 0
 AND V01.in_fi_beleg_pos_kz <> 'T'
 AND V02.buchung_schl_id IN ('21', '22', '31', '32')
 AND (V01.mandant_id, V02.in_lief_id) IN (SELECT (cast(V11.mandant_id as INT64), cast(V11.in_lief_id as INT64))
   FROM kfl_production_dbp_view.v_in_lieferant_ekorg_zu AS V11
    INNER JOIN kfl_production_dbp_view.v_in_l_ekorg AS V12 ON V11.mandant_id = V12.mandant_id AND V11.einkaufsorganisation_id
         = V12.einkaufsorganisation_id AND V12.sako_fg = 1 AND V11.einkaeufer_grp_id IS NOT NULL)
 AND (V01.mandant_id, V01.buchungskreis_id) IN (SELECT (cast(mandant_id as INT64), cast(buchungskreis_id as INT64))
   FROM kfl_production_dbp_view.v_in_l_buchungskreis
   WHERE sako_fg = 1)
 AND V01.industrie_fg <> 0
 AND V01.vbund_fg = 0
 AND V01.beschaffung_relevant_fg = 1;