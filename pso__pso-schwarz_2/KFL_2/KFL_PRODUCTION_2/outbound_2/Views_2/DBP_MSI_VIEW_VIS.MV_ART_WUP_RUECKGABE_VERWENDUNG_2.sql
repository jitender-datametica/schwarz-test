CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wup_rueckgabe_verwendung_2 (mandant_id, rueckgabe_nr, dat,
dat_rueckgabe, wup_id, nb_id, reklamationsgrund_id, art_id, einh_id, wrg_id, dat_mhd, rueckgabe_verwendung_kz,
verarbeitet_fg, dat_verarbeitung, menge_art, betrag_vk_netto_rueckgabe, betrag_vk_netto_kauf) AS SELECT RV.mandant_id,
 RV.rueckgabe_nr,
 RV.dat_rueckgabe AS dat,
 RV.dat_rueckgabe,
 WUP.aktuell_wup_id AS wup_id,
 RV.nb_id,
 RV.reklamationsgrund_id,
 RV.art_id,
 RV.einh_id,
 RV.wrg_id,
 RV.dat_mhd,
 RV.rueckgabe_verwendung_kz,
 RV.verarbeitet_fg,
 RV.dat_verarbeitung,
 RV.menge_art,
  RV.betrag_vk_netto_rueckgabe * krs.umrechnungskurs AS betrag_vk_netto_rueckgabe,
  RV.betrag_vk_netto_kauf * krs.umrechnungskurs AS betrag_vk_netto_kauf
FROM kfl_production_dbp_view.v_art_wup_rueckgabe_verwendung_2 AS RV
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON RV.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON RV.mandant_id = WUP.mandant_id AND RV.wup_id = WUP.wup_id;