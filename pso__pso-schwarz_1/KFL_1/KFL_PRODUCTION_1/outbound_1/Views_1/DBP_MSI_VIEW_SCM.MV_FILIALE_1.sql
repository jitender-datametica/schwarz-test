CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_filiale_1 (wup_id, aktuell_wup_id, is_akt_wup_id_fg, nb_id,
mandant_id, land_id, dat_von, wup_typ_id, wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id, hl_id,
dat_bis, uebernahme_von, breakevenumsatz, systemrentabilitaet, verkaufsflaeche, betriebsflaeche, fleischsystem,
preiskategorie_food, preiskategorie_nonfood, sortkategorie_food, sortkategorie_nonfood, sondermarkt, ref_wup_id, wm_id,
kassentyp, dat_qbm_umstellung, lead_mwst, region_id, kundenfaktor, vz_wup_id, qbm_id, getraenkemarkt_fg, vs_id,
buchungskreis_id, verkaufsorganisation_id, breitengrad, laengengrad, kreistyp_gruppe_id, frische_manager_id) AS SELECT
 V01.wup_id,
 V01.aktuell_wup_id,
  CASE
  WHEN V01.aktuell_wup_id = V01.wup_id
  THEN 1
  ELSE 0
  END AS is_akt_wup_id_fg,
  CASE
  WHEN V01.wup_id = - 1
  THEN 0
  ELSE V01.nb_id
  END AS nb_id,
 V01.mandant_id,
 V01.land_id,
 V01.dat_von,
 V01.wup_typ_id,
 V01.wup_name_v,
 V01.wup_name_e,
 V01.wup_standort,
 V01.wup_plz,
 V01.wup_str,
 V01.vf_id,
 V01.vkl_id,
 V01.hl_id,
 V01.dat_bis,
 V01.uebernahme_von,
 V01.breakevenumsatz,
 V01.systemrentabilitaet,
 V01.verkaufsflaeche,
 V01.betriebsflaeche,
 V01.fleischsystem,
 V01.preiskategorie_food,
 V01.preiskategorie_nonfood,
 V01.sortkategorie_food,
 V01.sortkategorie_nonfood,
 V01.sondermarkt,
 V01.ref_wup_id,
 V01.wm_id,
 V01.kassentyp,
 V01.dat_qbm_umstellung,
 V01.lead_mwst,
 V01.region_id,
 V01.kundenfaktor,
 V01.vz_wup_id,
  CASE
  WHEN V01.dat_qbm_umstellung IS NOT NULL
  THEN 1
  ELSE 0
  END AS qbm_id,
 V01.getraenkemarkt_fg,
  CASE
  WHEN V01.mandant_id <> 1 AND V01.vs_id IS NULL
  THEN 0
  WHEN V01.wup_id = - 1
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE V01.vs_id
  END AS vs_id,
 V01.buchungskreis_id,
 V01.verkaufsorganisation_id,
 V01.breitengrad,
 V01.laengengrad,
 COALESCE(V01.kreistyp_gruppe_id, '') AS kreistyp_gruppe_id,
 V02.frische_manager_id
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
   
WHERE V01.nb_id = 0
 OR V01.wup_id = - 1;