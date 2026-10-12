CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.tbl_mv_f_in_fi_beleg_det_2 AS SELECT V01.mandant_id,
 V01.buchungskreis_id,
 V01.in_fi_beleg_id,
 V01.in_fi_beleg_pos_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V02.buchung_schl_id AS bsak_bschl_id,
 V01.buchung_schl_id AS bseg_bschl_id,
 V01.werk_id,
 V01.in_art_id,
 V02.in_lief_id,
 V01.menge_einh_id,
 V02.dat_buch,
 V01.soll_haben_kz,
 V01.betrag_fi_beleg,
 V05.umrechnungskurs,
 V01.menge_fi_beleg
FROM kfl_production_dbp_view.v_in_fi_beleg_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_fi_beleg_kred_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.in_fi_beleg_id
      = V02.in_fi_beleg_id AND V01.gj = V02.gj AND V01.dat_buch = V02.dat_buch AND V01.buchungskreis_id = V02.buchungskreis_id
   
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V05 ON V01.wrg_id = V05.von_wrg_id AND V02.dat_buch BETWEEN V05.dat_von
     AND V05.dat_bis AND V05.kurstyp_id = 9 AND V05.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_in_art_2 AS V06 ON V01.in_art_id = V06.in_art_id AND V01.mandant_id = V06.mandant_id
   
WHERE V01.buchung_schl_id IN ('40', '50', '70', '75', '80', '81', '82', '83', '84', '85', '86', '89', '90', '91', '92',
   '93', '94', '95', '96', '99')
 AND V02.offen_posten_fg = 0
 AND V01.in_fi_beleg_pos_kz <> 'T'
 AND CAST(V02.buchung_schl_id AS INTEGER) IN (21, 22, 31, 32)
 AND (V01.mandant_id, V02.in_lief_id) IN (SELECT (cast(V11.mandant_id as INT64), cast(V11.in_lief_id as INT64))
   FROM kfl_production_dbp_view.v_in_lieferant_ekorg_zu_2 AS V11
    INNER JOIN kfl_production_dbp_view.v_in_l_ekorg_2 AS V12 ON V11.mandant_id = V12.mandant_id AND V11.einkaufsorganisation_id
         = V12.einkaufsorganisation_id AND V12.sako_fg = 1 AND V11.einkaeufer_grp_id IS NOT NULL)
 AND (V01.mandant_id, V01.buchungskreis_id) IN (SELECT (cast(mandant_id as INT64), cast(buchungskreis_id as INT64))
   FROM kfl_production_dbp_view.v_in_l_buchungskreis_2
   WHERE sako_fg = 1)
 AND V01.industrie_fg <> 0
 AND V01.vbund_fg = 0
 AND (V06.artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG') OR SUBSTR(V06.in_art_nr, 1, 1) = 'W' OR V06.in_art_id = - 1
  )
 AND V01.beschaffung_relevant_fg = 1
 AND (V02.mandant_id, V02.in_lief_id) NOT IN (SELECT (cast(mandant_id as INT64), cast(in_lief_id as INT64))
   FROM kfl_production_dbp_view.v_in_lieferant_2
   WHERE werk_id <> - 1);