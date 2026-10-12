CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_cpr_projekt_termin
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  pr.projekt_id AS projekt_id,
  pr.cpr_ext_id AS projekt_ext_id,
  inpr.in_projekt_id AS in_projekt_id,
  inpr.mandant_id AS mandant_id,
  TRIM(pr.techn_platz_id) AS techn_platz_id,
  2 AS techn_platz_ebene_id,
  pr.massnahme_id AS massnahme_kz,
  pr.cpr_kategorie_id AS cpr_kategorie_id,
  pr.projekt_anlass_id AS projekt_anlass_id,
  pr.projektart_id AS projektart_id,
  CAST(NULL AS STRING) AS cpr_projekt_gruppe_id,
  pr.dat_freigabe AS dat_freigabe,
  MIN(CASE WHEN bau.cpr_suchfeld_id IN (2, 407) THEN bau.dat_ips ELSE NULL END) AS baubeginn,
  MIN(CASE WHEN bau.cpr_suchfeld_id IN (2, 407) THEN bau.dat_ips ELSE NULL END) AS kbe_baugenehmigung_rechtsk,
  MIN(CASE WHEN bau.cpr_suchfeld_id IN (2, 407) THEN bau.dat_ips ELSE NULL END) AS beginn_einrichtung,
  MAX(CASE WHEN bau.cpr_suchfeld_id = 123 THEN bau.dat_ips ELSE NULL END) AS cpr_bauabnahme,
  MAX(CASE WHEN bau.cpr_suchfeld_id IN (113, 410) THEN bau.dat_ips ELSE NULL END) AS stille_eroeffnung
FROM kfl_production_dbp_view.v_in_projekt AS inpr
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_cpr_projekt_per AS t
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
) AS pr
  ON inpr.projekt_ext_id = pr.cpr_ext_id
LEFT JOIN (
  SELECT
    cpr_ext_id,
    cpr_suchfeld_id,
    CASE
      WHEN dat_ende_ist > CAST('2010-01-01' AS DATE)
      THEN dat_ende_ist
      WHEN dat_ende_vorhersage > CAST('2010-01-01' AS DATE)
      THEN dat_ende_vorhersage
      WHEN dat_ende_einschraenkung > CAST('2010-01-01' AS DATE)
      THEN dat_ende_einschraenkung
      ELSE NULL
    END AS dat_ips
  FROM kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu
  WHERE
    sort_id = 1 AND cpr_suchfeld_id IN (3, 84, 113, 123, 392, 407, 408, 410)
) AS bau
  ON inpr.projekt_ext_id = bau.cpr_ext_id
GROUP BY
  pr.projekt_id,
  projekt_ext_id,
  inpr.in_projekt_id,
  inpr.mandant_id,
  techn_platz_id,
  techn_platz_ebene_id,
  massnahme_kz,
  pr.cpr_kategorie_id,
  pr.projekt_anlass_id,
  pr.projektart_id,
  cpr_projekt_gruppe_id,
  pr.dat_freigabe;
