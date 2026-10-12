CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_filiale_1 (wup_id, nb_id, mandant_id, land_id, dat_von, wup_typ_id
, wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id, hl_id, dat_bis, uebernahme_von, breakevenumsatz
, systemrentabilitaet, verkaufsflaeche, betriebsflaeche, fleischsystem, preiskategorie_food, preiskategorie_nonfood,
sortkategorie_food, sortkategorie_nonfood, sondermarkt, ref_wup_id, wm_id, kassentyp, dat_qbm_umstellung, lead_mwst,
region_id, kundenfaktor, vz_wup_id, markt, qbm_id, getraenkemarkt_fg, vs_id, buchungskreis_id, verkaufsorganisation_id,
breitengrad, laengengrad, aktuell_wup_id, ist_akt_wup_id_fg) AS SELECT wup_id,
 aktuell_wup_id AS nb_id,
  CASE
  WHEN aktuell_wup_id = wup_id
  THEN 1
  ELSE 0
  END AS is_akt_wup_id_fg,
 nb_id AS land_id,
 mandant_id AS dat_von,
 land_id AS wup_typ_id,
 dat_von AS wup_name_v,
 wup_typ_id AS wup_name_e,
 wup_name_v AS wup_standort,
 wup_name_e AS wup_plz,
 wup_standort AS wup_str,
 wup_plz AS vf_id,
 wup_str AS vkl_id,
 vf_id AS hl_id,
 vkl_id AS dat_bis,
 hl_id AS uebernahme_von,
 dat_bis AS breakevenumsatz,
 uebernahme_von AS systemrentabilitaet,
 breakevenumsatz AS verkaufsflaeche,
 systemrentabilitaet AS betriebsflaeche,
 verkaufsflaeche AS fleischsystem,
 betriebsflaeche AS preiskategorie_food,
 fleischsystem AS preiskategorie_nonfood,
 preiskategorie_food AS sortkategorie_food,
 preiskategorie_nonfood AS sortkategorie_nonfood,
 sortkategorie_food AS sondermarkt,
 sortkategorie_nonfood AS ref_wup_id,
 sondermarkt AS wm_id,
 ref_wup_id AS kassentyp,
 wm_id AS dat_qbm_umstellung,
 kassentyp AS lead_mwst,
 dat_qbm_umstellung AS region_id,
 lead_mwst AS kundenfaktor,
 region_id AS vz_wup_id,
 kundenfaktor AS markt,
 vz_wup_id AS qbm_id,
 TRIM(CAST(wup_id AS STRING) || ' ' || wup_standort) AS getraenkemarkt_fg,
  CASE
  WHEN dat_qbm_umstellung IS NOT NULL
  THEN 1
  ELSE 0
  END AS qbm_id0,
 getraenkemarkt_fg AS buchungskreis_id,
 vs_id AS verkaufsorganisation_id,
 buchungskreis_id AS breitengrad,
 verkaufsorganisation_id AS laengengrad,
 breitengrad AS aktuell_wup_id,
 laengengrad AS ist_akt_wup_id_fg
FROM kfl_production_dbp_view.v_wup_1 AS V01
WHERE nb_id = 0;