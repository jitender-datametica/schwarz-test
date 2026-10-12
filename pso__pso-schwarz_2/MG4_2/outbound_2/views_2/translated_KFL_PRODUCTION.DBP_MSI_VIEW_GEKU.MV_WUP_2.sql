CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_wup_2 (wup_id, nb_id, mandant_id, land_id, dat_von, wup_typ_id
, wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id, hl_id, dat_bis, uebernahme_von, breakevenumsatz
, systemrentabilitaet, verkaufsflaeche, betriebsflaeche, fleischsystem, preiskategorie_food, preiskategorie_nonfood,
sortkategorie_food, sortkategorie_nonfood, sondermarkt, ref_wup_id, wm_id, kassentyp, dat_qbm_umstellung, lead_mwst,
region_id, kundenfaktor, vz_wup_id, markt, getraenkemarkt_fg, vw_id, vs_id, verkaufsorganisation_id, laengengrad,
breitengrad) AS SELECT wup_id,
 nb_id,
 mandant_id,
 land_id,
 dat_von,
 wup_typ_id,
 wup_name_v,
 wup_name_e,
  CASE
  WHEN wup_id = 0
  THEN land_id || ' (unbekannt)'
  ELSE wup_standort
  END AS wup_standort,
 wup_plz,
 wup_str,
 vf_id,
 vkl_id,
 hl_id,
 dat_bis,
 uebernahme_von,
 breakevenumsatz,
 systemrentabilitaet,
 verkaufsflaeche,
 betriebsflaeche,
 fleischsystem,
 preiskategorie_food,
 preiskategorie_nonfood,
 sortkategorie_food,
 sortkategorie_nonfood,
 sondermarkt,
 ref_wup_id,
 wm_id,
 kassentyp,
 dat_qbm_umstellung,
 lead_mwst,
 region_id,
 kundenfaktor,
 vz_wup_id,
 TRIM(CAST(wup_id AS STRING) || ' ' || wup_standort) AS markt,
 getraenkemarkt_fg,
  CASE
  WHEN mandant_id = 1 AND vw_id NOT IN (1, 2, 3) OR mandant_id <> 1
  THEN 0
  ELSE vw_id
  END AS vw_id,
 vs_id,
 verkaufsorganisation_id,
 laengengrad,
 breitengrad
FROM kfl_production_dbp_view.v_wup_2
WHERE (nb_id = 0 AND dat_von < CURRENT_DATE AND dat_eroeffnung < CURRENT_DATE AND umzugsfiliale_fg = 0 OR wup_id = 0 OR
      nb_id = - 1 AND vkl_id = wup_id AND mandant_id = 1)
 AND wup_id = aktuell_wup_id;