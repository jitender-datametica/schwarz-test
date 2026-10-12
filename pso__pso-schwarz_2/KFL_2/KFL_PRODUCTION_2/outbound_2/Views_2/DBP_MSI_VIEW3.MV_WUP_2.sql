CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wup_2 (wup_id, nb_id, mandant_id, land_id, dat_von, wup_typ_id,
wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id, hl_id, dat_bis, uebernahme_von, breakevenumsatz,
systemrentabilitaet, verkaufsflaeche, betriebsflaeche, fleischsystem, preiskategorie_food, preiskategorie_nonfood,
sortkategorie_food, sortkategorie_nonfood, sondermarkt, ref_wup_id, wm_id, kassentyp, dat_qbm_umstellung, lead_mwst,
region_id, kundenfaktor, vz_wup_id, markt, qbm_id, getraenkemarkt_fg, vs_id, buchungskreis_id, verkaufsorganisation_id,
breitengrad, laengengrad, aktuell_wup_id, is_akt_wup_id_fg, dat_wanko_von) AS SELECT W.wup_id,
 W.nb_id,
 W.mandant_id,
 W.land_id,
 W.dat_von,
 W.wup_typ_id,
 W.wup_name_v,
 W.wup_name_e,
 W.wup_standort,
 W.wup_plz,
 W.wup_str,
 W.vf_id,
 W.vkl_id,
 W.hl_id,
 W.dat_bis,
 W.uebernahme_von,
 W.breakevenumsatz,
 W.systemrentabilitaet,
 W.verkaufsflaeche,
 W.betriebsflaeche,
 W.fleischsystem,
 W.preiskategorie_food,
 W.preiskategorie_nonfood,
 W.sortkategorie_food,
 W.sortkategorie_nonfood,
 W.sondermarkt,
 W.ref_wup_id,
 W.wm_id,
 W.kassentyp,
 W.dat_qbm_umstellung,
 W.lead_mwst,
 W.region_id,
 W.kundenfaktor,
 W.vz_wup_id,
 TRIM(CAST(W.wup_id AS STRING) || ' ' || W.wup_standort) AS markt,
  CASE
  WHEN W.dat_qbm_umstellung IS NOT NULL
  THEN 1
  ELSE 0
  END AS qbm_id,
 W.getraenkemarkt_fg,
 W.vw_id AS vs_id,
 W.buchungskreis_id,
 W.verkaufsorganisation_id,
 W.breitengrad,
 W.laengengrad,
 W.aktuell_wup_id,
  CASE
  WHEN W.aktuell_wup_id = W.wup_id
  THEN 1
  ELSE 0
  END AS is_akt_wup_id_fg,
 COALESCE(dat_wanko.dat_wanko_von, DATE '9999-12-31') AS dat_wanko_von
FROM kfl_production_dbp_view.v_wup_2 AS W
 LEFT JOIN (SELECT V01.mandant_id,
   V00.wup_id,
   MIN(COALESCE(V00.dat_tms_wanko, DATE '9999-12-31')) AS dat_wanko_von
  FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm_2 AS V00
   INNER JOIN kfl_production_dbp_view.v_tms_gp_2 AS V01 ON V00.mandant_id = V01.mandant_id AND ROUND(SAFE_CAST(V01.tms_gp_id
        AS BIGNUMERIC), 0) = V00.wup_id AND V00.nb_id = - 111
  WHERE V01.tms_gp_typ_cd = 'L'
  GROUP BY V01.mandant_id,
   V00.wup_id) AS dat_wanko ON W.wup_id = dat_wanko.wup_id AND W.mandant_id = dat_wanko.mandant_id;