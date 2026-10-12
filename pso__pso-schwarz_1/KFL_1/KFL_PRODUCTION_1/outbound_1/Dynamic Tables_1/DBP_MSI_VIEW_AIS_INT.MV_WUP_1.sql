CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_wup_1
 AS
SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.wup_aenderung_grund_id,
 COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id) AS aktuell_wup_id1,
 COALESCE(MAX(V01.wup_id_alt) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id)
   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), V01.orig_wup_id) AS orig_wup_id,
 V01.wup_standort,
 FIRST_VALUE(V01.wup_standort) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id)
  ORDER BY V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_wup_standort,
 TRIM(CAST(V01.aktuell_wup_id AS STRING) || ' ' || V01.wup_standort) AS wup_standort_akt_wup,
 COALESCE(V01.dat_von_alt, V01.dat_von) AS dat_von,
 V01.dat_bis,
 V01.dat_qbm_umstellung,
 COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) AS dat_eroeffnung,
 V01.wup_plz,
 FIRST_VALUE(V01.wup_plz) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id) ORDER BY
    V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_wup_plz,
 V02.region_id,
 FIRST_VALUE(V02.region_id) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id) ORDER BY
    V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_region_id,
 V01.kreistyp_gruppe_id,
 V01.breitengrad,
 V01.laengengrad,
 FIRST_VALUE(V01.breitengrad) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id)
  ORDER BY V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_breitengrad,
 FIRST_VALUE(V01.laengengrad) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id)
  ORDER BY V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_laengengrad,
 V01.wup_typ_id,
 V01.uebernahme_von,
 FIRST_VALUE(V01.uebernahme_von) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id)
  ORDER BY V01.dat_von , V01.dat_bis  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 akt_uebernahme_von,
 V01.verkaufsflaeche,
 V01.betriebsflaeche,
 V01.dat_umstellung_waage,
 V01.kundenfaktor,
 V01.vz_wup_id,
  CASE
  WHEN V05.wup_cluster_id IN (102, 107)
  THEN 1
  WHEN V05.wup_cluster_id IN (101, 103)
  THEN 2
  WHEN V05.wup_cluster_id IN (106, 108)
  THEN 3
  ELSE NULL
  END AS wreg_id,
  CASE
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.wup_aenderung_grund_id IN (1, 2, 3, 4) AND V01.vkl_id < 0
  THEN COALESCE(V03.vkl_id, 1000 + V01.mandant_id * 100 + V01.vs_id * 10 * -1)
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.wup_aenderung_grund_id = 0 AND V01.vkl_id < 0
  THEN (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1
  ELSE V01.vkl_id
  END AS vkl_id,
 V01.vs_id,
  CASE
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.wup_aenderung_grund_id IN (1, 2, 3, 4) AND V01.gf_id < 0
  THEN COALESCE(V03.gf_id, 1000 + V01.mandant_id * 100 + V01.vs_id * 10 * -1)
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.wup_aenderung_grund_id = 0 AND V01.gf_id < 0
  THEN (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1
  ELSE V01.gf_id
  END AS gf_id,
 V01.umzugsfiliale_fg,
 V01.gln_id,
 FIRST_VALUE(V01.gln_id) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id) ORDER BY
    V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_gln_id
FROM kfl_production_dbp_data.wup_1 AS V01
 LEFT JOIN kfl_production_dbp_data.vaus_wup_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
 LEFT JOIN kfl_production_dbp_data.wup_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id_alt AND V01
   .nb_id = V03.nb_id
 LEFT JOIN kfl_production_dbp_data.ts_scm_wup_cluster_zu_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05
     .wup_id AND V01.nb_id = V05.nb_id AND V05.wup_cluster_id IN (101, 102, 103, 106, 107, 108)
WHERE ((V01.dat_eroeffnung < CURRENT_DATE OR V01.dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL 45 DAY)) AND V01.dat_von
     IS NOT NULL OR V01.nb_id <> 0 OR V01.wup_id = 9203)
 AND V01.nb_id <> 99
 AND NOT V01.wup_id BETWEEN 1 AND 999;
