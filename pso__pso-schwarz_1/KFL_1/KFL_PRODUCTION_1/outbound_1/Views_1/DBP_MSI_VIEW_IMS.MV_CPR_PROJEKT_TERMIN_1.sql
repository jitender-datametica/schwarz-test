CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_cpr_projekt_termin_1 AS SELECT pr.projekt_id,
 pr.cpr_ext_id AS projekt_ext_id,
 INPR.in_projekt_id,
 INPR.mandant_id,
 TRIM(pr.techn_platz_id) AS techn_platz_id,
 2 AS techn_platz_ebene_id,
 pr.massnahme_id AS massnahme_kz,
 pr.cpr_kategorie_id,
 pr.projekt_anlass_id,
 pr.projektart_id,
 CAST(NULL AS STRING) AS cpr_projekt_gruppe_id,
 pr.dat_freigabe,
 MIN(CASE
   WHEN bau.cpr_suchfeld_id IN (2, 407)
   THEN bau.dat_ips
   ELSE NULL
   END) AS baubeginn,
 MIN(CASE
   WHEN bau.cpr_suchfeld_id IN (2, 407)
   THEN bau.dat_ips
   ELSE NULL
   END) AS kbe_baugenehmigung_rechtsk,
 MIN(CASE
   WHEN bau.cpr_suchfeld_id IN (2, 407)
   THEN bau.dat_ips
   ELSE NULL
   END) AS beginn_einrichtung,
 MAX(CASE
   WHEN bau.cpr_suchfeld_id = 123
   THEN bau.dat_ips
   ELSE NULL
   END) AS cpr_bauabnahme,
 MAX(CASE
   WHEN bau.cpr_suchfeld_id IN (113, 410)
   THEN bau.dat_ips
   ELSE NULL
   END) AS stille_eroeffnung
FROM kfl_production_dbp_view.v_in_projekt_1 AS INPR
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS T
  WHERE dat_bis = DATE '9999-12-31') AS pr ON INPR.projekt_ext_id = pr.cpr_ext_id
 LEFT JOIN (SELECT cpr_ext_id,
   cpr_suchfeld_id,
    CASE
    WHEN dat_ende_ist > DATE '2010-01-01'
    THEN dat_ende_ist
    WHEN dat_ende_vorhersage > DATE '2010-01-01'
    THEN dat_ende_vorhersage
    WHEN dat_ende_einschraenkung > DATE '2010-01-01'
    THEN dat_ende_einschraenkung
    ELSE NULL
    END AS dat_ips
  FROM kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_1
  WHERE sort_id = 1
   AND cpr_suchfeld_id IN (3, 84, 113, 123, 392, 407, 408, 410)) AS bau ON INPR.projekt_ext_id = bau.cpr_ext_id
GROUP BY pr.projekt_id,
 projekt_ext_id,
 INPR.in_projekt_id,
 INPR.mandant_id,
 techn_platz_id,
 techn_platz_ebene_id,
 massnahme_kz,
 pr.cpr_kategorie_id,
 pr.projekt_anlass_id,
 pr.projektart_id,
 cpr_projekt_gruppe_id,
 pr.dat_freigabe;