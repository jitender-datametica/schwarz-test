CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_besch_lief_det (aktions_pos_kz, annahmeverweigerung_id,
art_id, besch_palette_fg, bruttogew, dat_aenderung, dat_haltbarkeit, diff_id, lagerort_id, lief_beleg_id,
lief_beleg_pos_id, mandant_id, menge_lief_ist_bme, menge_lief_soll_kolli, menge_lief_palette, nb_id, system_id,
verk_menge_einh_id, best_beleg_id, best_beleg_pos_id, wup_id, dat_lief_soll, menge_lief_soll_bme, menge_lief_ist_kolli,
menge_lief_ist_lme, menge_lief_fehl_bme, menge_lief_fehl_kolli, wrg_id, menge_kolli, wrg_typ_id, vk_netto_lief_soll,
vk_netto_lief_ist, vk_netto_lief_fehl, letzter_we_markt_lief, bestellart_id, kj, mandant_id_kunde, kunde_id, nb_id_kunde
, lief_pal_typ_id, betrag_lief_ist, betrag_lief_soll, umrechnungskurs, auslieferungsgruppe_id, lagernummer_id,
lief_typ_id, werbeware_id, gp_id, versandstelle_id, vertr_beleg_typ_id, wg_verkett_fg, wg_verkett_hier_id,
wg_verkett_lief) AS SELECT V01.aktions_pos_kz,
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
 V04.aktuell_wup_id AS kunde_id,
 0 AS nb_id_kunde,
  CASE
  WHEN V011.lief_pal_typ_id <> '6'
  THEN CAST(V011.lief_pal_typ_id AS STRING)
  WHEN V011.lief_pal_typ_id = '6' AND V01.mandant_id = 1 AND V01.lief_beleg_pos_id = 10 OR V01.mandant_id <> 1 AND V01.lief_beleg_pos_id
      = 1
  THEN '61'
  WHEN V011.lief_pal_typ_id = '6' AND V01.mandant_id = 1 AND V01.lief_beleg_pos_id <> 10 OR V01.mandant_id <> 1 AND V01
     .lief_beleg_pos_id <> 1
  THEN '64'
  ELSE NULL
  END AS lief_pal_typ_id,
 V01.betrag_lief_ist,
 V01.betrag_lief_soll,
 V02.umrechnungskurs,
 COALESCE(ART_AUSL.auslieferungsgruppe_id, COALESCE(WG_AUSL.auslieferungsgruppe_id, '-1')) AS auslieferungsgruppe_id,
 V011.lagernummer_id,
 V011.lief_typ_id,
 V011.werbeware_id,
 V011.gp_id,
 V011.versandstelle_id,
 V011.vertr_beleg_typ_id,
 V011.wg_verkett_fg,
  CASE
  WHEN V011.wg_verkett_fg = 1
  THEN CAST(WGVER.wg_verkett_hier_id AS STRING)
  ELSE ''
  END AS wg_verkett_hier_id,
 V011.wg_verkett_lief
FROM kfl_production_dbp_view.v_besch_lief AS V011
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per AS WGVER ON V011.wup_id = WGVER.wup_id AND V011.mandant_id
      = WGVER.mandant_id AND V011.wg_verkett_lief = WGVER.wg_verkett_id AND V011.dat_lief_soll BETWEEN WGVER.dat_von AND
   WGVER.dat_bis
 INNER JOIN kfl_production_dbp_view.v_tag AS T ON V011.dat_lief_soll = T.dat AND T.akt_kj >= -2
 INNER JOIN kfl_production_dbp_view.v_besch_lief_det AS V01 ON V011.mandant_id = V01.mandant_id AND V011.lief_beleg_id =
     V01.lief_beleg_id AND V011.kj = V01.kj AND T.dat = V01.dat_lief_soll
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per AS MAW1 ON V01.mandant_id = MAW1.mandant_id AND V01.art_id
    = MAW1.art_id AND V01.dat_lief_soll BETWEEN MAW1.dat_von AND MAW1.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS WG ON V01.mandant_id = WG.mandant_id AND V01.art_id = WG.art_id
   AND V01.dat_lief_soll BETWEEN WG.dat_von AND WG.dat_bis AND WG.arthiertyp_id = 2
 LEFT JOIN kfl_production_dbp_view.v_wup AS V04 ON V011.mandant_id_kunde = V04.mandant_id AND V04.wup_id = SAFE_CAST(ROUND(CAST(V011.kunde_id AS FLOAT64)
     ) AS INTEGER)
 LEFT JOIN kfl_production_dbp_view.v_art_auslieferungsgruppe_per AS ART_AUSL ON V01.mandant_id = ART_AUSL.mandant_id AND
    V01.art_id = ART_AUSL.art_id AND V01.dat_lief_soll BETWEEN ART_AUSL.dat_von AND ART_AUSL.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wg_auslieferungsgruppe_per AS WG_AUSL ON V01.mandant_id = WG_AUSL.mandant_id AND WG
     .wg_id = WG_AUSL.wg_id AND CASE
     WHEN WG_AUSL.sortimentslistenart_id = ''
     THEN ''
     ELSE MAW1.sortimentslistenart_id
     END = WG_AUSL.sortimentslistenart_id AND V01.dat_lief_soll BETWEEN WG_AUSL.dat_von AND WG_AUSL.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_l_lagernummer AS L_LAGN ON V011.mandant_id = L_LAGN.mandant_id AND V011.lagernummer_id
    = L_LAGN.lagernummer_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   lagernummer_id,
   MIN(dat) AS dat
  FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat
  GROUP BY mandant_id,
   lagernummer_id,
   wup_id,
   nb_id) AS t1 ON V011.mandant_id = t1.mandant_id AND L_LAGN.wup_id = t1.wup_id AND L_LAGN.nb_id = t1.nb_id AND V011.lagernummer_id
    = t1.lagernummer_id
WHERE t1.mandant_id IS NULL
 OR V011.dat_lief_soll < t1.dat;