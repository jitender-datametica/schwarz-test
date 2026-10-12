CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MIETVERTRAG_SICHER_1 as
   -- 2013-04-11
   -- ZUORDNUNG Mietvertrag Mietsicherheiten
   -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten
   -- 2013-04-16 : Update/Korrektur

   SELECT
   mvs.mandant_id,
   mvs.mietvertrag_id,
   mvs.debitor_id,
   mvs.buchungskreis_id,
   mvs.sicherheit_lfd_nr,
   mvs.betrag_sicherheit_ist * kurs_1  AS betrag_sicherheit_ist,
   mvs.betrag_sicherheit_soll * kurs_1 AS betrag_sicherheit_soll,
   mvs.dat_eingang,
   mvs.dat_einloesung,
   mvs.dat_rueckgabe,
   mvs.dat_uebergabe,
   mvs.dat_ausstellung,
   mvs.dat_bis,
   mvs.buergschaft_typ_id,
   COALESCE(mvs.buergschaft_id, '') AS buergschaft_id,
   COALESCE(mvs.kaution_bez, '')    AS kaution_bez,
   kurs.wrg_id,
   kurs.wrg_typ_id
  FROM dbp_view.v_ivs_mietvertrag_sicher_1  mvs
   INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1  kurs_1
   ON kurs.mandant_id = mvs.mandant_id
   AND COALESCE(mvs.dat_ausstellung, CURRENT_DATE) BETWEEN kurs_dat_von AND kurs_dat_bis;