CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_mbew_mbewh_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.gjmo,
  v01.art_id,
  v01.mandant_id,
  ROUND(SAFE_CAST(v01.bewertungskreis_id AS BIGNUMERIC), 0) AS bwkey,
  v02.nb_id,
  v01.wrg_id,
  v01.dat_aenderung,
  v01.menge_bestand_bme AS lbkum,
  v01.wert_bestand AS salk3,
  v01.vk_wert AS vksal,
  v01.mbew_fg,
  v01.gjmo_bis,
  NULL AS datzeit_daten_abzug,
  SUBSTR('-1  ', 1, 4) AS lgort,
  v01.bewertung_klasse_id AS bklas,
  v01.preis_steuer_kz AS vprsv,
  v01.gld AS verpr,
  v01.standard_preis AS stprs,
  v01.dat_letzte_preisaenderung AS laepr,
  v01.vk_wert_netto AS vksal_nt
FROM kfl_production_dbp_view.v_art_bewertungskreis_periode_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS v03
  ON v01.art_id = v03.art_id
  AND v01.mandant_id = v03.mandant_id
  AND (
    NOT v03.mandant_id IN (1, 7)
    OR v03.mandant_id IN (1, 7)
    AND TRIM(CAST(v03.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v03.wug_id AS STRING FORMAT '000')) <> '969006'
  )
  AND (
    v03.mandant_id <> 7
    OR v03.mandant_id = 7
    AND TRIM(CAST(v03.wg_id AS STRING FORMAT '000')) <> '980'
  )
  AND v03.wg_id <> 961
  AND (
    NOT v03.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    OR v03.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    AND NOT TRIM(CAST(v03.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v03.wug_id AS STRING FORMAT '000')) IN ('969001', '969002', '969003', '969004')
  )
  AND v03.arthiertyp_id = 2
  AND v03.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN kfl_production_dbp_view.v_wup_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND ROUND(SAFE_CAST(v01.bewertungskreis_id AS BIGNUMERIC), 0) = v02.wup_id
WHERE
  v01.gjmo > 190001;