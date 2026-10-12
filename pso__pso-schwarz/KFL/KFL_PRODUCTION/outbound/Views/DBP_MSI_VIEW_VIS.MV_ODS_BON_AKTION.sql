
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_aktion (mandant_id, nb_id, wup_id, aktion_kjwo_von,
aktion_id, aktion_thema_id, aktion_von, aktion_bis, art_mutter_wb_id, art_mutter_wb_nr, art_mutter_wb_bez,
art_mutter_wb_fg, art_id, art_nr, art_bez, art_display_id, art_basismenge_einh_id, art_verpart_id, bon_dat, einh_id,
menge, umsatz_brutto, umsatz_netto, start_bon_zeile, bon_erster_verkauf, bon_letzter_verkauf) AS SELECT sub01.mandant_id
 ,
 sub01.nb_id,
 sub01.wup_id,
 sub01.kjwo_von AS aktion_kjwo_von,
 sub01.aktion_id,
 sub01.aktion_thema_id,
 MIN(sub01.dat_von) OVER (PARTITION BY CAST(sub01.mandant_id AS STRING), CAST(sub01.nb_id AS STRING), CAST(sub01.wup_id AS STRING)
    , sub01.aktion_id, CAST(sub01.art_id AS STRING) ORDER BY sub01.mandant_id IS NULL, sub01.mandant_id, sub01.nb_id
    IS NULL, sub01.nb_id, sub01.wup_id IS NULL, sub01.wup_id, sub01.aktion_id IS NULL, sub01.aktion_id, sub01.art_id
    IS NULL, sub01.art_id, ods.start_bon_zeile IS NULL, ods.start_bon_zeile RANGE BETWEEN UNBOUNDED PRECEDING AND
  CURRENT ROW) AS aktion_von,
 MAX(sub01.dat_bis) OVER (PARTITION BY CAST(sub01.mandant_id AS STRING), CAST(sub01.nb_id AS STRING), CAST(sub01.wup_id AS STRING)
    , sub01.aktion_id, CAST(sub01.art_id AS STRING) ORDER BY sub01.mandant_id IS NULL, sub01.mandant_id, sub01.nb_id
    IS NULL, sub01.nb_id, sub01.wup_id IS NULL, sub01.wup_id, sub01.aktion_id IS NULL, sub01.aktion_id, sub01.art_id
    IS NULL, sub01.art_id, ods.start_bon_zeile IS NULL, ods.start_bon_zeile RANGE BETWEEN UNBOUNDED PRECEDING AND
  CURRENT ROW) AS aktion_bis,
 MWB.art_id AS art_mutter_wb_id,
 TRIM(CAST(CASE
    WHEN sub01.mandant_id = 1
    THEN MWB.art_id / 100
    ELSE MWB.art_id / 10
    END AS STRING FORMAT '00000000')) AS art_mutter_wb_nr,
 MSZ.art_bez AS art_mutter_wb_bez,
 CAST(CASE
   WHEN MWB.art_id = sub01.art_id
   THEN 0
   ELSE 1
   END AS BIGNUMERIC) AS art_mutter_wb_fg,
 ART.art_id,
 TRIM(CAST(CASE
    WHEN sub01.mandant_id = 1
    THEN ART.art_id / 100
    ELSE ART.art_id / 10
    END AS STRING FORMAT '00000000')) AS art_nr,
 ASZ.art_bez,
 ART.display_id AS art_display_id,
 ART.basismenge_einh_id AS art_basismenge_einh_id,
 COALESCE(ART.verpart_id, ' ') AS art_verpart_id,
 ods.bon_dat,
 ods.einh_id,
 ods.menge,
 ods.umsatz_brutto,
 ods.umsatz_netto,
 ods.start_bon_zeile,
 MIN(ods.start_bon_zeile) OVER (PARTITION BY CAST(sub01.mandant_id AS STRING), CAST(sub01.nb_id AS STRING), CAST(sub01.wup_id AS STRING)
    , sub01.aktion_id, CAST(sub01.art_id AS STRING) ORDER BY sub01.mandant_id IS NULL, sub01.mandant_id, sub01.nb_id
    IS NULL, sub01.nb_id, sub01.wup_id IS NULL, sub01.wup_id, sub01.aktion_id IS NULL, sub01.aktion_id, sub01.art_id
    IS NULL, sub01.art_id, ods.start_bon_zeile IS NULL, ods.start_bon_zeile RANGE BETWEEN UNBOUNDED PRECEDING AND
  CURRENT ROW) AS bon_erster_verkauf,
 MAX(ods.start_bon_zeile) OVER (PARTITION BY CAST(sub01.mandant_id AS STRING), CAST(sub01.nb_id AS STRING), CAST(sub01.wup_id AS STRING)
    , sub01.aktion_id, CAST(sub01.art_id AS STRING) ORDER BY sub01.mandant_id IS NULL, sub01.mandant_id, sub01.nb_id
    IS NULL, sub01.nb_id, sub01.wup_id IS NULL, sub01.wup_id, sub01.aktion_id IS NULL, sub01.aktion_id, sub01.art_id
    IS NULL, sub01.art_id, ods.start_bon_zeile IS NULL, ods.start_bon_zeile RANGE BETWEEN UNBOUNDED PRECEDING AND
  CURRENT ROW) AS bon_letzter_verkauf
FROM (SELECT AAW.mandant_id,
   AAW.aktion_id,
   AAW.art_id,
   AAW.wup_id,
   AAW.nb_id,
   AAW.vk_aktion_brutto,
   AAW.bezugsweg_id,
   AAW.wrg_id,
   AAW.grund_sperrung,
   AAW.dat_sperrung,
   AAW.aktion_thema_id,
   AAW.vk_vor_aktion_brutto,
   AAW.dat_preisaktiviert,
   AAW.bewart_id,
   AA.aktionsart_id,
   AA.werbe_kat_id,
   AA.dat_von,
   AA.dat_bis,
   AA.preisaktiviert_fg,
   AA.kjwo_von
  FROM kfl_production_dbp_view.v_aktion_art_wup_zu AS AAW
   INNER JOIN kfl_production_dbp_view.v_aktion AS AA ON AAW.mandant_id = AA.mandant_id AND AAW.aktion_id = AA.aktion_id
    AND CURRENT_DATE BETWEEN AA.dat_von AND AA.dat_bis
  WHERE AAW.dat_sperrung IS NULL) AS sub01
 INNER JOIN kfl_production_dbp_view.v_art AS ART ON sub01.mandant_id = ART.mandant_id AND sub01.art_id = ART.art_id AND
   ART.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS ASZ ON sub01.mandant_id = ASZ.mandant_id AND sub01.art_id = ASZ.art_id
     AND ASZ.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_art AS MWB ON ART.mandant_id = MWB.mandant_id AND MWB.art_id = COALESCE(ART.mutter_wb_id
     , ART.art_id) AND MWB.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS MSZ ON ART.mandant_id = MSZ.mandant_id AND MSZ.art_id = COALESCE(ART
     .mutter_wb_id, ART.art_id) AND MSZ.spr_id = 22
 LEFT JOIN (SELECT BK.bon_id,
   BK.bon_dat,
   BK.wup_id,
   BK.mandant_id,
   BK.bon_nr,
   BK.kasse_nr,
   BK.kassierer_nr,
   BK.kunde_fg,
   BK.bon_beginn,
   BK.bon_ende,
   BK.umsatz_mwst AS bon_umsatz_mwst,
   BK.umsatz_brutto AS bon_umsatz_brutto,
   BK.bon_booking,
   BK.dat_booking,
   BK.turnover_fg,
   BK.wrg_id,
   BK.kasse_typ_id,
   BK.reactivated_fg,
   BK.personal_id,
   BK.betrag_personal_rabatt,
   BK.kpos_kasse_typ,
   BK.wagen_nr,
   BV.bon_zeile,
   BV.kl_art_id,
   BV.ean_kasse,
   BV.wg_id,
   BV.menge,
   BV.einh_id,
   BV.umsatz_brutto,
     BV.umsatz_brutto * 100 / (100 + BM.mwst) AS umsatz_netto,
   BM.mwst,
   BV.erfassung_id,
   BV.aktion_id,
   BV.talon_id,
   BV.start_bon_zeile,
   BV.bon_nr_extern,
   BV.kpos_erfassung_id,
   BV.umsatz_brutto_norm,
   BV.vk_brutto_obb,
   BV.bon_vorgang_id
  FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS BK
   INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf AS BV ON BK.mandant_id = BV.mandant_id AND BK.wup_id = BV.wup_id
       AND BK.bon_id = BV.bon_id
   INNER JOIN kfl_production_dbp_view.v_mwst_per AS BM ON BV.mandant_id = BM.mandant_id AND BV.mwst_id = BM.mwst_id AND
     BV.bon_dat BETWEEN BM.dat_von AND BM.dat_bis
  WHERE BV.wg_id <> 961
   AND BK.bon_dat = CURRENT_DATE
   AND (BK.bon_id, CAST(BK.wup_id AS BIGNUMERIC), CAST(BK.mandant_id AS BIGNUMERIC)) NOT IN (SELECT (bon_id, wup_id, mandant_id)
     FROM kfl_production_dbp_v_ods.v_ods_bon_storno)) AS ods ON sub01.mandant_id = ods.mandant_id AND sub01.wup_id = ods
    .wup_id AND ods.kl_art_id = sub01.art_id / 100;