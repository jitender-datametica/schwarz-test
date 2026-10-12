CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.tbl_mv_f_in_besch_best_det_2 AS SELECT V01.bestellart_id,
 V01.buchungskreis_id,
 V01.dat_aenderung,
 V01.dat_best_beleg,
 V01.dat_von_rb,
 V01.einkaufsorganisation_id,
 V01.in_lief_id,
 V02.besch_pos_typ_id,
 V02.best_beleg_id,
 V02.best_beleg_pos_id,
 V02.best_menge_einh_id,
 V02.betrag_pos_netto_best_wrg,
 V02.endrech_fg,
 V02.in_art_id,
 V02.mandant_id,
 V02.menge_best_bme,
 V02.menge_bme,
 V02.rech_plan_id,
 V02.werk_id,
 V05.umrechnungskurs,
 V02.retourenpos_fg
FROM kfl_production_dbp_view.v_in_besch_best_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_besch_best_det_2 AS V02 ON V01.best_beleg_id = V02.best_beleg_id AND V01.mandant_id
    = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V05 ON V03.default_wrg = V05.von_wrg_id AND V01.dat_best_beleg BETWEEN V05
     .dat_von AND V05.dat_bis AND V05.kurstyp_id = 9 AND V05.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_in_art_2 AS V06 ON V02.in_art_id = V06.in_art_id AND V02.mandant_id = V06.mandant_id
   
WHERE V01.memory_fg = 0
 AND (V01.mandant_id, V01.in_lief_id) IN (SELECT (V11.mandant_id, V11.in_lief_id)
   FROM kfl_production_dbp_view.v_in_lieferant_ekorg_zu_2 AS V11
    INNER JOIN kfl_production_dbp_view.v_in_l_ekorg_2 AS V12 ON V11.mandant_id = V12.mandant_id AND V11.einkaufsorganisation_id
         = V12.einkaufsorganisation_id AND V12.sako_fg = 1 AND V11.einkaeufer_grp_id IS NOT NULL)
 AND (V01.mandant_id, V01.buchungskreis_id) IN (SELECT (mandant_id, buchungskreis_id)
   FROM kfl_production_dbp_view.v_in_l_buchungskreis_2
   WHERE sako_fg = 1)
 AND (V06.artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG') OR SUBSTR(V06.in_art_nr, 1, 1) = 'W' OR V06.in_art_id = - 1
  )
 AND V02.loesch_id = '';