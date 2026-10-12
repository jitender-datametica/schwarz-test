CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.mv_wup_2
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
  CASE
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.wup_aenderung_grund_id IN (1, 2, 3, 4) AND V01.vkl_id < 0
  THEN COALESCE(V03.vkl_id, 1000 + V01.mandant_id * 100 + V01.vs_id * 10 * -1)
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.wup_aenderung_grund_id = 0 AND V01.vkl_id < 0
  THEN (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1
  ELSE V01.vkl_id
  END AS vkl_id,
 V01.breitengrad,
 V01.laengengrad,
 FIRST_VALUE(V01.breitengrad) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id)
  ORDER BY V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_breitengrad,
 FIRST_VALUE(V01.laengengrad) OVER (PARTITION BY V01.mandant_id, COALESCE(V03.aktuell_wup_id, V01.aktuell_wup_id)
  ORDER BY V01.dat_von  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS akt_laengengrad,
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
FROM kfl_production_dbp_view.v_wup_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_vaus_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id_alt AND
   V01.nb_id = V03.nb_id
WHERE V01.mandant_id <> 1
 AND (V01.nb_id = 0 OR V01.wup_id = 0)
 AND ((V01.dat_eroeffnung < CURRENT_DATE OR V01.dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL 45 DAY)) AND V01.dat_von
     IS NOT NULL OR V01.nb_id <> 0 OR V01.wup_id = 9203)
 AND V01.nb_id <> 99
 AND NOT V01.wup_id BETWEEN 1 AND 999;