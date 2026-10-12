CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_best_ausg_menge_einh_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  SUBSTR(
    CAST(CASE
      WHEN v01.best_menge_einh_id IS NULL OR v01.best_menge_einh_id = ''
      THEN 'ST'
      ELSE v01.best_menge_einh_id
    END AS STRING),
    1,
    3
  ) AS best_menge_einh_id,
  COALESCE(CASE WHEN v02.umrech_faktor = 0 THEN NULL ELSE v02.umrech_faktor END, 1) AS best_umrech_faktor,
  ROUND(
    CAST(1 / COALESCE(CASE WHEN v02.umrech_faktor = 0 THEN NULL ELSE v02.umrech_faktor END, 1) AS BIGNUMERIC),
    0
  ) AS best_menge_einh_inhalt,
  SUBSTR(
    CAST(CASE
      WHEN v03.ausg_menge_einh_id IS NULL OR v03.ausg_menge_einh_id = ''
      THEN 'ST'
      ELSE v03.ausg_menge_einh_id
    END AS STRING),
    1,
    3
  ) AS ausg_menge_einh_id,
  COALESCE(CASE WHEN v04.umrech_faktor = 0 THEN NULL ELSE v04.umrech_faktor END, 1) AS ausg_umrech_faktor,
  ROUND(
    CAST(1 / COALESCE(CASE WHEN v04.umrech_faktor = 0 THEN NULL ELSE v04.umrech_faktor END, 1) AS BIGNUMERIC),
    0
  ) AS ausg_menge_einh_inhalt,
  v05.einh_bez_kaufm AS einh_bez_kaufm
FROM kfl_production_dbp_view.v_art_1 AS v01
LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.art_id = v02.art_id
  AND v01.best_menge_einh_id = v02.altnv_menge_einh_id
  AND v02.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS v03
  ON v01.mandant_id = v03.mandant_id
  AND v01.art_id = v03.art_id
  AND v03.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS v04
  ON v03.mandant_id = v04.mandant_id
  AND v03.art_id = v04.art_id
  AND v03.ausg_menge_einh_id = v04.altnv_menge_einh_id
  AND v04.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN kfl_production_dbp_view.v_einh_spr_zu_1 AS v05
  ON v01.best_menge_einh_id = v05.einh_id
  AND v03.ausg_menge_einh_id = v05.einh_id
  AND v01.mandant_id = v05.mandant_id
  AND v05.spr_id = 22;
