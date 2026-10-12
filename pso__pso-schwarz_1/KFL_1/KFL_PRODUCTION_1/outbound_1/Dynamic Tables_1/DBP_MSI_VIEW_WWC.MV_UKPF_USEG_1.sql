CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_ukpf_useg_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.art_id,
  v01.dat_umbew AS vpdat,
  v01.diff_wert_bestand_brutto AS vksad,
  v01.diff_wert_bestand_netto AS vksadn,
  v01.kj AS ubjahr,
  v01.mandant_id,
  v01.menge_umbew AS menge,
  v01.nb_id,
  v01.preis_aend_grund_id AS pv_grund,
  TRIM(CAST(v01.umbew_beleg_id AS STRING FORMAT '0000000000')) AS ublnr,
  TRIM(CAST(v01.umbew_beleg_pos_id AS STRING FORMAT '0000')) AS uzeil,
  TRIM(CAST(v01.umbew_beleg_id AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(v01.umbew_beleg_pos_id AS STRING FORMAT '0000000000')) AS ublnr_uzeil,
  v01.vk_brutto_alt AS vpalt,
  v01.wrg_id AS hwaer,
  v01.wup_id AS werks,
  v01.vk_brutto_neu AS vpneu,
  v01.wert_bestand_brutto_alt AS vksal_old,
  v01.wert_bestand_netto_alt AS vksaln_old,
  v01.menge_bestand_bme AS lbkum,
  v01.buchungskreis_id AS bukrs,
  v01.soll_haben_kz AS shkzg,
  v01.art_id_bf AS matbf,
  v01.menge_erf AS erfmg,
  v02.basismenge_einh_id AS meins
FROM kfl_production_dbp_view.v_art_umbewertung_1 AS v01
LEFT JOIN kfl_production_dbp_view.v_art_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.art_id = v02.art_id
  AND v02.dat_bis = CAST('9999-12-31' AS DATE)
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
  AND v03.dat_bis = CAST('9999-12-31' AS DATE);