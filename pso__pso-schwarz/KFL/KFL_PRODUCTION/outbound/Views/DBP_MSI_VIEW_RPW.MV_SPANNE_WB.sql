CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_spanne_wb (dat, beleg_wb_id, beleg_wb_pos_id, mandant_id,
system_id, abs_id, rcv_id, art_id, bew_art_wb_id, vk_brutto, ek_netto, mwst, mwst_id, herkunft, menge) AS SELECT BF.dat_lagerbew_ist
  AS dat_,
 BFD.lief_beleg_id AS beleg_wb_id,
 BFD.lief_beleg_pos_id AS beleg_wb_pos_id,
 BFD.mandant_id,
 7 AS system_id,
  CASE
  WHEN test.merker = 1
  THEN BFD.wup_id
  ELSE ROUND(CAST(BF.auftraggeber_id AS BIGNUMERIC), 0)
  END AS abs_id,
  CASE
  WHEN test.merker = 1
  THEN ROUND(CAST(BF.auftraggeber_id AS BIGNUMERIC), 0)
  ELSE BFD.wup_id
  END AS rcv_id,
 BFD.art_id,
 BF.lief_typ_id AS bew_art_wb_id,
 ROUND(CAST(CASE
    WHEN test.merker = 1
    THEN COALESCE(ZEKP.ek_netto * ZEKP.komponentenmenge, ZEKP_GP.ek_netto * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme
    ELSE COALESCE(ZEKP.ek_netto * ZEKP.komponentenmenge, ZEKP_GP.ek_netto * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme * - 1
    END AS NUMERIC), 3) AS ek_netto,
 ROUND(CAST(CASE
    WHEN test.merker = 1
    THEN COALESCE(ZEKP.ek_netto_bnk * ZEKP.komponentenmenge, ZEKP_GP.ek_netto_bnk * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme
    ELSE COALESCE(ZEKP.ek_netto_bnk * ZEKP.komponentenmenge, ZEKP_GP.ek_netto_bnk * ZEKP_GP.komponentenmenge) * BFD.menge_lief_ist_lme * - 1
    END AS NUMERIC), 3) AS ek_netto_bnk,
 MP.mwst,
 MP.mwst_id,
 'Umlagerung VZ => VZ oder Lieferant => Markt                            ' AS herkunft,
  CASE
  WHEN test.merker = 1
  THEN BFD.menge_lief_ist_lme
  ELSE BFD.menge_lief_ist_lme * - 1.0
  END AS menge
FROM kfl_production_dbp_view.v_besch_lief_det AS BFD
 INNER JOIN (SELECT 1 AS merker
   FROM kfl_production_dbp_msi_view_rpw.mv_spr
   WHERE spr_id IN (22)
   UNION ALL
   SELECT 2 AS merker
   FROM kfl_production_dbp_msi_view_rpw.mv_spr
   WHERE spr_id IN (22)) AS test ON TRUE
 INNER JOIN kfl_production_dbp_view.v_besch_lief AS BF ON BFD.lief_beleg_id = BF.lief_beleg_id AND BFD.mandant_id = BF.mandant_id
      AND BFD.dat_lief_soll = BF.dat_lief_soll AND BF.lief_typ_id = 'YU'
 INNER JOIN kfl_production_dbp_view.v_art AS A ON BFD.art_id = A.art_id AND BFD.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS MP ON A.mwst_id = MP.mwst_id AND A.mandant_id = MP.mandant_id AND BF.dat_lagerbew_ist
   BETWEEN MP.dat_von AND MP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per AS AGZ ON BFD.art_id = AGZ.art_id AND BFD.mandant_id = AGZ.mandant_id
     AND BF.dat_lief_soll BETWEEN AGZ.dat_von AND AGZ.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS ZEKP ON BFD.art_id = ZEKP.art_id AND BFD.mandant_id = ZEKP.mandant_id
        AND AGZ.gp_id = ZEKP.gp_id AND CASE
      WHEN BFD.nb_id = - 111
      THEN BFD.wup_id
      ELSE CAST(- 1 AS BIGNUMERIC)
      END = ZEKP.wup_id AND CASE
     WHEN BFD.nb_id = - 111
     THEN BFD.nb_id
     ELSE CAST(- 1 AS BIGNUMERIC)
     END = COALESCE(ZEKP.nb_id, - 1) AND BF.dat_lagerbew_ist BETWEEN ZEKP.dat_von AND ZEKP.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS ZEKP_GP ON BFD.art_id = ZEKP_GP.art_id AND BFD.mandant_id =
       ZEKP_GP.mandant_id AND ZEKP_GP.gp_id <> AGZ.gp_id AND CASE
      WHEN BFD.nb_id = - 111
      THEN BFD.wup_id
      ELSE CAST(- 1 AS BIGNUMERIC)
      END = ZEKP_GP.wup_id AND CASE
     WHEN BFD.nb_id = - 111
     THEN BFD.nb_id
     ELSE CAST(- 1 AS BIGNUMERIC)
     END = COALESCE(ZEKP_GP.nb_id, - 1) AND BF.dat_lagerbew_ist BETWEEN ZEKP_GP.dat_von AND ZEKP_GP.dat_bis
WHERE BFD.mandant_id = 1
 AND BFD.nb_id <> 99
UNION ALL
SELECT LB.dat_buch AS dat_,
 COALESCE(brd.rech_beleg_id, LB.lagerbew_beleg_id) AS beleg_wb_id,
 COALESCE(brd.rech_beleg_pos_id, LB.lagerbew_beleg_pos_id) AS beleg_wb_pos_id,
 LB.mandant_id,
 7 AS system_id,
  CASE
  WHEN LB.lager_bewart_id IN ('303', '304', '301', '302')
  THEN LB.wup_id
  ELSE LB.gp_id
  END AS abs_id,
  CASE
  WHEN LB.lager_bewart_id IN ('303', '304', '301', '302')
  THEN LB.empfaenger_id
  ELSE LB.wup_id
  END AS rcv_id,
 LB.art_id,
 LB.lager_bewart_id AS bew_art_wb_id,
  CASE
  WHEN LB.lager_bewart_id IN ('303', '304', '301', '302')
  THEN COALESCE(brd.betrag_vk_brutto, LB.betrag_verkauf) * - 1
  ELSE COALESCE(brd.betrag_vk_brutto, LB.betrag_verkauf)
  END AS vk_brutto,
  CASE
  WHEN A.wg_art_fg = 1
  THEN CASE
   WHEN LB.lager_bewart_id IN ('303', '304', '301', '302')
   THEN LB.betrag_vk_netto * 0.90 * - 1
   ELSE COALESCE(brd.betrag_beleg, LB.betrag_belegfluss_wg_art * - 1)
   END
  ELSE CASE
   WHEN LB.lager_bewart_id IN ('303', '304', '301', '302')
   THEN COALESCE(brd.betrag_beleg, LB.betrag_lagerbew) * - 1
   ELSE COALESCE(brd.betrag_beleg, LB.betrag_lagerbew)
   END
  END AS ek_netto,
 MP.mwst,
 MP.mwst_id,
 'Dezentral Lieferant => VZ/Markt sowie Umlagerung Markt => Markt' AS herkunft,
  CASE
  WHEN LB.lager_bewart_id IN ('303', '304', '301', '302')
  THEN COALESCE(brd.best_preis_menge, LB.menge_erf) * - 1.0
  ELSE COALESCE(brd.best_preis_menge, LB.menge_lief)
  END AS menge
FROM kfl_production_dbp_msi_view_rpw.mv_lagerbew_det AS LB
 INNER JOIN kfl_production_dbp_msi_view_rpw.mv_lagerbew AS L_ ON LB.lagerbew_beleg_id = L_.lagerbew_beleg_id AND LB.kj =
     L_.kj AND LB.mandant_id = L_.mandant_id AND LB.dat_buch = L_.dat_buch
 INNER JOIN kfl_production_dbp_view.v_art AS A ON LB.art_id = A.art_id AND LB.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS MP ON A.mwst_id = MP.mwst_id AND A.mandant_id = MP.mandant_id AND LB.dat_buch
   BETWEEN MP.dat_von AND MP.dat_bis
 LEFT JOIN (SELECT BRD.system_id,
   BRD.mandant_id,
   BRD.rech_beleg_id,
   BRD.rech_beleg_pos_id,
   BRD.gj,
   BRD.best_beleg_id,
   BRD.best_beleg_pos_id,
   BRD.wbnk_fg,
   BRD.ean_id,
   BRD.gp_art_id,
   BRD.edi_pos_nr,
   BRD.betrag_mwst,
   BRD.gp_id,
   BRD.wup_id,
   BRD.nb_id,
   BRD.art_id,
   BRD.menge_rech,
   BRD.best_menge_einh_id,
   BRD.best_preis_menge,
   BRD.best_preis_menge_einh_id,
   BRD.buch_grund_int_id,
   BRD.buch_grund_ext_id,
   BRD.lagerbew_beleg_id,
   BRD.lagerbew_beleg_pos_id,
   BRD.kj,
   BRD.mengenabw_rpw_fg,
   BRD.preisabw_rpw_fg,
   BRD.menge_rechsteller,
   BRD.rechsteller_menge_einh_id,
   BRD.betrag_kondition,
   BRD.kondition_einh_id,
   BRD.kondition_menge_einh_id,
   BRD.kondition_preis_einh_id,
   BRD.preis_vk_brutto,
   BRD.betrag_vk_brutto,
   BRD.betrag_beleg,
   BRD.soll_haben_kz,
   BRD.vk_wrg_id,
   BRD.pos_manuell_erstellt_fg,
   BRD.konditionsart_id,
   BRD.wg_id,
   BRD.arthiertyp_id,
   BRD.einkaufsorganisation_id,
   BRD.betrag_korrektur_netto,
   BRD.sap_mwst_id,
   BRD.mwst,
   BRD.menge_bestand_bme,
   BRD.menge_bestand_bme_rbp,
   BRD.wert_bestand,
   BRD.wert_bestand_vp,
   BRD.wert_bestand_buchung,
   BRD.wert_bestand_buchung_vp,
   BRD.wrg_id,
   BRD.rueck_buchung_fg
  FROM kfl_production_dbp_view.v_besch_rech_det AS BRD
   INNER JOIN kfl_production_dbp_view.v_besch_rech AS BR ON BRD.rech_beleg_id = BR.rech_beleg_id AND BRD.gj = BR.gj AND
       BRD.mandant_id = BR.mandant_id AND BR.rech_beleg_storno_id IS NULL AND BR.vorgangsart_ag08_id <> 'KP') AS brd ON
     LB.lagerbew_beleg_id = brd.lagerbew_beleg_id AND LB.lagerbew_beleg_pos_id = brd.lagerbew_beleg_pos_id AND LB.kj =
    brd.kj AND LB.mandant_id = brd.mandant_id
WHERE LB.mandant_id = 1
 AND (LB.gp_id IS NULL OR LB.gp_id <= 6900 OR LB.gp_id >= 6914)
 AND LB.lager_bewart_id NOT IN ('305', '309', '310', '317', '318', '319', '320', '903', '904', '913', '914', '915',
   '916')
UNION ALL
SELECT LK.dat_faktura AS dat_,
 LB.faktura_beleg_id,
 LB.faktura_beleg_pos_id,
 LB.mandant_id,
 7 AS system_id,
 LB.wup_id,
 ROUND(SAFE_CAST(LK.auftraggeber_id AS BIGNUMERIC), 0) AS lk_auftraggeber_id,
 LB.art_id,
 LK.fakturaart_id,
  CASE
  WHEN LK.fakturaart_id IN ('L2  ', 'ZVLT', 'ZMWP', 'S2  ', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1 ', 'ZIV ', 'ZLF2',
    'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
  THEN LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag
  ELSE (LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag) * - 1
  END,
  CASE
  WHEN LK.fakturaart_id IN ('L2  ', 'ZVLT', 'ZMWP', 'S2  ', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1 ', 'ZIV ', 'ZLF2',
    'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
  THEN LB.zwsum_3_betrag
  ELSE LB.zwsum_3_betrag * - 1
  END,
 MP.mwst,
 MP.mwst_id,
 'Zentral VZ => Markt ("Faktura")' AS herkunft,
  CASE
  WHEN LK.fakturaart_id IN ('L2  ', 'ZVLT', 'ZMWP', 'S2  ', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1 ', 'ZIV ', 'ZLF2',
    'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
  THEN LB.menge_faktura_bme
  ELSE LB.menge_faktura_bme * - 1
  END AS menge
FROM kfl_production_dbp_view.v_besch_faktura_det AS LB
 INNER JOIN kfl_production_dbp_view.v_besch_faktura AS LK ON LB.mandant_id = LK.mandant_id AND LB.faktura_beleg_id = LK
    .faktura_beleg_id AND LB.dat_faktura = LK.dat_faktura
 INNER JOIN kfl_production_dbp_view.v_art AS A ON LB.art_id = A.art_id AND LB.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS MP ON A.mwst_id = MP.mwst_id AND A.mandant_id = MP.mandant_id AND LK.dat_faktura
   BETWEEN MP.dat_von AND MP.dat_bis
 INNER JOIN (SELECT DISTINCT mandant_id,
   fakturaart_id
  FROM kfl_production_dbp_view.v_rpw_fakturaarten) AS lkf ON LK.mandant_id = lkf.mandant_id AND LK.fakturaart_id = lkf.fakturaart_id
   
WHERE LB.mandant_id = 1
 AND LB.wup_id BETWEEN 6900 AND 6914;