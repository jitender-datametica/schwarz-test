CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wup (mandant_id, mandant_kbez, nb_id, land_id, wup_id,
aktuell_wup_id, orig_wup_id, wup_standort, akt_wup_standort, vs_id, vw_id, wm_id, vkl_id, hl_id, vf_id, buchungskreis_id
, dat_eroeffnung, verkaufsflaeche, uebernahme_von, getraenkemarkt_fg, kundenfaktor, getraenke_markt_fg,
preiskategorie_food, preiskategorie_nonfood, sortkategorie_food, sortkategorie_nonfood, region_id, wup_str, wup_plz,
wup_stadt, wup_typ_id, wup_name_v, wup_name_e, lead_mwst, breakevenumsatz, systemrentabilitaet, betriebsflaeche,
fleischsystem, sondermarkt, ref_wup_id, kassentyp, dat_qbm_umstellung, qbm_id, vz_wup_id, verkaufsorganisation_id,
dat_bis, laengengrad, breitengrad, akt_laengengrad, akt_breitengrad, kreistyp_gruppe_id, wreg_id, wup_aenderung_grund_id
) AS SELECT V01.mandant_id,
 V02.mandant_kbez,
 V01.nb_id,
 V01.land_id,
 V01.wup_id,
 COALESCE(V04.aktuell_wup_id, V01.aktuell_wup_id) AS aktuell_wup_id1,
 COALESCE(MAX(V01.wup_id_alt) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(COALESCE(V04.aktuell_wup_id, V01.aktuell_wup_id) AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), V01.orig_wup_id) AS orig_wup_id,
 V01.wup_standort,
 FIRST_VALUE(V01.wup_standort) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(COALESCE(V04.aktuell_wup_id, V01.aktuell_wup_id) AS STRING)
    ORDER BY V01.dat_von IS NULL, V01.dat_von RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 akt_wup_standort,
 V01.vs_id,
 V01.vw_id,
 V01.wm_id,
 V01.vkl_id,
 V01.hl_id,
 V01.vf_id,
 V01.buchungskreis_id,
 V01.dat_eroeffnung,
 V01.verkaufsflaeche,
 V01.uebernahme_von,
 V01.getraenkemarkt_fg,
 V01.kundenfaktor,
  CASE
  WHEN V01.kundenfaktor < 1.000
  THEN 1
  ELSE 0
  END AS getraenke_markt_fg,
 V01.preiskategorie_food,
 V01.preiskategorie_nonfood,
 V01.sortkategorie_food,
 V01.sortkategorie_nonfood,
 COALESCE(V03.region_id, V01.region_id, - V01.mandant_id) AS region_id,
 COALESCE(V03.wup_str, V01.wup_str, '') AS wup_str,
 COALESCE(V03.wup_plz, V01.wup_plz) AS wup_plz,
 COALESCE(V03.wup_stadt_1, V01.wup_stadt, '') AS wup_stadt,
 V01.wup_typ_id,
 V01.wup_name_v,
 V01.wup_name_e,
 V01.lead_mwst,
 V01.breakevenumsatz,
 V01.systemrentabilitaet,
 V01.betriebsflaeche,
 V01.fleischsystem,
 V01.sondermarkt,
 V01.ref_wup_id,
 V01.kassentyp,
 V01.dat_qbm_umstellung,
 V01.qbm_id,
 V01.vz_wup_id,
 V01.verkaufsorganisation_id,
 V01.dat_bis,
 V01.laengengrad,
 V01.breitengrad,
 FIRST_VALUE(V01.laengengrad) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(COALESCE(V04.aktuell_wup_id, V01.aktuell_wup_id) AS STRING)
    ORDER BY V01.dat_von IS NULL, V01.dat_von RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 akt_laengengrad,
 FIRST_VALUE(V01.breitengrad) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(COALESCE(V04.aktuell_wup_id, V01.aktuell_wup_id) AS STRING)
    ORDER BY V01.dat_von IS NULL, V01.dat_von RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 akt_breitengrad,
 V01.kreistyp_gruppe_id,
  CASE
  WHEN V01.vs_id IN (2, 7) AND V01.mandant_id = 1
  THEN 1
  WHEN V01.vs_id IN (1, 3) AND V01.mandant_id = 1
  THEN 2
  WHEN V01.vs_id IN (6, 8) AND V01.mandant_id = 1
  THEN 3
  ELSE NULL
  END AS wreg_id,
 V01.wup_aenderung_grund_id
FROM kfl_production_dbp_view.v_wup AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_vaus_wup AS V03 ON V01.wup_id = V03.wup_id AND V01.mandant_id = V03.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wup AS V04 ON V01.mandant_id = V04.mandant_id AND V01.wup_id = V04.wup_id_alt AND
   V01.nb_id = V04.nb_id
WHERE V01.nb_id IN (- 2, - 1, 0, 2, 6, 7) AND V01.dat_eroeffnung > PARSE_DATE('%F', '1900-01-01')
 OR V01.nb_id IN (- 111, 99);