CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wup_1 (wup_id, aktuell_wup_id, nb_id, mandant_id, land_id,
dat_von, wup_typ_id, vs_id, vw_id, wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id,
getraenkemarkt_fg, hl_id, dat_bis, uebernahme_von, breakevenumsatz, systemrentabilitaet, verkaufsflaeche,
betriebsflaeche, fleischsystem, preiskategorie_food, preiskategorie_nonfood, sortkategorie_food, sortkategorie_nonfood,
sondermarkt, ref_wup_id, wm_id, kassentyp, lead_mwst, region_id, kundenfaktor, vz_wup_id, qbm_id, wup_id_alt,
buchungskreis_id, verkaufsorganisation_id, system_id, open_fg, laengengrad, breitengrad, kreistyp_gruppe_id) AS SELECT
 V01.wup_id,
 COALESCE(V02.aktuell_wup_id, V01.aktuell_wup_id) AS aktuell_wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.land_id,
 V01.dat_von,
 V01.wup_typ_id,
 V01.vs_id,
 V01.vw_id,
 V01.wup_name_v,
 V01.wup_name_e,
  CASE
  WHEN V01.dat_bis < DATE '9999-12-31'
  THEN CHR(123) || V01.wup_standort || CHR(125)
  ELSE V01.wup_standort
  END AS wup_standort,
 V01.wup_plz,
 V01.wup_str,
 V01.vf_id,
 V01.vkl_id,
 V01.getraenkemarkt_fg,
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
 V01.lead_mwst,
 V01.region_id,
 V01.kundenfaktor,
 V01.vz_wup_id,
 V01.qbm_id,
 V01.wup_id_alt,
 V01.buchungskreis_id,
 V01.verkaufsorganisation_id,
 7 AS system_id,
  CASE
  WHEN V01.dat_von <= CURRENT_DATE AND V01.dat_bis = DATE '9999-12-31'
  THEN 1
  ELSE CASE
   WHEN V01.dat_bis < DATE '9999-12-31'
   THEN 2
   ELSE CASE
    WHEN V01.dat_von > CURRENT_DATE AND V01.dat_bis = DATE '9999-12-31'
    THEN 3
    ELSE 0
    END
   END
  END AS open_fg,
 V01.laengengrad,
 V01.breitengrad,
 V01.kreistyp_gruppe_id
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id_alt AND
   V01.nb_id = V02.nb_id
WHERE V01.mandant_id = 1
 AND (V01.nb_id IN (0, -111, 2, 99) OR V01.wup_id = 0 AND V01.nb_id = -1 OR V01.nb_id = -1 AND V01.vw_id = 6);