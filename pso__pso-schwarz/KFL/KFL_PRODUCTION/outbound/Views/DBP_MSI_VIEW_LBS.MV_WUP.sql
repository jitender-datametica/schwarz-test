CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_wup (mandant_id, wup_id, nb_id, wup_standort, dat_von, dat_bis
, dat_qbm_umstellung, dat_eroeffnung, wup_plz, region_id, kreistyp_gruppe_id, breitengrad, laengengrad, wup_typ_id,
uebernahme_von, verkaufsflaeche, betriebsflaeche, dat_umstellung_waage, kundenfaktor, vz_wup_id, vkl_id, vs_id, vf_id,
gf_id, hl_id, wm_id, umzugsfiliale_fg) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || V01.wup_standort) AS wup_standort,
 COALESCE(V01.dat_von_alt, V01.dat_von) AS dat_von,
 V01.dat_bis,
 V01.dat_qbm_umstellung,
 COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) AS dat_eroeffnung,
 V01.wup_plz,
 V02.region_id,
 V01.kreistyp_gruppe_id,
 V01.breitengrad,
 V01.laengengrad,
 V01.wup_typ_id,
 V01.uebernahme_von,
 V01.verkaufsflaeche,
 V01.betriebsflaeche,
 V01.dat_umstellung_waage,
 V01.kundenfaktor,
 V01.vz_wup_id,
  CASE
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.umzugsfiliale_fg = 1 AND V01.vkl_id < 0
  THEN COALESCE(V03.vkl_id, 1000 + V01.mandant_id * 100 + V01.vs_id * 10 * - 1)
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.umzugsfiliale_fg = 0 AND V01.vkl_id < 0
  THEN (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * - 1
  ELSE V01.vkl_id
  END AS vkl_id,
 V01.vs_id,
 V01.vf_id,
  CASE
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.umzugsfiliale_fg = 1 AND V01.gf_id < 0
  THEN COALESCE(V03.gf_id, 1000 + V01.mandant_id * 100 + V01.vs_id * 10 * - 1)
  WHEN V01.dat_bis <> DATE '9999-12-31' AND V01.umzugsfiliale_fg = 0 AND V01.gf_id < 0
  THEN (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * - 1
  ELSE V01.gf_id
  END AS gf_id,
 V01.hl_id,
 V01.wm_id,
 V01.umzugsfiliale_fg
FROM kfl_production_dbp_view.v_wup AS V01
 LEFT JOIN kfl_production_dbp_view.v_vaus_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
 LEFT JOIN kfl_production_dbp_view.v_wup AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id_alt AND
   V01.nb_id = V03.nb_id
WHERE ((V01.dat_eroeffnung < CURRENT_DATE OR V01.dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL 45 DAY)) AND V01.dat_von
     IS NOT NULL OR V01.nb_id <> 0 OR V01.wup_id = 9203)
 AND V01.nb_id <> 99
 AND NOT V01.wup_id BETWEEN 1 AND 999;