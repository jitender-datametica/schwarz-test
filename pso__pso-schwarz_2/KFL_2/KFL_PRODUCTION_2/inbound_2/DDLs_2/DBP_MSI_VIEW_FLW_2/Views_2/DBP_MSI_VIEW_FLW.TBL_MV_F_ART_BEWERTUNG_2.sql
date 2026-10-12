CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_ART_BEWERTUNG_2
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
 
(
mandant_id
--, system_id
, werk_id
, werk_nr
, werk_name
, bewertungskreis_id
, in_art_id
, preis_steuer_kz
, gld
, standard_preis
, preis_faktor
, dat_von
, dat_bis
, umrech_faktor
, dat
,wrg_id
,default_wrg
,basismenge_einh_id
)
AS
   SELECT
   v03.mandant_id, 
   v03.werk_id, 
   v03.werk_nr, 
   v03.werk_name, 
   v04.bewertungskreis_id, 
   v04.flw_art_id AS in_art_id, 
   v04.preis_steuer_kz, 
   v04.gld, 
   v04.standard_preis, 
   v04.preis_faktor, 
   v04.dat_von, 
   v04.dat_bis,
   v06.umrech_faktor,   
   t.dat, 
   v04.wrg_id,
   v100.default_wrg,
   v05.basismenge_einh_id

   -- Ermittlung der Zuordnung werk_id zu wup_id, zur Aufloesung fuer bewertungskreis_id aus in_art_bewertungkreis_per
   FROM
   dbp_view.v_flw_werk_2 v03

   -- Ermittlung Standardpreis oder GLD aus MBEW
   JOIN
   --dbp_view.v_flw_art_bewertungskreis_per_2 v04 -- wurde durch die untere Zeile ersetzt, damit die Materialsierung schneller läuft
   (SELECT * FROM dbp_view.v_flw_art_bewertungskreis_per_2 ORDER BY RANDOM()) v04 -- Performance optimierung der überliegenden Zeile
   ON v03.mandant_id  = v04.mandant_id
   AND v03.werk_nr = v04.bewertungskreis_id

   JOIN dbp_view.v_flw_art_2 v05
   ON v04.mandant_id  = v05.mandant_id
   AND v04.flw_art_id = v05.flw_art_id
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v06
   ON v05.mandant_id  = v06.mandant_id
   AND v05.flw_art_id = v06.flw_art_id
   AND (CASE
   WHEN v05.basismenge_einh_id = 'ST' THEN 'KG'
   WHEN v05.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v06.altnv_menge_einh_id

   JOIN dbp_view.v_tag_2 t
   ON t.dat BETWEEN v04.dat_von AND v04.dat_bis

   JOIN dbp_view.v_mandant_2 v100
   ON v03.mandant_id = v100.mandant_id
  
   WHERE v03.mandant_id IN (1,2);