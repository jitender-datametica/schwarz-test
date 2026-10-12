CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_wwc.mv_mard_mardh_1 AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.gjmo AS gjmo,
  v01.gjmo_bis AS gjmo_bis,
  v01.mard_fg AS mard_fg,
  v01.datzeit_daten_abzug AS datzeit_daten_abzug,
  v01.lagerort_id AS lgort,
  NULL AS vprsv,
  v01.vk_brutto AS vk_brutto,
  ROUND(
    CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
    4
  ) AS vk_netto,
  v01.menge_lgbest_erp_frei_bme AS labst,
  ROUND(CAST(v01.menge_lgbest_erp_frei_bme * v01.vk_brutto AS NUMERIC), 3) AS labst_zvkbr,
  ROUND(
    CAST(v01.menge_lgbest_erp_frei_bme * ROUND(
      CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
      4
    ) AS NUMERIC),
    3
  ) AS labst_zvknt,
  v01.menge_lgbest_erp_umlag_bme AS umlme,
  v01.menge_lgbest_erp_qual_bme AS insme,
  ROUND(CAST(v01.menge_lgbest_erp_qual_bme * v01.vk_brutto AS NUMERIC), 3) AS insme_zvkbr,
  ROUND(
    CAST(v01.menge_lgbest_erp_qual_bme * ROUND(
      CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
      4
    ) AS NUMERIC),
    3
  ) AS insme_zvknt,
  v01.menge_lgbest_erp_nf_charge_bme AS einme,
  v01.menge_lgbest_erp_gesp_bme AS speme,
  ROUND(CAST(v01.menge_lgbest_erp_gesp_bme * v01.vk_brutto AS NUMERIC), 3) AS speme_zvkbr,
  ROUND(
    CAST(v01.menge_lgbest_erp_gesp_bme * ROUND(
      CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
      4
    ) AS NUMERIC),
    3
  ) AS speme_zvknt,
  v01.menge_lgbest_erp_ret_gesp_bme AS retme
FROM kfl_production_dbp_view.v_bestand_erp_monat_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.art_id = v02.art_id
  AND CURRENT_DATE BETWEEN v02.dat_von AND v02.dat_bis
LEFT JOIN kfl_production_dbp_view.v_mwst_per_1 AS v03
  ON v02.mandant_id = v03.mandant_id
  AND v02.mwst_id = v03.mwst_id
  AND CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS v04
  ON v01.art_id = v04.art_id
  AND v01.mandant_id = v04.mandant_id
  AND (
    NOT v04.mandant_id IN (1, 7)
    OR v04.mandant_id IN (1, 7)
    AND TRIM(CAST(v04.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v04.wug_id AS STRING FORMAT '000')) <> '969006'
  )
  AND (
    v04.mandant_id <> 7
    OR v04.mandant_id = 7
    AND TRIM(CAST(v04.wg_id AS STRING FORMAT '000')) <> '980'
  )
  AND v04.wg_id <> 961
  AND (
    NOT v04.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    OR v04.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    AND NOT TRIM(CAST(v04.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v04.wug_id AS STRING FORMAT '000')) IN ('969001', '969002', '969003', '969004')
  )
  AND v04.arthiertyp_id = 2
  AND v04.dat_bis = CAST('9999-12-31' AS DATE)
WHERE
  v01.nb_id <> 99;