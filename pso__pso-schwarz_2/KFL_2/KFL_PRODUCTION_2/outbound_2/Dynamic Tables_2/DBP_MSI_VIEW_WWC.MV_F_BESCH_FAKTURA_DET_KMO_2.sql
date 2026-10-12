CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_f_besch_faktura_det_kmo_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id,
  v01.faktura_beleg_id,
  v02.faktura_beleg_pos_id,
  v01.fakturaart_id,
  v01.dat_faktura_sap,
  v01.fktyp,
  v01.wrg_id,
  v01.mandant_id_empfaenger,
  v02.art_id,
  v02.wup_id,
  v02.nb_id,
  v02.retoure_pos_kz,
  v02.basismenge_einh_id,
  v02.verk_menge_einh_id,
  v02.steuer_typ_id,
  v02.sap_mwst_id AS sap_steuer_id,
  v01.kurrf,
  COALESCE(v02.aktion_id, '') AS aktion_id,
  CASE WHEN v02.aktion_id <> '' OR v04.anz_kondition_schl_id > 1 THEN 1 ELSE 0 END AS aktion_fg,
  v04.anz_kondition_schl_id,
  DATETIME(v01.dat_erstellung, v01.zeit_erstellung) AS timestamp_faktura,
  CASE WHEN v02.retoure_pos_kz = 'X' THEN -1 ELSE 1 END AS vorzeichen_menge,
  CASE
    WHEN v01.fakturaart_id IN ('Z41', 'Z42')
    THEN v02.menge_faktura_bme * -1
    ELSE v02.menge_faktura_bme
  END AS menge_faktura_bme,
  CASE
    WHEN v01.fakturaart_id IN ('Z41', 'Z42')
    THEN v02.menge_faktura_lme * -1
    ELSE v02.menge_faktura_lme
  END AS menge_faktura_lme,
  CASE
    WHEN v01.fakturaart_id IN ('Z41', 'Z42')
    THEN v02.betrag_verrechnung * -1
    ELSE v02.betrag_verrechnung
  END AS betrag_verrechnung,
  CASE
    WHEN v01.fakturaart_id IN ('Z41', 'Z42')
    THEN v02.betrag_netto * -1
    ELSE v02.betrag_netto
  END AS betrag_netto,
  CASE
    WHEN v01.fakturaart_id IN ('Z41', 'Z42')
    THEN v02.zwsum_1_betrag * -1
    ELSE v02.zwsum_1_betrag
  END AS zwsum_1_betrag,
  CASE
    WHEN v01.fakturaart_id IN ('Z41', 'Z42')
    THEN v02.betrag_mwst * CASE WHEN v02.retoure_pos_kz = 'X' THEN -1 ELSE 1 END * -1
    ELSE v02.betrag_mwst * CASE WHEN v02.retoure_pos_kz = 'X' THEN -1 ELSE 1 END
  END AS betrag_mwst,
  ROUND(
    CAST(v02.vk_aktion_brutto / (
      1.00 + ROUND(CAST(v03.mwst / 100.00 AS BIGNUMERIC), 2)
    ) AS BIGNUMERIC),
    2
  ) AS vk_aktion_netto_faktura,
  ROUND(
    CAST(v02.vk_vor_aktion_brutto / (
      1.00 + ROUND(CAST(v03.mwst / 100.00 AS BIGNUMERIC), 2)
    ) AS BIGNUMERIC),
    2
  ) AS vk_vor_aktion_netto_faktura,
  (
    ROUND(
      CAST(v02.vk_vor_aktion_brutto / (
        1.00 + ROUND(CAST(v03.mwst / 100.00 AS BIGNUMERIC), 2)
      ) AS BIGNUMERIC),
      2
    ) - ROUND(
      CAST(v02.vk_aktion_brutto / (
        1.00 + ROUND(CAST(v03.mwst / 100.00 AS BIGNUMERIC), 2)
      ) AS BIGNUMERIC),
      2
    )
  ) * v02.menge_faktura_bme * CASE
    WHEN CASE WHEN v02.aktion_id <> '' OR v04.anz_kondition_schl_id > 1 THEN 1 ELSE 0 END = 1
    THEN 1
    ELSE NULL
  END AS abschriftbetrag_netto_faktura
FROM kfl_production_dbp_view.v_besch_faktura_kmo_2 AS v01
INNER JOIN kfl_production_dbp_view.v_tag_2 AS v06
  ON v01.dat_faktura_sap = v06.dat AND v06.akt_kj BETWEEN -2 AND 0
INNER JOIN kfl_production_dbp_view.v_besch_faktura_det_kmo_2 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.faktura_beleg_id = v02.faktura_beleg_id
  AND v01.dat_faktura_sap = v02.dat_faktura_sap
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS v05
  ON v02.art_id = v05.art_id
  AND v02.mandant_id = v05.mandant_id
  AND (
    NOT v05.mandant_id IN (1, 7)
    OR v05.mandant_id IN (1, 7)
    AND TRIM(CAST(v05.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v05.wug_id AS STRING FORMAT '000')) <> '969006'
  )
  AND (
    v05.mandant_id <> 7
    OR v05.mandant_id = 7
    AND TRIM(CAST(v05.wg_id AS STRING FORMAT '000')) <> '980'
  )
  AND v05.wg_id <> 961
  AND (
    NOT v05.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    OR v05.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    AND NOT TRIM(CAST(v05.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v05.wug_id AS STRING FORMAT '000')) IN ('969001', '969002', '969003', '969004')
  )
  AND v05.arthiertyp_id = 2
  AND v05.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN (
  SELECT
    mandant_id,
    faktura_beleg_id,
    faktura_beleg_pos_id,
    COUNT(kondition_schl_id) AS anz_kondition_schl_id
  FROM kfl_production_dbp_view.v_besch_faktura_kondit_2
  WHERE
    kondition_schl_id IN (
      'PN10',
      'ZNR',
      'ZK03',
      'ZK01',
      'ZK02',
      'ZBON',
      'ZBOV',
      'ZWG1',
      'Z3F2',
      'ZAR1',
      'ZAR2',
      'ZM05',
      'ZHM',
      'ZMW',
      'ZBAR',
      'ZBAP',
      'ZMP',
      'RB19'
    )
    AND mandant_id IN (2, 4, 7)
    OR kondition_schl_id IN (
      'PN10',
      'ZNR',
      'ZK03',
      'ZK01',
      'ZK02',
      'ZBON',
      'ZBOV',
      'ZWG1',
      'Z3F2',
      'ZAR1',
      'ZM05',
      'ZHM',
      'ZMW',
      'ZBAR',
      'ZMP',
      'ZMPP',
      'ZM06'
    )
    AND mandant_id IN (5, 6)
    OR kondition_schl_id IN (
      'PN10',
      'ZNR',
      'ZK03',
      'ZK01',
      'ZK02',
      'ZBON',
      'ZBOV',
      'ZWG1',
      'Z3F2',
      'ZAR1',
      'ZAR2',
      'ZM05',
      'ZHM',
      'ZMW',
      'ZBAR',
      'ZBAP',
      'ZMP',
      'RB19',
      'ZMPP'
    )
    AND mandant_id = 3
    OR kondition_schl_id IN (
      'PN10',
      'ZNR',
      'ZK03',
      'ZK01',
      'ZK02',
      'ZBON',
      'ZBOV',
      'ZWG1',
      'Z3F2',
      'ZAR1',
      'ZM05',
      'ZHM',
      'ZMW',
      'ZBAR',
      'ZBAP',
      'ZMP',
      'ZMPP',
      'ZM06'
    )
    AND mandant_id = 8
  GROUP BY
    mandant_id,
    faktura_beleg_id,
    faktura_beleg_pos_id
) AS v04
  ON v01.mandant_id = v04.mandant_id
  AND v01.faktura_beleg_id = v04.faktura_beleg_id
  AND v02.faktura_beleg_pos_id = v04.faktura_beleg_pos_id
LEFT JOIN kfl_production_dbp_view.v_mwst_per_2 AS v03
  ON v02.mandant_id = v03.mandant_id
  AND v02.sap_mwst_id = v03.sap_mwst_id
  AND v02.dat_faktura_sap BETWEEN v03.dat_von AND v03.dat_bis
WHERE
  v01.mandant_id <> 1;