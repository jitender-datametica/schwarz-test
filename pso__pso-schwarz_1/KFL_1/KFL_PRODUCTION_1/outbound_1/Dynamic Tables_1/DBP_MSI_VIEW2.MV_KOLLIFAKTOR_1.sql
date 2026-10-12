CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_kollifaktor_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  COALESCE(v02.umrech_faktor, 1) AS umrech_faktor
FROM (
  SELECT
    art_id,
    mandant_id,
    ausg_menge_einh_id
  FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
) AS v01
LEFT JOIN (
  SELECT
    art_id,
    mandant_id,
    altnv_menge_einh_id,
    umrech_faktor
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
) AS v02
  ON v01.art_id = v02.art_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.ausg_menge_einh_id = v02.altnv_menge_einh_id
WHERE
  v01.mandant_id = 1;
