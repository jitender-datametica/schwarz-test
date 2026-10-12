CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_mietvertrag_sicher AS SELECT MVS.mandant_id,
 MVS.mietvertrag_id,
 MVS.debitor_id,
 MVS.buchungskreis_id,
 MVS.sicherheit_lfd_nr,
  MVS.betrag_sicherheit_ist * KURS.kurs AS betrag_sicherheit_ist,
  MVS.betrag_sicherheit_soll * KURS.kurs AS betrag_sicherheit_soll,
 MVS.dat_eingang,
 MVS.dat_einloesung,
 MVS.dat_rueckgabe,
 MVS.dat_uebergabe,
 MVS.dat_ausstellung,
 MVS.dat_bis,
 MVS.buergschaft_typ_id,
 COALESCE(MVS.buergschaft_id, '') AS buergschaft_id,
 COALESCE(MVS.kaution_bez, '') AS kaution_bez,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_mietvertrag_sicher AS MVS
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per AS KURS ON MVS.mandant_id = KURS.mandant_id AND
   COALESCE(MVS.dat_ausstellung, CURRENT_DATE) BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis;