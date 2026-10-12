CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_abschriften_wg_2 (mandant_id, nb_id, wup_id, wrg_id,
arthiertyp_id, abt_id, wg_id, abschriftart_id, dat, kjwo, kjmo, gj, abschrift_brutto, abschrift_brutto_kvj,
abschrift_brutto_wvj, abschrift_netto, abschrift_netto_kvj, abschrift_netto_wvj, abschrift_brutto_neg,
abschrift_brutto_neg_kvj, abschrift_brutto_neg_wvj) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.wrg_id,
 V01.arthiertyp_id,
 V01.abt_id,
 V01.wg_id,
 V01.abschriftart_id,
 V01.dat,
 V01.kjwo,
 V01.kjmo,
 V01.gj,
 V01.abschrift_brutto,
 V01.abschrift_brutto_kvj,
 V01.abschrift_brutto_wvj,
 V01.abschrift_netto,
 V01.abschrift_netto_kvj,
 V01.abschrift_netto_wvj,
  CASE
  WHEN V01.mandant_id IN (6) AND V01.abschriftart_id = 2 OR V01.mandant_id IN (3) AND V01.abschriftart_id = 11 OR V01.mandant_id
      IN (2, 5, 7, 8) AND V01.abschriftart_id = 7
  THEN V01.abschrift_brutto * - 1
  ELSE V01.abschrift_brutto
  END AS abschrift_brutto_neg,
  CASE
  WHEN V01.mandant_id IN (6) AND V01.abschriftart_id = 2 OR V01.mandant_id IN (3) AND V01.abschriftart_id = 11 OR V01.mandant_id
      IN (2, 5, 7, 8) AND V01.abschriftart_id = 7
  THEN V01.abschrift_brutto_kvj * - 1
  ELSE V01.abschrift_brutto_kvj
  END AS abschrift_brutto_neg_kvj,
  CASE
  WHEN V01.mandant_id IN (6) AND V01.abschriftart_id = 2 OR V01.mandant_id IN (3) AND V01.abschriftart_id = 11 OR V01.mandant_id
      IN (2, 5, 7, 8) AND V01.abschriftart_id = 7
  THEN V01.abschrift_brutto_wvj * - 1
  ELSE V01.abschrift_brutto_wvj
  END AS abschrift_brutto_neg_wvj
FROM kfl_production_dbp_msi_v_view.v_vis_tag_abschriften_wg_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;