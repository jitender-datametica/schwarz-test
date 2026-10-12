CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_marktabschriften
AS
SELECT V01.mandant_id,
 V01.wup_id,
 V01.wup_abschrift_id,
 V01.positionsnummer_id,
 V01.abschriftart_id,
 V01.nb_id,
 V01.dat,
 V01.woche_id,
  CASE
  WHEN V01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND CAST(V01.abschriftart_id AS STRING) <> '-1' AND
    V01.abschriftbetrag_netto > 0
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  WHEN V01.abschrift_menge_einh_id = 'G' AND CAST(V01.abschriftart_id AS STRING) <> '-1' AND V01.abschriftbetrag_netto >
    0
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  WHEN V01.abschriftbetrag_netto > 0
  THEN CAST(V01.menge_abschrift AS NUMERIC)
  ELSE NULL
  END AS m_absch_menge,
  CASE
  WHEN V01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND CAST(V01.abschriftart_id AS STRING) <> '-1' AND
    V01.abschriftbetrag_netto < 0
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  WHEN V01.abschrift_menge_einh_id = 'G' AND CAST(V01.abschriftart_id AS STRING) <> '-1' AND V01.abschriftbetrag_netto <
    0
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  WHEN V01.abschriftbetrag_netto < 0
  THEN CAST(V01.menge_abschrift AS NUMERIC)
  ELSE NULL
  END AS m_aufsch_menge,
 V01.art_id,
 CAST(CASE
   WHEN V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_kz_per,
 V01.lastupd_dat,
  CASE
  WHEN V01.abschriftbetrag_netto > 0
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS abschriftbetrag_netto,
  CASE
  WHEN V01.abschriftbetrag_netto < 0
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS aufschriftbetrag_netto,
  CASE
  WHEN V01.abschriftbetrag_brutto > 0
  THEN V01.abschriftbetrag_brutto
  ELSE 0
  END AS abschriftbetrag_brutto,
  CASE
  WHEN V01.abschriftbetrag_brutto < 0
  THEN V01.abschriftbetrag_brutto
  ELSE 0
  END AS aufschriftbetrag_brutto,
 COALESCE(v02.gp_id, -1) AS gp_id,
 V01.wv_kz,
 V01.wv_grund_id,
 V01.vk_brutto,
 V01.vk_aktion_brutto,
  CASE
  WHEN V01.wv_grund_id = 2 AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_sa_loyalty,
  CASE
  WHEN V01.wv_grund_id = 0 AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_sa_nicht_loyalty,
  CASE
  WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) AND V01.abschriftart_id = -1 OR V01.dat <
      DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54, 55) AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_loyalty_bby,
  CASE
  WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) AND V01.abschriftart_id = -1 OR V01.dat <
      DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58, 59) AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_nicht_loyalty_bby,
  CASE
  WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) AND V01.abschriftart_id = -1 OR V01.dat <
      DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62, 63) AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_kdn_bby,
  CASE
  WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) AND V01.abschriftart_id = -1 OR V01
      .dat < DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 67) AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_kdp_bby,
  CASE
  WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67, 76) AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_loyalty_bon_bby,
  CASE
  WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59) AND V01.abschriftart_id = -1
  THEN V01.abschriftbetrag_netto
  ELSE 0
  END AS pv_nicht_loyalty_bon_bby,
  CASE
  WHEN V01.wv_grund_id IN (60, 61, 62, 63) AND V01.abschriftart_id = -1
  THEN 'KDN'
  WHEN V01.wv_grund_id IN (64, 65, 66, 67) AND V01.abschriftart_id = -1
  THEN 'KDP'
  WHEN V01.wv_grund_id IN (73, 74, 75, 76) AND V01.abschriftart_id = -1
  THEN 'KDX'
  ELSE ''
  END AS aktion_typ_liste_id
FROM kfl_production_dbp_data.marktabschriften AS V01
 LEFT JOIN (SELECT art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_data.art_gp_nm_zu_per
  WHERE mandant_id = 1) AS v02 ON V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
   AND v02.dat_bis
 INNER JOIN (SELECT art_id,
   gewart_id
  FROM kfl_production_dbp_data.art
  WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
 LEFT JOIN kfl_production_dbp_data.art_per AS V04 ON V01.art_id = V04.art_id AND V01.dat BETWEEN V04.dat_von AND V04.dat_bis
     AND V01.mandant_id = V04.mandant_id
WHERE V01.mandant_id = 1
UNION ALL
SELECT V01.mandant_id,
 V01.wup_id,
 V01.lagerbew_beleg_id AS wup_abschrift_id,
 V01.lagerbew_beleg_pos_id AS positionsnummer,
  CASE
  WHEN V01.lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND V01.grund_id IN ('0020')
  THEN 210
  WHEN V01.lager_bewart_id IN ('V25', 'V26', 'V27', 'V28', 'W25', 'W26', 'W27', 'W28') AND V01.grund_id IN ('0027')
  THEN 211
  WHEN V01.lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND V01.grund_id IN ('0026')
  THEN 212
  WHEN V01.lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10') AND V01.grund_id IN ('0040')
  THEN 213
  WHEN V01.lager_bewart_id IN ('V50', 'V51', 'V52', 'V53', 'W50', 'W51', 'W52', 'W53') AND V01.grund_id IN ('0012')
  THEN 240
  WHEN V01.lager_bewart_id IN ('V25', 'V26', 'V27', 'V28', 'W25', 'W26', 'W27', 'W28') AND V01.grund_id IN ('0051')
  THEN 241
  WHEN V01.lager_bewart_id IN ('V54', 'V55', 'V56', 'V57', 'W54', 'W55', 'W56', 'W57') AND V01.grund_id IN ('0029')
  THEN 242
  ELSE NULL
  END AS lager_bewart_id,
 V01.nb_id,
 V01.dat_buch AS dat,
 ROUND(CAST(CASE
    WHEN EXTRACT(ISOWEEK FROM V01.dat_buch) < 10
    THEN CONCAT(EXTRACT(YEAR FROM V01.dat_buch), '0', EXTRACT(ISOWEEK FROM V01.dat_buch))
    ELSE CONCAT(EXTRACT(YEAR FROM V01.dat_buch), EXTRACT(ISOWEEK FROM V01.dat_buch))
    END AS BIGNUMERIC), 0) AS woche_id,
  CASE
  WHEN V01.menge_lagerbew_bme < 0
  THEN V01.menge_lagerbew_bme * -1
  ELSE NULL
  END AS m_absch_menge,
  CASE
  WHEN V01.menge_lagerbew_bme > 0
  THEN V01.menge_lagerbew_bme * -1
  ELSE NULL
  END AS m_aufsch_menge,
 V01.art_id,
 CAST(CASE
   WHEN V02.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_kz_per,
 V01.dat_buch AS lastupd_dat,
   CASE
   WHEN V01.betrag_vk_netto_vz < 0
   THEN ROUND(CAST(V01.betrag_vk_netto_vz AS NUMERIC), 2)
   ELSE 0
   END * -1 AS abschriftenbetrag_netto,
   CASE
   WHEN V01.betrag_vk_netto_vz > 0
   THEN ROUND(CAST(V01.betrag_vk_netto_vz AS NUMERIC), 2)
   ELSE 0
   END * -1 AS aufschriftenbetrag_netto,
   CASE
   WHEN V01.betrag_verkauf < 0
   THEN CAST(V01.betrag_verkauf AS NUMERIC)
   ELSE 0
   END * -1 AS abschriftenbetrag_brutto,
   CASE
   WHEN V01.betrag_verkauf > 0
   THEN CAST(V01.betrag_verkauf AS NUMERIC)
   ELSE 0
   END * -1 AS aufschriftenbetrag_brutto,
 V01.gp_id,
 '' AS wv_kz,
 ROUND(CAST(V01.grund_id AS BIGNUMERIC), 0) AS wv_grund_id,
 0 AS vk_brutto,
 0 AS vk_aktion_brutto,
 0 AS pv_sa_loyalty,
 0 AS pv_sa_nicht_loyalty,
 0 AS pv_loyalty_bby,
 0 AS pv_nicht_loyalty_bby,
 0 AS pv_kdn_bby,
 0 AS pv_kdp_bby,
 0 AS pv_loyalty_bon_bby,
 0 AS pv_nicht_loyalty_bon_bby,
 '' AS aktion_typ_liste_id
FROM kfl_production_dbp_data.lagerbew_det AS V01
 LEFT JOIN kfl_production_dbp_data.art_per AS V02 ON V01.art_id = V02.art_id AND V01.dat_buch BETWEEN V02.dat_von AND
    V02.dat_bis AND V01.mandant_id = V02.mandant_id
WHERE V01.lager_bewart_id IN ('V11', 'V12', 'V13', 'V10', 'W11', 'W12', 'W13', 'W10', 'V25', 'V26', 'V27', 'V28', 'W25'
   , 'W26', 'W27', 'W28', 'V50', 'V51', 'V52', 'V53', 'W50', 'W51', 'W52', 'W53', 'V54', 'V55', 'V56', 'V57', 'W54',
   'W55', 'W56', 'W57')
 AND V01.grund_id IN ('0020', '0027', '0026', '0040', '0012', '0051', '0029')
 AND V01.mandant_id = 1;
