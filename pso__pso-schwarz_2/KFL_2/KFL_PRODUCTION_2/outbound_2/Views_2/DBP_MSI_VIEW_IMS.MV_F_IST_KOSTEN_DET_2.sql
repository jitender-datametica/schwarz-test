CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_f_ist_kosten_det_2 AS SELECT V01.mandant_id,
 V01.psp_id,
 V01.projekt_typ_id,
 V01.gj,
 V01.buchungsperiode_id,
 V01.buchungskreis_id,
 V01.dat_buch,
 V01.dat_beleg,
 V01.soll_haben_kz,
 V01.belastungs_kz,
 V01.beleg_id,
 V01.beleg_pos_id,
 V01.beleg_bez,
 V01.krk_id,
 V01.geschaeftsbereich_id,
 V01.in_lief_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.ref_beleg_id,
 V01.ref_fi_beleg_id,
 V01.betrag_landeswrg,
 V01.auftrag_id,
 V01.kostenart_id,
 V01.anlage_id,
 V01.anlage_sub_id,
 V01.anlage_buchungskreis_id,
 V01.berichts_position_it_id,
 V01.berichts_position_invest_id,
 V01.sparte_id,
 V01.in_art_id,
 V01.kostenstelle_id,
 V01.bestell_text,
 V01.ref_buchungskreis_id,
 V01.belegart_id,
 V01.gegenkonto_id,
 V01.hb2_fg,
 V01.bedarf_nr,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.betrag
  ELSE V01.betrag * V500.umrechnungskurs
  END AS betrag
FROM kfl_production_dbp_msi_view_ims.tbl_mv_f_ist_kosten_det_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis;