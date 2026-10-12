CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_fehlmengen_1 (mandant_id, wup_id, nb_id, lagerort_id,
empfaenger_wup_id, mandant_id_empfaenger, empfaenger_nb_id, art_id, dat_lief_soll, bestellart_id, wrg_id,
lieferungskuerzung_fg, diff_id, menge_lief_soll_kolli, menge_lief_ist_kolli, ek_netto_bnk_soll, ek_netto_bnk_ist,
vk_netto_lief_soll, vk_netto_lief_ist, kz_menge_lief_soll_kolli, kz_menge_lief_ist_kolli, kz_ek_netto_bnk_soll,
kz_ek_netto_bnk_ist, kz_vk_netto_lief_soll, kz_vk_netto_lief_ist) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagerort_id,
 V01.empfaenger_wup_id,
 V01.mandant_id_empfaenger,
 V01.empfaenger_nb_id,
 V01.art_id,
 V01.dat_lief_soll,
 V01.bestellart_id,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.wrg_id
  ELSE 'EUR'
  END AS wrg_id,
 V01.kuerzung_fg AS lieferungskuerzung_fg,
 V01.diff_id,
 V01.menge_lief_soll_kolli,
 V01.menge_lief_ist_kolli,
  CASE
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
  THEN V01.ek_netto_bnk_soll * V01.umrechnungskurs
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
  THEN V01.ek_netto_bnk_soll * V01.umrechnungskurs_hist
  ELSE V01.ek_netto_bnk_soll
  END AS ek_netto_bnk_soll,
  CASE
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
  THEN V01.ek_netto_bnk_ist * V01.umrechnungskurs
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
  THEN V01.ek_netto_bnk_ist * V01.umrechnungskurs_hist
  ELSE V01.ek_netto_bnk_ist
  END AS ek_netto_bnk_ist,
  CASE
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
  THEN V01.vk_netto_soll * V01.umrechnungskurs
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
  THEN V01.vk_netto_soll * V01.umrechnungskurs_hist
  ELSE V01.vk_netto_soll
  END AS vk_netto_lief_soll,
  CASE
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
  THEN V01.vk_netto_ist * V01.umrechnungskurs
  WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
  THEN V01.vk_netto_ist * V01.umrechnungskurs_hist
  ELSE V01.vk_netto_ist
  END AS vk_netto_lief_ist,
 V01.kuerz_menge_lief_soll_kolli AS kz_menge_lief_soll_kolli,
 V01.kuerz_menge_lief_ist_kolli AS kz_menge_lief_ist_kolli,
 V01.kuerz_ek_netto_bnk_soll AS kz_ek_netto_bnk_soll,
 V01.kuerz_ek_netto_bnk_ist AS kz_ek_netto_bnk_ist,
 V01.kuerz_vk_netto_soll AS kz_vk_netto_lief_soll,
 V01.kuerz_vk_netto_ist AS kz_vk_netto_lief_ist
FROM kfl_production_dbp_view.v_besch_lief_fehlmengen_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON V01.bestellart_id NOT IN ('UB2K')
WHERE V01.mandant_id <> 1
 AND V01.dat_lief_soll <= DATE '2024-02-29';