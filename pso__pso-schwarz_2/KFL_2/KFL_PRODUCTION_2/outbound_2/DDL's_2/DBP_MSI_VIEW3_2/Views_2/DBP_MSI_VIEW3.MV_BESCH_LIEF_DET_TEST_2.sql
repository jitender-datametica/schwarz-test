CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_besch_lief_det_test_2 (aktions_pos_kz, annahmeverweigerung_id,
art_id, besch_palette_fg, brutto_gew, dat_aenderung, dat_haltbarkeit, diff_id, lagerort_id, lief_beleg_id,
lief_beleg_pos_id, mandant_id, menge_lief_ist_bme, menge_lief_soll_kolli, menge_lief_palette, nb_id, system_id,
verk_menge_einh_id, best_beleg_id, best_beleg_pos_id, wup_id, dat_lief_soll, menge_lief_soll_bme, menge_lief_ist_kolli,
menge_lief_ist_lme, betrag_lief_ist, betrag_lief_soll, betrag_lief_fehl, menge_lief_fehl_bme, menge_lief_fehl_kolli,
wrg_id, menge_kolli, wrg_typ_id, vk_netto_lief_soll, vk_netto_lief_ist, vk_netto_lief_fehl, letzter_we_markt_lief,
bestellart_id, kj, mandant_id_kunde, kunde_id, nb_id_kunde, lief_pal_typ_id) AS SELECT V01.aktions_pos_kz,
 V01.annahmeverweigerung_id,
 V01.art_id,
 V01.besch_palette_fg,
 V01.bruttogew AS brutto_gew,
 V01.dat_aenderung,
 V01.dat_haltbarkeit,
 V01.diff_id,
 V01.lagerort_id,
 V01.lief_beleg_id,
 V01.lief_beleg_pos_id,
 V01.mandant_id,
 V01.menge_lief_ist_bme,
 V01.menge_lief_soll_kolli,
 V01.menge_lief_palette,
 V01.nb_id,
 V01.system_id,
 V01.verk_menge_einh_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.wup_id,
 V01.dat_lief_soll,
 V01.menge_lief_soll_bme,
 V01.menge_lief_ist_kolli,
 V01.menge_lief_ist_lme,
  CASE
  WHEN V01.wrg_typ_id = 0
  THEN V01.betrag_lief_ist * V01.umrechnungskurs * V04.ek_anzeige_fg
  ELSE V01.betrag_lief_ist * V04.ek_anzeige_fg
  END AS betrag_lief_ist,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE CASE
   WHEN V01.wrg_typ_id = 0
   THEN V01.betrag_lief_soll * V01.umrechnungskurs * V04.ek_anzeige_fg
   ELSE V01.betrag_lief_soll * V04.ek_anzeige_fg
   END
  END AS betrag_lief_soll,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE CASE
   WHEN V01.wrg_typ_id = 0
   THEN (V01.betrag_lief_soll - V01.betrag_lief_ist) * V01.umrechnungskurs * V04.ek_anzeige_fg
   ELSE (V01.betrag_lief_soll - V01.betrag_lief_ist) * V04.ek_anzeige_fg
   END
  END AS betrag_lief_fehl,
 V01.menge_lief_fehl_bme,
 V01.menge_lief_fehl_kolli,
 V01.wrg_id,
 V01.menge_kolli,
 V01.wrg_typ_id,
 V01.vk_netto_lief_soll,
 V01.vk_netto_lief_ist,
 V01.vk_netto_lief_fehl,
 V01.letzter_we_markt_lief,
 V01.bestellart_id,
 V01.kj,
 V01.mandant_id_kunde,
 V01.kunde_id,
 V01.nb_id_kunde,
 V01.lief_pal_typ_id
FROM kfl_production_dbp_msi_view3.tbl_mv_besch_lief_det_test_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V06 ON V01.wrg_typ_id = V06.wrg_typ_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_2 AS V04 ON TRUE;