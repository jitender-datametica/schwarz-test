CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_rech_pos_wbnk AS
SELECT 7 AS system_id,
 BRD.mandant_id,
 BRD.rech_beleg_id,
 BRD.gj,
 BRD.rech_beleg_pos_id,
 BRD.betrag_beleg,
 BRD.betrag_vk_brutto,
 'geplant' AS wbnk_planungs_kz,
 BRD.konditionsart_id AS wbnkart_id,
 AWZP.arthiertyp_id,
 AWZP.wg_id,
 BRD.wup_id,
 BRD.nb_id,
 BRD.pos_manuell_erstellt_fg,
 BR.dat_beleg,
 BR.dat_buch,
 CAST(CASE
   WHEN BR.rech_beleg_status_id = '5'
   THEN CAST(BR.dat_erfasst AS STRING)
   ELSE NULL
   END AS DATE) AS dat_rpw_,
 BR.dat_vorerfasst AS dat_erfasst,
 CAST(NULL AS INTEGER) AS kontierungsblock_nr
FROM kfl_production_dbp_view.v_besch_rech_det AS BRD
 INNER JOIN kfl_production_dbp_view.v_besch_rech AS BR ON BRD.mandant_id = BR.mandant_id AND BRD.rech_beleg_id = BR.rech_beleg_id
     AND BRD.gj = BR.gj
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS AWZP ON BRD.mandant_id = AWZP.mandant_id AND BRD.art_id = AWZP.art_id
      AND BRD.arthiertyp_id = AWZP.arthiertyp_id AND BR.dat_beleg BETWEEN AWZP.dat_von AND AWZP.dat_bis
WHERE BRD.mandant_id = 1
 AND STRPOS(BRD.konditionsart_id, 'YN') <> 0
UNION ALL
SELECT 7 AS system_id,
 BRDK.mandant_id,
 BRDK.rech_beleg_id,
 BRDK.gj,
 BRDK.rech_beleg_kont_pos_id AS rech_beleg_pos_id,
 BRDK.betrag_beleg AS betrag_netto,
 CAST(NULL AS NUMERIC) AS betrag_brutto,
  CASE
  WHEN BRDK.row_grund_id IN ('117', '124', '125', '126', '129', '133', '135')
  THEN 'statistisch geplant'
  WHEN BRDK.row_grund_id IN ('113', '127', '128', '131', '136', '143', '162')
  THEN 'ungeplant'
  WHEN BRDK.row_grund_id IN ('146', '150', '152', '154', '163', '165', '174')
  THEN 'sonstige Erlöse'
  WHEN BRDK.row_grund_id IN ('118', '130', '137', '141', '144', '145', '147', '151', '153', '164', '172', '173', '175')
  THEN 'Sachkosten'
  ELSE 'keine BNK'
  END AS wbnk_planungs_kz,
 CAST(BRDK.row_grund_id AS STRING) AS wbnkart_id,
 BRDK.arthiertyp_id,
  CASE
  WHEN BRDK.wg_id IS NULL
  THEN -3
  ELSE BRDK.wg_id
  END AS wg_id,
 BR.wup_id,
 BR.nb_id,
 1 AS pos_manuell_erstellt_fg,
 BR.dat_beleg,
 BR.dat_buch,
 BR.dat_aenderung_rpw AS dat_rpw_,
 DATE(BR.dat_erfasst) AS dat_erfasst,
 BRDK.kontierungsblock_nr
FROM kfl_production_dbp_view.v_besch_rech_det_kont AS BRDK
 INNER JOIN kfl_production_dbp_view.v_besch_rech AS BR ON BRDK.mandant_id = BR.mandant_id AND BRDK.rech_beleg_id = BR.rech_beleg_id
     AND BRDK.gj = BR.gj
WHERE BRDK.mandant_id = 1;