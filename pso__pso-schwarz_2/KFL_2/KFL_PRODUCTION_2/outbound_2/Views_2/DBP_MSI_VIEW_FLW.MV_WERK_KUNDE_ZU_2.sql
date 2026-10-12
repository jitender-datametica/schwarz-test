-- Zuorndung Werk - Kunde auf WG Ebene
 -- Filtern auf geoeffnete, deutsche Maerkte

-- Ermittlung in_kunde_id zur wup_id
 -- zur Filterung auf relevante Maerkte

-- eigenes Attribut fuer Werk anlegen - Werk (Kundenzu) - da zwischen Werk und Kunde keine Beziehung angelegt werden darf

-- 13.05.2019 pjan: AP0043250, SPEC0054321 including werk_nr 6911
 -- keine alten Zuordnungen

-- Diese Stammdatenbeziehung wuerde in vielen Berichten greifen, statt beide Infos aus der Fakttabelle zu holen, was die Ergebnisse verfaelschen wuerde

-- Fuer Werke Heilbronn und Bad Heiligenstadt gibt es keine Zuordnung in der Tabelle, sie beliefern alle deutschen Maerkte

-- 15.09.2017 twie: SPEC0026009 Zuordnung Werke und belieferte Maerkte (Kunden), nur fuer DE

-- Deshalb CROSS JOIN zwischen Werk und Kunde als Zuordnung ausgeben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_werk_kunde_zu_2 (werk_id, mandant_id, in_kunde_id) AS SELECT V04
 .werk_id,
 V04.mandant_id,
 V03.flw_kunde_id AS in_kunde_id
FROM kfl_production_dbp_view.v_vz_wg_wup_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id AND V01
   .nb_id = V02.nb_id -- Ermittlung in_kunde_id zur wup_id

 INNER JOIN kfl_production_dbp_view.v_flw_kunde_2 AS V03 ON V02.wup_id = V03.wup_id AND V02.mandant_id = V03.mandant_id
   -- Ermittlung werk_id zur vz_wup_id

 INNER JOIN kfl_production_dbp_view.v_flw_werk_2 AS V04 ON SUBSTR(CAST(V01.vz_wup_id AS STRING), 1, 4) = V04.werk_nr AND
   V01.mandant_id = V04.mandant_id -- aktuelle Sicht auf geoeffnete Maerkte

 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V05 ON V05.akt_tag = 0
WHERE V01.vz_wup_id IN (6912, 6916) -- Zuorndung gilt nur fuer diese beiden Werke (fuer 6921 + 6922 s.u.)

 AND V01.dat_bis = DATE '9999-12-31'
 AND V01.mandant_id = 1
 AND V01.nb_id = 0
 AND V02.getraenkemarkt_fg = 0
 AND V05.dat BETWEEN V02.dat_eroeffnung AND V02.dat_bis
  -- Gruppierung auf Werk und Kunde, da Zuordung in Tabelle auf WG Ebene. Es genuegt aber ein Eintrag fuer eine_2 WG damit die Zuordnung gueltig ist

  
GROUP BY V04.werk_id,
 V04.mandant_id,
 in_kunde_id
UNION DISTINCT
SELECT v01.werk_id,
 v01.mandant_id,
 V03.flw_kunde_id AS in_kunde_id
FROM (SELECT werk_id,
   mandant_id
  FROM kfl_production_dbp_view.v_flw_werk_2
  WHERE werk_nr IN ('6921', '6922', '6911')) AS v01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_flw_kunde_2 AS V03 ON V02.wup_id = V03.wup_id AND V02.mandant_id = V03.mandant_id
   -- aktuelle Sicht auf geoeffnete Maerkte

 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V04 ON V04.dat BETWEEN V02.dat_eroeffnung AND V02.dat_bis
WHERE V04.akt_tag = 0 -- Filtern auf geoeffnete, deutsche Maerkte

 AND V02.mandant_id = 1
 AND V02.nb_id = 0
 AND V02.getraenkemarkt_fg = 0;