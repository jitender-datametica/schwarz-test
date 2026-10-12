CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_besch_lief_det_test_2 (aktions_pos_kz, annahmeverweigerung_id,
art_id, besch_palette_fg, bruttogew, dat_aenderung, dat_haltbarkeit, diff_id, lagerort_id, lief_beleg_id,
lief_beleg_pos_id, mandant_id, menge_lief_ist_bme, menge_lief_soll_kolli, menge_lief_palette, nb_id, system_id,
verk_menge_einh_id, best_beleg_id, best_beleg_pos_id, wup_id, dat_lief_soll, menge_lief_soll_bme, menge_lief_ist_kolli,
menge_lief_ist_lme, menge_lief_fehl_bme, menge_lief_fehl_kolli, wrg_id, menge_kolli, wrg_typ_id, vk_netto_lief_soll,
vk_netto_lief_ist, vk_netto_lief_fehl, letzter_we_markt_lief, bestellart_id, kj, mandant_id_kunde, kunde_id, nb_id_kunde
, lief_pal_typ_id, betrag_lief_ist, betrag_lief_soll, umrechnungskurs) AS SELECT V01.aktions_pos_kz,
 V01.annahmeverweigerung_id,
 V01.art_id,
 V01.besch_palette_fg,
 V01.bruttogew,
 V01.dat_aenderung,
 V01.dat_haltbarkeit,
 V01.diff_id,
 V01.lagerort_id,
 V01.lief_beleg_id,
 V01.lief_beleg_pos_id,
 V01.mandant_id,
 V01.menge_lief_ist_bme,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_kolli
  END AS menge_lief_soll_kolli,
 V01.menge_lief_palette,
 V01.nb_id,
 V01.system_id,
 V01.verk_menge_einh_id,
  CASE
  WHEN V01.best_beleg_id <> 0
  THEN V01.best_beleg_id
  ELSE V01.vorlage_beleg_id
  END AS best_beleg_id,
 V01.vorlage_beleg_pos_id AS best_beleg_pos_id,
 V01.wup_id,
 V01.dat_lief_soll,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_bme
  END AS menge_lief_soll_bme,
 V01.menge_lief_ist_kolli,
 V01.menge_lief_ist_lme,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_bme - V01.menge_lief_ist_bme
  END AS menge_lief_fehl_bme,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_kolli - V01.menge_lief_ist_kolli
  END AS menge_lief_fehl_kolli,
 V03.wrg_id,
 V01.menge_kolli,
 V03.wrg_typ_id,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lief_soll * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_soll
  END AS vk_netto_lief_soll,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lief_ist * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_ist
  END AS vk_netto_lief_ist,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN (V01.vk_netto_lief_soll - V01.vk_netto_lief_ist) * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_soll - V01.vk_netto_lief_ist
  END AS vk_netto_lief_fehl,
 DATE_SUB(V01.dat_haltbarkeit, INTERVAL CAST(ROUND(V05.mhd_zeitraum * V05.lager_prozent / 100 + 0.5) AS INTEGER) DAY)
 AS letzter_we_markt_lief,
 V01.bestellart_id,
 V01.kj,
 V011.mandant_id_kunde,
  CASE
  WHEN SAFE_CAST(ROUND(CAST(V011.kunde_id AS FLOAT64)) AS INTEGER) = 0
  THEN NULL
  ELSE SAFE_CAST(ROUND(CAST(V011.kunde_id AS FLOAT64)) AS INTEGER)
  END AS kunde_id,
 0 AS nb_id_kunde,
  CASE
  WHEN ROUND(SAFE_CAST(V011.lief_pal_typ_id AS BIGNUMERIC), 0) <> 6
  THEN V011.lief_pal_typ_id
  -- WHEN try_to_number(v011.lief_pal_typ_id) = 6 and v01.mandant_id = 1 and v01.lief_beleg_pos_id = 10 or v01.mandant_id <> 1 and v01.lief_beleg_pos_id = 1 THEN 61

  -- WHEN try_to_number(v011.lief_pal_typ_id) = 6 and v01.mandant_id = 1 and v01.lief_beleg_pos_id <> 10 or v01.mandant_id <> 1 and v01.lief_beleg_pos_id <> 1 THEN 64

  ELSE NULL
  END AS lief_pal_typ_id,
 V01.betrag_lief_ist,
 V01.betrag_lief_soll,
 V02.umrechnungskurs
FROM kfl_production_dbp_view.v_besch_lief_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_lief_2 AS V011 ON V01.mandant_id = V011.mandant_id AND V01.lief_beleg_id =
     V011.lief_beleg_id AND V01.kj = V011.kj AND V01.dat_lief_soll = V011.dat_lief_soll
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs_2 AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id
WHERE EXTRACT(YEAR FROM V01.dat_lief_soll) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;