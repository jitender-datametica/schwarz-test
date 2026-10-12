CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ivs_flaeche_per AS SELECT FL.mandant_id,
 FL.flaeche_id,
 FL.flaeche_bez,
 FL.dat_von,
 FL.dat_bis,
 mfszp.flaeche_status_id_ AS flaeche_status_id,
 FL.immo_objekt_id,
 FL.gebaeude_id,
 FL.etage,
 FL.nutzung_id,
 FL.flaeche_groesse,
 FL.flaecheart_id,
 FL.dat_existiert_seit,
 FL.dat_existiert_bis,
 FL.flaeche_typ_id,
  CASE
  WHEN FL.flaecheart_id IN ('I')
  THEN 4
  WHEN FL.flaecheart_id IN ('V')
  THEN 5
  WHEN FL.flaecheart_id IN ('T')
  THEN 7
  WHEN FL.flaecheart_id IN ('U')
  THEN 8
  WHEN FL.flaecheart_id IN ('A')
  THEN 9
  WHEN FL.nutzung_id IN (300)
  THEN 1
  WHEN FL.nutzung_id IN (310)
  THEN 2
  WHEN FL.nutzung_id IN (320)
  THEN 3
  ELSE 0
  END AS flaecheart_leerstand_id,
  CASE
  WHEN FL.flaecheart_id IN ('I')
  THEN 'zu vermarktende Flächen, nur mit Investitionsaufwand'
  WHEN FL.flaecheart_id IN ('V')
  THEN 'Vermietungsflächen an Vertrieb'
  WHEN FL.flaecheart_id IN ('T')
  THEN 'Vetriebsflächen an Vermietung'
  WHEN FL.flaecheart_id IN ('U')
  THEN 'Umbauflächen'
  WHEN FL.flaecheart_id IN ('A')
  THEN 'zu vermietende Allgemeinflächen'
  WHEN FL.nutzung_id IN (300)
  THEN 'Handelsflächen'
  WHEN FL.nutzung_id IN (310)
  THEN 'Sonderflächen'
  WHEN FL.nutzung_id IN (320)
  THEN 'Wohnungen'
  ELSE 'nicht definiert'
  END AS flaecheart_leerstand_bez,
  CASE
  WHEN FL.gebaeude_id IN ('070')
  THEN 6
  WHEN FL.flaeche_typ_id = 30
  THEN 5
  WHEN FL.nutzung_id IN (310)
  THEN 1
  WHEN FL.nutzung_id IN (300) AND FL.flaeche_groesse < 200
  THEN 2
  WHEN FL.nutzung_id IN (300) AND FL.flaeche_groesse >= 200
  THEN 3
  WHEN FL.nutzung_id IN (320)
  THEN 4
  ELSE 0
  END AS flaeche_kategorie_id,
  CASE
  WHEN FL.gebaeude_id IN ('070')
  THEN 'Freiflaechen'
  WHEN FL.flaeche_typ_id = 30
  THEN 'SB-Warenhaus'
  WHEN FL.nutzung_id IN (310)
  THEN 'Gewerbeflaechen'
  WHEN FL.nutzung_id IN (300) AND FL.flaeche_groesse < 200
  THEN 'Handelsflaechen < 200m\u00b2'
  WHEN FL.nutzung_id IN (300) AND FL.flaeche_groesse >= 200
  THEN 'Handelsflaechen >= 200m\u00b2'
  WHEN FL.nutzung_id IN (320)
  THEN 'Wohnungen'
  ELSE 'nicht definiert'
  END AS flaeche_kategorie_bez,
 FS.std_branche_id,
 FS.std_vertragart_id,
  FS.std_miete_betrag * KURS.kurs AS std_miete_betrag,
  FS.std_miete_qm_betrag * KURS.kurs AS std_miete_qm_betrag,
 FS.std_miete_prozent,
 KURS.wrg_id
FROM kfl_production_dbp_view.v_ivs_flaeche_per AS FL
 INNER JOIN kfl_production_dbp_view.v_ivs_flaeche_standard_per AS FS ON FL.mandant_id = FS.mandant_id AND FL.flaeche_id
    = FS.flaeche_id AND FL.dat_bis = FS.dat_bis
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per AS KURS ON FL.mandant_id = KURS.mandant_id
 INNER JOIN (SELECT mandant_id,
   flaeche_id,
   MAX(flaeche_status_id) AS flaeche_status_id_
  FROM kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per
  WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
  GROUP BY mandant_id,
   flaeche_id) AS mfszp ON FL.mandant_id = mfszp.mandant_id AND FL.flaeche_id = mfszp.flaeche_id
WHERE FL.dat_bis = DATE '9999-12-31';