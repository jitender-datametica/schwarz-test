CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_marktabschriften_1 (mandant_id, wup_id, wup_abschrift_id,
positionsnummer, abschriftart_id, nb_id, dat, art_id, abschriftbetrag_brutto, abschriftbetrag_netto, menge_abschrift,
vk_brutto, vk_aktion_brutto, wrg_id) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.wup_abschrift_id,
 V01.positionsnummer_id AS positionsnummer,
 V01.abschriftart_id,
 V01.nb_id,
 V01.dat,
 V01.art_id,
 V01.abschriftbetrag_brutto,
 V01.abschriftbetrag_netto,
  CASE
  WHEN V01.abschrift_menge_einh_id IS NULL AND v04.gewart_id = 'KG' AND CAST(V01.abschriftart_id AS STRING) <> '-1'
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  WHEN V01.abschrift_menge_einh_id = 'G' AND CAST(V01.abschriftart_id AS STRING) <> '-1'
  THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
  ELSE CAST(V01.menge_abschrift AS NUMERIC)
  END AS menge_abschrift,
 V01.vk_brutto,
 V01.vk_aktion_brutto,
 V02.default_wrg AS wrg_id
FROM kfl_production_dbp_view.v_marktabschriften_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
        AND V03.wg_id <> 961 AND (V03.mandant_id <> 5 OR V03.mandant_id = 5 AND TRIM(CAST(V03.wg_id AS STRING FORMAT '000')
          ) || TRIM(CAST(V03.wug_id AS STRING FORMAT '000')) NOT IN ('969001', '969002', '969003', '969004')) AND V03.arthiertyp_id
     = 2 AND V03.dat_bis = DATE '9999-12-31'
 INNER JOIN (SELECT art_id,
   gewart_id
  FROM kfl_production_dbp_view.v_art_1
  WHERE mandant_id = 1) AS v04 ON V01.art_id = v04.art_id
WHERE V01.mandant_id = 1;