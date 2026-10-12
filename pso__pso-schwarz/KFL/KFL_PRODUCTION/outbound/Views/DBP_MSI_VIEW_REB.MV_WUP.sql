CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_wup (wup_id, nb_id, mandant_id, aktuell_wup_id, land_id,
dat_von, wup_typ_id, wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id, hl_id, dat_bis,
uebernahme_von, verkaufsflaeche, betriebsflaeche, preiskategorie_food, preiskategorie_nonfood, sortkategorie_food,
sortkategorie_nonfood, sondermarkt, ref_wup_id, wm_id, kassentyp, dat_qbm_umstellung, kreistyp_gruppe_id,
dat_umstellung_waage, lead_mwst, region_id, vz_wup_id, markt, getraenkemarkt_fg, vs_id, verkaufsorganisation_id,
adresse_id, laengengrad, breitengrad) AS SELECT wup_id,
 nb_id,
 mandant_id,
 aktuell_wup_id,
 land_id,
  CASE
  WHEN wup_id = 2660
  THEN '2009-09-17'
  ELSE CAST(dat_von AS STRING)
  END AS dat_von,
 wup_typ_id,
 wup_name_v,
 wup_name_e,
 wup_standort,
 wup_plz,
 wup_str,
 vf_id,
 vkl_id,
 hl_id,
 dat_bis,
 uebernahme_von,
 verkaufsflaeche,
 betriebsflaeche,
 preiskategorie_food,
 preiskategorie_nonfood,
 sortkategorie_food,
 sortkategorie_nonfood,
 sondermarkt,
 ref_wup_id,
 wm_id,
 kassentyp,
 dat_qbm_umstellung,
 kreistyp_gruppe_id,
 dat_umstellung_waage,
 lead_mwst,
 region_id,
 vz_wup_id,
 TRIM(CAST(wup_id AS STRING) || ' ' || wup_standort) AS markt,
 getraenkemarkt_fg,
 vs_id,
 verkaufsorganisation_id,
 adresse_id,
 laengengrad,
 breitengrad
FROM kfl_production_dbp_view.v_wup
WHERE mandant_id = 1
 AND ((dat_eroeffnung < CURRENT_DATE OR dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL 45 DAY)) AND dat_von
     IS NOT NULL OR nb_id <> 0 OR wup_id = 9203)
 AND nb_id <> 99
 AND NOT wup_id BETWEEN 1 AND 999;