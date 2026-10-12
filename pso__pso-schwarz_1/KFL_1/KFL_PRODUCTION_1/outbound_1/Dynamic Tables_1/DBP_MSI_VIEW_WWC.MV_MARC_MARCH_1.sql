CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_wwc.mv_marc_march_1 AS
SELECT
  v01.mandant_id,
  v01.art_id,
  v01.wup_id,
  v01.nb_id,
  v01.gjmo,
  v01.gjmo_bis,
  v01.marc_fg,
  NULL AS datzeit_daten_abzug,
  SUBSTR('-1  ', 1, 4) AS lgort,
  NULL AS vprsv,
  v01.vk_brutto,
  ROUND(
    CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
    4
  ) AS vk_netto,
  v01.menge_bestand_umlag_bme AS umlmc,
  ROUND(CAST(v01.menge_bestand_umlag_bme * v01.vk_brutto AS NUMERIC), 3) AS umlmc_zvkbr,
  ROUND(
    CAST(v01.menge_bestand_umlag_bme * ROUND(
      CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
      4
    ) AS NUMERIC),
    3
  ) AS umlmc_zvknt,
  v01.menge_bestand_transit_bme AS trame,
  ROUND(CAST(v01.menge_bestand_transit_bme * v01.vk_brutto AS NUMERIC), 3) AS trame_zvkbr,
  ROUND(
    CAST(v01.menge_bestand_transit_bme * ROUND(
      CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
      4
    ) AS NUMERIC),
    3
  ) AS trame_zvknt,
  v01.menge_bestand_geb_leergut AS glgmg,
  ROUND(CAST(v01.menge_bestand_geb_leergut * v01.vk_brutto AS NUMERIC), 3) AS glgmg_zvkbr,
  ROUND(
    CAST(v01.menge_bestand_geb_leergut * ROUND(
      CAST(v01.vk_brutto - TRUNC(CAST(v01.vk_brutto * v03.mwst / 100 AS BIGNUMERIC)) AS NUMERIC),
      4
    ) AS NUMERIC),
    3
  ) AS glgmg_zvknt
FROM kfl_production_dbp_view.v_art_wup_status_periode_1 AS v01
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