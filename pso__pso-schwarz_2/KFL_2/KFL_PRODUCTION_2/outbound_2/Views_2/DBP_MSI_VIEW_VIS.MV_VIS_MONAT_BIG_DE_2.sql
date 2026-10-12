CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_big_de_2 AS WITH RELEVANT_ARTICLES AS (SELECT A0.mandant_id
   ,
   A0.art_id,
   A0.wg_id,
   W.owg_id,
   IFNULL(T.kjmo, 190001) AS kjmo_von,
   A0.dat_von,
   A0.dat_bis
  FROM kfl_production_dbp_msi_view_vis.mv_art_wg_zu_2 AS A0
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS W ON A0.wg_id = W.wg_id
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS T ON A0.dat_von = T.dat
  WHERE W.owg_id <> 1093
   AND A0.wg_id NOT IN (981, 982, 983)) (SELECT WUP.aktuell_wup_id AS wup_id,
   big.mandant_id,
   big.art_id,
   a.wg_id,
   a.owg_id,
   big.kjmo,
   big.belastungsart_vd_id,
   big.wrg_id,
   SUM(COALESCE(big.menge, 0)) AS menge,
   SUM(COALESCE(big.vk_netto, 0)) AS vk_netto,
   SUM(COALESCE(big.vk_brutto, 0)) AS vk_brutto
  FROM (SELECT ARTBEW.wup_id,
      ARTBEW.mandant_id,
      ARTBEW.art_id,
      ZEIT.kjmo,
      4 AS belastungsart_vd_id,
      ARTBEW.wrg_id,
      SUM(ARTBEW.menge * -1) AS menge,
      SUM(ARTBEW.umsatz_netto) AS vk_netto,
      SUM(ARTBEW.umsatz_netto + ARTBEW.umsatz_mwst_betrag) AS vk_brutto
     FROM kfl_production_dbp_msi_view_vis.mv_artbew_2 AS ARTBEW_2
      INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT_2 ON ARTBEW.dat = ZEIT.dat
     WHERE ARTBEW.mandant_id = 1
      AND ZEIT.akt_mo BETWEEN -12 AND (-1)
     GROUP BY ARTBEW.wup_id,
      ARTBEW.mandant_id,
      ARTBEW.art_id,
      ZEIT.kjmo,
      ARTBEW.wrg_id
     UNION ALL
     SELECT CAST(ROUND(CAST(CASE
          WHEN LK.auftraggeber_id = ''
          THEN '0'
          ELSE LK.auftraggeber_id
          END AS FLOAT64)) AS INTEGER) AS wup_id,
      LB.mandant_id,
      LB.art_id,
      ZEIT0.kjmo,
      1 AS belastungsart_vd_id,
      'EUR' AS wrg_id,
      SUM(CASE
        WHEN LK.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2',
          'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
        THEN LB.menge_faktura_bme
        ELSE LB.menge_faktura_bme * -1
        END) AS menge,
      SUM(CASE
        WHEN LK.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2',
          'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
        THEN (LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag) / (1 + MP.mwst / 100)
        ELSE (LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag) * -1 / (1 + MP.mwst / 100)
        END) AS vk_netto,
      SUM(CASE
        WHEN LK.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2',
          'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
        THEN LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag
        ELSE (LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag) * -1
        END) AS vk_brutto
     FROM kfl_production_dbp_view.v_besch_faktura_det_2 AS LB
      INNER JOIN kfl_production_dbp_view.v_besch_faktura_2 AS LK ON LB.mandant_id = LK.mandant_id AND LB.faktura_beleg_id
        = LK.faktura_beleg_id
      INNER JOIN kfl_production_dbp_view.v_art_2 AS A ON LB.art_id = A.art_id AND LB.mandant_id = A.mandant_id
      INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS MP ON A.mwst_id = MP.mwst_id AND A.mandant_id = MP.mandant_id AND
        LK.dat_faktura BETWEEN MP.dat_von AND MP.dat_bis
      INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT0 ON ZEIT0.dat = CASE
        WHEN LK.fakturaart_id IN ('ZVLT', 'ZMWP', 'ZGLT', 'ZGWP', 'ZSLT', 'ZSMP', 'Z5LT', 'Z5MP', 'ZEWP', 'ZSWP')
        THEN LB.dat_leist_erstellung
        ELSE LB.dat_faktura
        END
     WHERE LK.fakturaart_id IN (SELECT fakturaart_id
        FROM kfl_production_dbp_view.v_rpw_fakturaarten_2)
      AND LB.mandant_id = 1
      AND ZEIT0.akt_mo BETWEEN -12 AND (-1)
     GROUP BY wup_id,
      LB.mandant_id,
      LB.art_id,
      ZEIT0.kjmo,
      wrg_id
     UNION ALL
     SELECT V01.wup_id,
      V01.mandant_id,
      V01.art_id,
      ZEIT1.kjmo,
      1 AS belastungsart_vd_id,
      'EUR' AS wrg_id,
      SUM(V01.menge_rech) AS menge,
      SUM(CASE
        WHEN V01.menge_rech = 0
        THEN 0
        ELSE V01.vk_n
        END) AS vk_netto,
      SUM(CASE
        WHEN V01.menge_rech = 0
        THEN 0
        ELSE V01.vk_n * (100 + V03.mwst) / 100
        END) AS vk_brutto
     FROM kfl_production_dbp_view.v_bsch_rech_det_2 AS V01
      INNER JOIN kfl_production_dbp_view.v_art_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
      INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS V03 ON V02.mwst_id = V03.mwst_id AND V02.mandant_id = V03.mandant_id
          AND V01.dat BETWEEN V03.dat_von AND V03.dat_bis
      INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT1 ON V01.dat = ZEIT1.dat
     WHERE V01.mandant_id = 1
      AND ZEIT1.akt_mo BETWEEN -12 AND (-1)
     GROUP BY V01.wup_id,
      V01.mandant_id,
      V01.art_id,
      ZEIT1.kjmo,
      wrg_id
     UNION ALL
     SELECT V010.wup_id,
      V010.mandant_id,
      V010.art_id,
      ZEIT2.kjmo,
      1 AS belastungsart_vd_id,
      'EUR' AS wrg_id,
      SUM(V010.menge_erf) AS menge,
      SUM(CASE
         WHEN V010.betrag_verkauf = 0
         THEN V010.betrag_verkauf_ist
         ELSE V010.betrag_verkauf
         END / (1 + V030.mwst / 100)) AS vk_netto,
      SUM(CASE
        WHEN V010.betrag_verkauf = 0
        THEN V010.betrag_verkauf_ist
        ELSE V010.betrag_verkauf
        END) AS vk_brutto
     FROM kfl_production_dbp_view.v_lagerbew_det_2 AS V010
      INNER JOIN kfl_production_dbp_view.v_art_2 AS V020 ON V010.mandant_id = V020.mandant_id AND V010.art_id = V020.art_id
        
      INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS V030 ON V020.mwst_id = V030.mwst_id AND V020.mandant_id = V030.mandant_id
          AND V010.dat_buch BETWEEN V030.dat_von AND V030.dat_bis
      INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT2 ON V010.dat_buch = ZEIT2.dat
     WHERE V010.wup_id <> 9201
      AND (V010.lager_bewart_id IN ('317', '318', '319', '320') AND COALESCE(V010.empfaenger_id, 0) <> 9201 AND NOT
          COALESCE(V010.empfaenger_id, 0) BETWEEN 6900 AND 6914 OR V010.empfaenger_id <> 9201 AND V010.lager_bewart_id
           NOT IN ('317', '318', '319', '320') AND NOT V010.empfaenger_id BETWEEN 6900 AND 6914)
      AND V010.lager_bewart_id IN ('101', '102', '161', '162', '301', '302', '303', '304', '317', '318', '319', '320',
        '901', '902', '905', '906', '907', '908', '912', '915', '916')
      AND V010.mandant_id = 1
      AND ZEIT2.akt_mo BETWEEN -12 AND (-1)
      AND NOT V010.wup_id BETWEEN 6900 AND 6914
     GROUP BY V010.wup_id,
      V010.mandant_id,
      V010.art_id,
      ZEIT2.kjmo,
      wrg_id
     UNION ALL
     SELECT BR.wup_id,
      BRDK.mandant_id,
       BRDK.wg_id * -1000 AS art_id,
      ZEIT3.kjmo,
      1 AS belastungsart_vd_id,
      'EUR' AS wrg_id,
      SUM(BRDK.menge) AS menge,
      SUM(CASE
        WHEN CAST(BRDK.row_grund_id AS FLOAT64) = 158
        THEN BRDK.betrag_beleg * 1.23
        WHEN CAST(BRDK.row_grund_id AS FLOAT64) = 159
        THEN BRDK.betrag_beleg * 0.8
        ELSE BRDK.betrag_beleg
        END) AS vk_netto,
      SUM(CASE
        WHEN CAST(BRDK.row_grund_id AS FLOAT64) = 158
        THEN BRDK.betrag_beleg * 1.23 * (1 + V031.mwst / 100)
        WHEN CAST(BRDK.row_grund_id AS FLOAT64) = 159
        THEN BRDK.betrag_beleg * 0.8 * (1 + V031.mwst / 100)
        ELSE BRDK.betrag_beleg
        END) AS vk_brutto
     FROM kfl_production_dbp_view.v_besch_rech_det_kont_2 AS BRDK
      INNER JOIN kfl_production_dbp_view.v_besch_rech_2 AS BR ON BRDK.mandant_id = BR.mandant_id AND BRDK.rech_beleg_id =
         BR.rech_beleg_id AND BRDK.gj = BR.gj
      INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS V031 ON CASE
          WHEN BRDK.sap_mwst_id IN ('76', '78', '95', '96')
          THEN 1
          WHEN BRDK.sap_mwst_id IN ('53', '55', '94', '97')
          THEN 2
          WHEN BRDK.sap_mwst_id IN ('71', '74')
          THEN 3
          WHEN BRDK.sap_mwst_id IN ('99')
          THEN 9
          ELSE 1
          END = V031.mwst_id AND BRDK.mandant_id = V031.mandant_id AND BR.dat_buch BETWEEN V031.dat_von AND V031.dat_bis
        
      INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT3 ON BR.dat_leist_erstellung = ZEIT3.dat
     WHERE BRDK.mandant_id = 1
      AND ZEIT3.akt_mo BETWEEN -12 AND (-1)
      AND RIGHT(BRDK.sachkonto_id, 6) IN ('314602', '314603', '314604', '314605', '314606', '314607', '314608', '314609'
        , '314610', '314611', '314612', '314616', '314617', '314621', '314622', '314623', '314624', '316001', '316002',
        '316003', '316004', '316005', '316006', '316007', '316008', '316009', '316010', '316011', '316012', '316013',
        '316014', '312006', '312007', '312008', '312009', '312010', '312011', '312012', '312013', '312014', '312015',
        '312016', '312017', '312018', '312019', '312020')
      AND BRDK.row_grund_id IN ('100', '101', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112',
        '114', '116', '119', '120', '142', '158', '159', '160', '161', '199')
     GROUP BY BR.wup_id,
      BRDK.mandant_id,
      art_id,
      ZEIT3.kjmo,
      wrg_id
     UNION ALL
     SELECT MA.wup_id,
      MA.mandant_id,
      MA.art_id,
      ZEIT4.kjmo,
       CASE
       WHEN MA.abschriftart_id IN (8, 99, 190)
       THEN 3
       ELSE 2
       END AS belastungsart_vd_id,
      MA.wrg_id,
      SUM(CASE
        WHEN MA.abschriftart_id >= 100
        THEN CASE
         WHEN MA.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' OR MA.abschrift_menge_einh_id = 'G'
         THEN CASE
          WHEN MA.abschriftbetrag_netto > 0
          THEN MA.menge_abschrift / 1000.000000 * -1
          WHEN MA.abschriftbetrag_netto < 0
          THEN MA.menge_abschrift / 1000.000000
          ELSE 0
          END
         WHEN MA.abschriftbetrag_netto > 0
         THEN MA.menge_abschrift * -1
         WHEN MA.abschriftbetrag_netto < 0
         THEN MA.menge_abschrift
         ELSE 0
         END
        ELSE 0
        END) AS menge,
      SUM(MA.abschriftbetrag_netto * -1) AS vk_netto,
      SUM(MA.abschriftbetrag_brutto * -1) AS vk_brutto
     FROM kfl_production_dbp_view.v_marktabschriften_2 AS MA
      INNER JOIN (SELECT art_id,
        gewart_id
       FROM kfl_production_dbp_view.v_art_2
       WHERE mandant_id = 1) AS art_2 ON MA.art_id = art.art_id
      INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT4 ON MA.dat = ZEIT4.dat
      INNER JOIN kfl_production_dbp_view.v_abschriftart_int_zu_2 AS ABSCH ON MA.mandant_id = ABSCH.mandant_id AND MA.abschriftart_id
         = ABSCH.abschriftart_id
     WHERE MA.mandant_id = 1
      AND ZEIT4.akt_mo BETWEEN -12 AND (-1)
      AND ABSCH.abschriftart_int_id NOT IN (99)
     GROUP BY MA.wup_id,
      MA.mandant_id,
      MA.art_id,
      ZEIT4.kjmo,
      belastungsart_vd_id,
      MA.wrg_id) AS big
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON big.mandant_id = WUP.mandant_id AND big.wup_id = WUP.wup_id
   INNER JOIN RELEVANT_ARTICLES AS a ON big.mandant_id = a.mandant_id AND big.art_id = a.art_id
  GROUP BY wup_id,
   big.mandant_id,
   big.art_id,
   a.wg_id,
   a.owg_id,
   big.kjmo,
   big.belastungsart_vd_id,
   big.wrg_id);