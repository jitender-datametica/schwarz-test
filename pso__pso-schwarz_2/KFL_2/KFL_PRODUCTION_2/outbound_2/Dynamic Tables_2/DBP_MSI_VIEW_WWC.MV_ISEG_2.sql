CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_iseg_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.inv_beleg_id,
  v01.gj,
  v01.inv_beleg_pos_id,
  TRIM(CAST(v01.inv_beleg_id AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(v01.inv_beleg_pos_id AS STRING FORMAT '0000')) AS iblnr_zeile,
  v01.mandant_id,
  v01.dat_letzt_zaehl,
  v01.lagerort_id,
  v01.dat_buch,
  v01.wup_id,
  v01.nb_id,
  v01.art_id,
  COALESCE(v01.lagerbew_beleg_id, 0) AS lagerbew_beleg_id,
  COALESCE(v01.lagerbew_beleg_pos_id, 0) AS lagerbew_beleg_pos_id,
  TRIM(CAST(v01.lagerbew_beleg_id AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(v01.lagerbew_beleg_pos_id AS STRING FORMAT '0000')) AS mblnr_zeile,
  v01.kj,
  v01.erfsngs_menge_einh_id,
  v01.menge_erf,
  v01.menge_buch,
  v01.menge_zaehl,
  v01.wert_diff_inv,
  v01.wert_vk_brutto,
  v01.wert_vk_extern,
  v01.wert_vk_netto,
  v01.vk_inventur_diff_brutto,
  v01.vk_inventur_diff_netto,
  v01.wert_zaehl,
  v01.wert_menge_buch,
  v01.nullzaehl_fg,
  v01.beleg_erfasser_id
FROM kfl_production_dbp_view.v_inventur_det_2 AS v01
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS v02
  ON v01.art_id = v02.art_id
  AND v01.mandant_id = v02.mandant_id
  AND (
    NOT v02.mandant_id IN (1, 7)
    OR v02.mandant_id IN (1, 7)
    AND TRIM(CAST(v02.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v02.wug_id AS STRING FORMAT '000')) <> '969006'
  )
  AND (
    v02.mandant_id <> 7
    OR v02.mandant_id = 7
    AND TRIM(CAST(v02.wg_id AS STRING FORMAT '000')) <> '980'
  )
  AND v02.wg_id <> 961
  AND (
    NOT v02.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    OR v02.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    AND NOT TRIM(CAST(v02.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v02.wug_id AS STRING FORMAT '000')) IN ('969001', '969002', '969003', '969004')
  )
  AND v02.arthiertyp_id = 2
  AND v02.dat_bis = CAST('9999-12-31' AS DATE);