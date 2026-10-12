CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup (mandant_id, nb_id, haupt_wup_id, land_id, wup_id,
orig_wup_id, wup_standort, dat_eroeffnung, dat_von, dat_bis, dat_geschlossen, dat_wiedereroeffnung, dat_steckbrief,
wup_id_alt, dat_umzug, wup_aenderung_grund_id, dat_umgliederung, dat_letzte_modernisierung_von,
dat_letzte_modernisierung_bis, dat_letzte_modernisierung_von2, dat_letzter__facelift_von, dat_letzter_facelift, dummy,
vs_id, gf_id, vkl_id, wm_id, hl_id, vw_id, vf_id, region_id, wup_str, wup_plz, wup_stadt, wup_telefon, wup_telefax,
betriebsrat_fg, buchungskreis_id, vaus_wup_name, auflage_wup_verteilgebiet, auflage_wup_auslage, nils_verteilgebiet_id,
verteilgebiet_uid, auflage_verteilgebiet, gln_id, kunde_id, umsatz_erwartung_eur, einwohner_anzahl, eigentum_miete_kz,
verkaufsflaeche, betriebsflaeche, uebernahme_von, uebernahme_real, umsatz_ea, umsatz_woche, umsatz_ea_eur,
umsatz_ea_land, kundenfaktor, getraenkemarkt_fg, getraenke_markt_fg, dat_qbm_umstellung, qbm_id, dat_umstellung_waage,
breitengrad, laengengrad, gis_quali_id, vdat, edat, sdat, gj_eroeffnung, gj_schliessung, kjmo_eroeffnung,
kjmo_schliessung, kjmo_umzug, preiskategorie_food, preiskategorie_nonfood, sortkategorie_food, sortkategorie_nonfood,
wup_typ_id, wup_name_v, wup_name_e, lead_mwst, breakevenumsatz, systemrentabilitaet, fleischsystem, sondermarkt,
ref_wup_id, kassentyp, vz_wup_id, verkaufsorganisation_id, bewertungskreis_id, kreistyp_gruppe_id, filialtyp_id,
etagen_anz, vaus_wup_stadt, system_id) AS SELECT V01.mandant_id,
 V01.nb_id,
  CASE
  WHEN V01.nb_id = -1 AND V01.vs_id = 1
  THEN 43
  WHEN V01.nb_id = -1 AND V01.vs_id = 2
  THEN 22
  WHEN V01.nb_id = -1 AND V01.vs_id = 3
  THEN 46
  WHEN V01.nb_id = -1 AND V01.vs_id = 6
  THEN 124
  WHEN V01.nb_id = -1 AND V01.vs_id = 7
  THEN 2
  WHEN V01.nb_id = -1 AND V01.vs_id = 8
  THEN 28
  WHEN V01.nb_id = -1
  THEN 0
  ELSE COALESCE(V01.haupt_wup_id, V01.wup_id)
  END AS haupt_wup_id,
 V01.land_id,
 V01.wup_id,
 V01.orig_wup_id,
 V01.wup_standort,
 COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) AS dat_eroeffnung,
 COALESCE(V01.dat_von_alt, V01.dat_von) AS dat_von,
 V01.dat_bis,
  CASE
  WHEN V01.dat_bis < DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY)
  THEN V01.dat_bis
  ELSE NULL
  END AS dat_geschlossen,
 V01.dat_wiedereroeffnung,
 COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung) AS dat_steckbrief,
 V01.wup_id_alt,
  CASE
  WHEN V01.wup_id_alt > 1
  THEN V01.dat_eroeffnung
  ELSE NULL
  END AS dat_umzug,
 V01.wup_aenderung_grund_id,
  CASE
  WHEN V01.wup_id <> V01.orig_wup_id
  THEN V01.dat_eroeffnung
  ELSE NULL
  END AS dat_umgliederung,
 V01.dat_letzte_modernisierung_von,
 V01.dat_letzte_modernisierung_bis,
 COALESCE(V01.dat_letzte_modernisierung_von, V01.dat_letzte_modernisierung_bis) AS dat_letzte_modernisierung_von2,
 V01.dat_letzter__facelift_von,
 V01.dat_letzter_facelift,
   (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1 AS dummy,
  CASE
  WHEN V01.vs_id >= 0
  THEN V01.vs_id
  ELSE 0
  END AS vs_id,
  CASE
  WHEN V01.gf_id > 0
  THEN V01.gf_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1
  END AS gf_id,
  CASE
  WHEN V01.vkl_id > 0
  THEN V01.vkl_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1
  END AS vkl_id,
  CASE
  WHEN V01.wm_id > 0
  THEN V01.wm_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1
  END AS wm_id,
  CASE
  WHEN V01.hl_id > 0
  THEN V01.hl_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * -1
  END AS hl_id,
 V01.vw_id,
 V01.vf_id,
 COALESCE(V03.region_id, V01.region_id, -V01.mandant_id) AS region_id,
 COALESCE(V03.wup_str, V01.wup_str, '') AS wup_str,
 COALESCE(V03.wup_plz, V01.wup_plz) AS wup_plz,
 COALESCE(V03.wup_stadt_1, V01.wup_stadt, '') AS wup_stadt,
 COALESCE(V03.wup_telefon, '') AS wup_telefon,
 COALESCE(V03.wup_fax, '') AS wup_telefax,
 COALESCE(V03.betriebsrat_fg, -1) AS betriebsrat_fg,
 COALESCE(V03.buchungskreis_id, -1) AS buchungskreis_id,
 COALESCE(V03.wup_name_1, '') AS vaus_wup_name,
 V03.auflage_wup_verteilgebiet,
 V03.auflage_wup_auslage,
 V03.nils_verteilgebiet_id,
 V04.verteilgebiet_uid,
 SUM(V03.auflage_wup_verteilgebiet) OVER (PARTITION BY V01.mandant_id, V03.nils_verteilgebiet_id ORDER BY V01.mandant_id
    NULLS LAST, V03.nils_verteilgebiet_id NULLS LAST, V01.wup_id NULLS LAST RANGE BETWEEN UNBOUNDED PRECEDING AND
  CURRENT ROW) AS auflage_verteilgebiet,
 V03.gln_id,
 V03.kunde_id,
 V01.umsatz_erwartung_eur,
 V01.einwohner_anzahl,
 COALESCE(V01.eigentum_miete_kz, '') AS eigentum_miete_kz,
 V01.verkaufsflaeche,
 V01.betriebsflaeche,
 V01.uebernahme_von,
  CASE
  WHEN SUBSTR(V01.uebernahme_von, 1, 8) = 'real 202'
  THEN 'Real'
  ELSE 'Bestand'
  END AS uebernahme_real,
 CAST(ROUND(V01.umsatz_ea_eur / 1000) AS INTEGER) AS umsatz_ea,
 CAST(ROUND(V01.umsatz_ea_eur / 53000) AS INTEGER) AS umsatz_woche,
 V01.umsatz_ea_eur,
 V01.umsatz_ea_land,
 V01.kundenfaktor,
 V01.getraenkemarkt_fg,
  CASE
  WHEN V01.kundenfaktor < 1.000
  THEN 1
  ELSE 0
  END AS getraenke_markt_fg,
 V01.dat_qbm_umstellung,
 V01.qbm_id,
 V01.dat_umstellung_waage,
 V01.breitengrad,
 V01.laengengrad,
 V01.gis_quali_id,
 COALESCE(V01.dat_von_alt, V01.dat_von) AS vdat,
 COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) AS edat,
 V01.dat_bis AS sdat,
  CASE
  WHEN COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) <= CURRENT_DATE
  THEN CAST(EXTRACT(YEAR FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) + CASE
     WHEN EXTRACT(MONTH FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) < 3
     THEN -1
     ELSE 0
     END AS INTEGER)
  ELSE 0
  END AS gj_eroeffnung,
  CASE
  WHEN V01.dat_bis <= CURRENT_DATE
  THEN CAST(EXTRACT(YEAR FROM V01.dat_bis) + CASE
     WHEN EXTRACT(MONTH FROM V01.dat_bis) < 3
     THEN -1
     ELSE 0
     END AS INTEGER)
  ELSE 0
  END AS gj_schliessung,
  CASE
  WHEN COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) <= CURRENT_DATE
  THEN CAST(EXTRACT(YEAR FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) * 100 + EXTRACT(MONTH FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) AS INTEGER)
  ELSE 0
  END AS kjmo_eroeffnung,
  CASE
  WHEN V01.dat_bis <= CURRENT_DATE
  THEN CAST(EXTRACT(YEAR FROM V01.dat_bis) * 100 + EXTRACT(MONTH FROM V01.dat_bis) AS INTEGER)
  ELSE 0
  END AS kjmo_schliessung,
  CASE
  WHEN V01.wup_id_alt > 1
  THEN CAST(EXTRACT(YEAR FROM V01.dat_eroeffnung) * 100 + EXTRACT(MONTH FROM V01.dat_eroeffnung) AS INTEGER)
  ELSE 0
  END AS kjmo_umzug,
 V01.preiskategorie_food,
 V01.preiskategorie_nonfood,
 V01.sortkategorie_food,
 V01.sortkategorie_nonfood,
 V01.wup_typ_id,
 V01.wup_name_v,
 V01.wup_name_e,
 V01.lead_mwst,
 V01.breakevenumsatz,
 V01.systemrentabilitaet,
 V01.fleischsystem,
 V01.sondermarkt,
 V01.ref_wup_id,
 V01.kassentyp,
 V01.vz_wup_id,
 V01.verkaufsorganisation_id,
 V01.bewertungskreis_id,
 V01.kreistyp_gruppe_id,
 V01.filialtyp_id,
 V01.etagen_anz,
 V03.wup_stadt_1 AS vaus_wup_stadt,
 V03.system_id
FROM kfl_production_dbp_view.v_wup AS V01
 LEFT JOIN kfl_production_dbp_view.v_vaus_wup AS V03 ON V01.wup_id = V03.wup_id AND V01.mandant_id = V03.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_geku_verteilgebiet AS V04 ON V03.nils_verteilgebiet_id = V04.nils_verteilgebiet_id
  AND V03.mandant_id = V04.mandant_id
WHERE V01.nb_id IN (-2, -1, 0, 2, 7)
 AND V01.dat_von > DATE '1900-01-01'
 AND V01.dat_eroeffnung > DATE '1900-01-01'
 AND V01.umzugsfiliale_fg = 0
 AND V01.wup_id = V01.aktuell_wup_id;