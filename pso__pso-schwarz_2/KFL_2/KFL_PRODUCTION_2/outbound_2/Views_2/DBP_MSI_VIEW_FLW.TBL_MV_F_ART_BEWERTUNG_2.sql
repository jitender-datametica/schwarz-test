-- 26.10.2011 system_id entfernt
 -- 22.10.2012 Filter auf mandant_id in (1,2)

-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
 -- , system_id

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_art_bewertung_2 (mandant_id, werk_id, werk_nr, werk_name,
bewertungskreis_id, in_art_id, preis_steuer_kz, gld, standard_preis, preis_faktor, dat_von, dat_bis, umrech_faktor, dat
, wrg_id, default_wrg, basismenge_einh_id) AS -- Ermittlung Standardpreis oder GLD aus MBEW

-- dbp_view.v_flw_art_bewertungskreis_per_2 v04

-- wurde durch die untere Zeile ersetzt, damit die Materialsierung schneller läuft

-- Performance optimierung der überliegenden Zeile
 SELECT V03.mandant_id,
 V03.werk_id,
 V03.werk_nr,
 V03.werk_name,
 v04.bewertungskreis_id,
 v04.flw_art_id AS in_art_id,
 v04.preis_steuer_kz,
 v04.gld,
 v04.standard_preis,
 v04.preis_faktor,
 v04.dat_von,
 v04.dat_bis,
 V06.umrech_faktor,
 T.dat,
 v04.wrg_id,
 V100.default_wrg,
 V05.basismenge_einh_id
 -- Ermittlung der Zuordnung werk_id zu wup_id, zur Aufloesung fuer bewertungskreis_id aus in_art_bewertungkreis_per

FROM kfl_production_dbp_view.v_flw_werk_2 AS V03
 INNER JOIN (SELECT mandant_id,
   flw_art_id,
   dat_von,
   bewertungskreis_id,
   system_id,
   dat_bis,
   preis_steuer_kz,
   gld,
   standard_preis,
   preis_faktor,
   wrg_id,
   td_insert,
   td_update
  FROM (SELECT mandant_id,
     flw_art_id,
     dat_von,
     bewertungskreis_id,
     system_id,
     dat_bis,
     preis_steuer_kz,
     gld,
     standard_preis,
     preis_faktor,
     wrg_id,
     td_insert,
     td_update,
     CAST((RAND() - 0.5) * POWER(10, 18) AS INTEGER) AS `A118613`
    FROM kfl_production_dbp_view.v_flw_art_bewertungskreis_per_2
    ORDER BY `A118613` NULLS LAST) AS t0) AS v04 ON V03.mandant_id = v04.mandant_id AND V03.werk_nr = v04.bewertungskreis_id
   
 INNER JOIN kfl_production_dbp_view.v_flw_art_2 AS V05 ON v04.mandant_id = V05.mandant_id AND v04.flw_art_id = V05.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_2 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.flw_art_id
     = V06.flw_art_id AND CASE
    WHEN V05.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V05.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V06.altnv_menge_einh_id
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON T.dat BETWEEN v04.dat_von AND v04.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V03.mandant_id = V100.mandant_id
WHERE V03.mandant_id IN (1, 2);