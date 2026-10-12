/*
#----------------------------------------------------------------------------
# Source Safe Info
#----------------------------------------------------------------------------
# Skriptname             : kmo_wpuums_rfi_freigabe.btq
# Aktuelle Version       : 1.0
# Check-Out Datum        : 06.11.2008
# Version-erstellt Datum : 06.11.2008
#----------------------------------------------------------------------------
# Projekt : TP2_AIS/TP1_MIS
# Comment : automatische RFI_Freigabe, wenn fehlende Stammdaten zwischenzeitlich 
#           vorhanden sind 
# Source  : dbp_etl_rfi.kmo_wpuums
# Target  : dbp_etl.kmo_wpuums 
#----------------------------------------------------------------------------
# History:
# 06.11.2008  Michael Ueding   Ersterstellung
# 19.08.2009  Michael Ueding   Automatische Freigabe RFI Fehler 40031 wenn 
#                              Eroeffnungsdatum Markt vor dem Belegdatum liegt.
# ...
# 18.05.2011  Michael Ueding   Entfernen der Selektion nach Quellkennzeichen
# 25.02.2016  Ulrike Hofmann   durch Abloesung TCURR ueber ABI entfaellt Process-Tabelle
# 12.11.2018  Dennis Bayraktar Umstellung auf "as is"-Sicht fuer WGs.
#----------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf Datenbank
#    2.) Hilfstabellen fuer Join auf Artikel und Markt anlegen
#    3.) Hilfstabellen fuellen
#    4.) Kroatische Artikelnummer 989999 auf 980000 umsetzen.
#    5.) Freigabe, wenn referentielle Integritaet zwischenzeitlich gegeben ist.
#    6.) Hilfstabellen loeschen
#    7.) BTEQ beenden
#----------------------------------------------------------------------------
*/

/*
#------------------------------------------------------------------------------
# 1.) Logon auf Datenbank
#------------------------------------------------------------------------------
*/


/*
#-------------------------------------------------------------------------------
# 2.) Hilfstabellen fuer Join auf Artikel und Markt anlegen
#-------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_art_map;

CREATE  TABLE dbp_etl.kmo_wpuums_art_map 
(
  landkz    CHAR( 3)  NOT NULL, 
  artnr     CHAR(25) ,
  kl_art_id INTEGER NOT NULL
)
;


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_wup_map;

CREATE  TABLE dbp_etl.kmo_wpuums_wup_map 
(
  landkz  CHAR( 3)  NOT NULL,
  filnr   CHAR(10) ,
  wup_id  INTEGER NOT NULL
)
;




/*
#------------------------------------------------------------------------------
# 3.) Hilfstabellen fuellen
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.kmo_wpuums_art_map
(
   landkz
  ,artnr
  ,kl_art_id
)
SELECT 
   landkz
  ,artnr
  ,artnr
FROM dbp_etl_rfi.kmo_wpuums
WHERE rfi_id < 20000   -- Datentyppruefung erfolgreich bestanden
GROUP BY 1, 2, 3
;


  
INSERT INTO dbp_etl.kmo_wpuums_wup_map
(
   landkz
  ,filnr
  ,wup_id
)
SELECT 
   landkz
  ,filnr
  ,filnr
FROM dbp_etl_rfi.kmo_wpuums
WHERE rfi_id < 20000   -- Datentyppruefung erfolgreich bestanden
  OR rfi_id = 40031    -- Markttag liegt vor dem Eroeffnungsdatum des Marktes 
GROUP BY 1, 2, 3
;



/*
#------------------------------------------------------------------------------
#  4.) Kroatische Artikelnummer 989999 auf 980000 umsetzen.
#      SAP Artikel 989999L ist nicht im DWH Artikelstamm und wird mit WG 
#      Erfassartikel 980000 ersetzt.
#------------------------------------------------------------------------------
*/

/*
UPDATE dbp_etl_rfi.kmo_wpuums
SET artnr = '0000009800000'
WHERE landkz = 'HR' 
  AND artnr = '0000000989999'
;


*/

/*
#------------------------------------------------------------------------------
#  5.) Freigabe, wenn referentielle Integritaet zwischenzeitlich gegeben ist.
#      Es wird immer der gesamte Markttag freigegeben, weil dieser bei Auftritt
#      eines RFI Fehler auch komplett in die RFI Umgebung verschoben wurde.
#
#      Pro Markttag und RFI Fehler darf kein einziger Datensatz vorhanden sein, 
#      der immer noch den enstprechenden RFI Fehler aufweist.
#
#      Jeder Markttag kann aufgrund der Logik in der RFI Pruefung zu einem
#      Zeitpunkt nur mit einem RFI Fehler in der RFI Umgebung vorhanden sein.
#
#      In Abstimmung mit PAM wurde am 19.08.2009 der RFI Fehler "Belegdatum 
#      liegt vor dem Eroeffnungsdatum des Marktes" in die automatische Freigabe
#      mit aufgenommen (mue 19.08.2009).
#------------------------------------------------------------------------------
*/

-- Land

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 10197
  AND UPPER(rfi_feld) = 'LANDKZ'
  AND TRIM(rfi_freigabe) = ''
  AND (landkz, filnr, belegdatum) IN
  (
    SELECT 
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    WHERE rfi_id = 10197
      AND UPPER(rfi_feld) = 'LANDKZ'
    
    GROUP BY landkz, filnr, belegdatum
  )
;




-- Artikel

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 10001
  AND UPPER(rfi_feld) = 'ARTNR'
  AND TRIM(rfi_freigabe) = ''
  AND (landkz, filnr, belegdatum) NOT IN
  (
    SELECT 
      l.landkz, l.filnr, l.belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl.kmo_wpuums_art_map m
    ON l.landkz = m.landkz
      AND l.artnr = m.artnr
    
    LEFT OUTER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    LEFT OUTER JOIN 
    (
      SELECT 
         mandant_id
        ,kl_art_id 
      FROM dbp_data.art
      GROUP BY mandant_id, kl_art_id
    ) a
    ON m.kl_art_id = a.kl_art_id 
      AND a.mandant_id = lm.mandant_id 
      
    WHERE rfi_id = 10001
      AND UPPER(rfi_feld) = 'ARTNR'
      AND a.kl_art_id IS NULL
    
    GROUP BY l.landkz, l.filnr, l.belegdatum
  )
;




-- Mehrwertsteuersatz 

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 10196
  AND UPPER(rfi_feld) = 'MWTAX'
  AND TRIM(rfi_freigabe) = '' 
  AND (landkz, filnr, belegdatum) NOT IN
  (
    SELECT 
      l.landkz, l.filnr, l.belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl.kmo_wpuums_art_map m
    ON l.landkz = m.landkz 
      AND l.artnr = m.artnr 
    
    INNER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    LEFT OUTER JOIN 
    (
      SELECT 
         mandant_id
        ,kl_art_id
        ,MAX(art_id) AS art_id 
      FROM dbp_data.art
      GROUP BY mandant_id, kl_art_id
    ) a
    ON m.kl_art_id = a.kl_art_id 
      AND a.mandant_id = lm.mandant_id 
    
    LEFT OUTER JOIN dbp_data.art aa
    ON aa.mandant_id = lm.mandant_id  
      AND a.art_id = aa.art_id 
      
    LEFT OUTER JOIN dbp_data.mwst_per mw
    ON mw.mandant_id = lm.mandant_id 
      AND aa.mwst_id = mw.mwst_id 
      AND to_date(l.belegdatum,'YYYYMMDD') BETWEEN mw.dat_von AND mw.dat_bis 
      
    WHERE rfi_id = 10196
      AND UPPER(rfi_feld) = 'MWTAX'
      AND mw.mandant_id IS NULL
    
    GROUP BY l.landkz, l.filnr, l.belegdatum
  )
;




-- Markt

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 10003
  AND UPPER(rfi_feld) = 'FILNR'
  AND TRIM(rfi_freigabe) = '' 
  AND (landkz, filnr, belegdatum) IN
  (
    SELECT 
      l.landkz, l.filnr, l.belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl.kmo_wpuums_wup_map m
    ON l.landkz = m.landkz 
      AND l.filnr = m.filnr 
    
    INNER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    INNER JOIN dbp_data.wup w
    ON w.mandant_id = lm.mandant_id 
      AND m.filnr = w.wup_id
      
    WHERE rfi_id = 10003
      AND UPPER(rfi_feld) = 'FILNR'
    
    GROUP BY l.landkz, l.filnr, l.belegdatum
  )
;




-- Eroeffnungsdatum Markt liegt vor dem Belegdatum

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 40031 
  AND UPPER(rfi_feld) = 'BELEGDATUM'
  AND TRIM(rfi_freigabe) = '' 
  AND (landkz, filnr, belegdatum) IN
  (
    SELECT 
      l.landkz, l.filnr, l.belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl.kmo_wpuums_wup_map m
    ON l.landkz = m.landkz 
      AND l.filnr = m.filnr 
    
    INNER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    INNER JOIN dbp_data.wup w
    ON w.mandant_id = lm.mandant_id 
      AND m.filnr = w.wup_id
      AND CAST(l.belegdatum AS DATE FORMAT 'YYYYMMDD') >= w.dat_von
      
    WHERE rfi_id = 40031
      AND UPPER(rfi_feld) = 'BELEGDATUM'
    
    GROUP BY l.landkz, l.filnr, l.belegdatum
  )
;




-- Zentraleinkaeufer

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 10148
  AND UPPER(rfi_feld) = 'ZEK'
  AND TRIM(rfi_freigabe) = ''
  AND (landkz, filnr, belegdatum) NOT IN
  (
    SELECT 
      l.landkz, l.filnr, l.belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl.kmo_wpuums_art_map m
    ON l.landkz = m.landkz 
      AND l.artnr = m.artnr
    
    INNER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    LEFT OUTER JOIN 
    (
      SELECT 
         mandant_id
        ,kl_art_id
        ,MAX(art_id) AS art_id 
      FROM dbp_data.art
      GROUP BY mandant_id, kl_art_id
    ) a
    ON m.kl_art_id = a.kl_art_id 
      AND a.mandant_id = lm.mandant_id 
    
    LEFT OUTER JOIN dbp_data.art aa
    ON aa.mandant_id = lm.mandant_id  
      AND a.art_id = aa.art_id 
      
    LEFT OUTER JOIN dbp_data.zek z
    ON z.mandant_id = lm.mandant_id  
      AND aa.zek_id = z.zek_id 
      
    WHERE rfi_id = 10148
      AND UPPER(rfi_feld) = 'ZEK'
      AND z.mandant_id IS NULL
    
    GROUP BY l.landkz, l.filnr, l.belegdatum
  )
;




-- Zuordnung Artikel Warengruppe

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 10016
  AND UPPER(rfi_feld) = 'ARTNR, WG'
  AND TRIM(rfi_freigabe) = ''
  AND (landkz, filnr, belegdatum) NOT IN
  (
    SELECT 
      l.landkz, l.filnr, l.belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl.kmo_wpuums_art_map m
    ON l.landkz = m.landkz 
      AND l.artnr = m.artnr
    
    INNER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    LEFT OUTER JOIN 
    (
      SELECT 
         mandant_id
        ,kl_art_id
        ,MAX(art_id) AS art_id 
      FROM dbp_data.art
      GROUP BY mandant_id, kl_art_id
    ) a
    ON m.kl_art_id = a.kl_art_id
      AND a.mandant_id = lm.mandant_id  
    
    LEFT OUTER JOIN dbp_data.art aa
    ON aa.mandant_id = lm.mandant_id  
      AND a.art_id = aa.art_id 
      
    LEFT OUTER JOIN dbp_data.art_wg_zu_per awz
    ON awz.mandant_id = lm.mandant_id 
      AND aa.art_id = awz.art_id 
      AND awz.dat_bis = to_date('99991231','YYYYMMDD')
      AND awz.arthiertyp_id = 2
      
    WHERE rfi_id = 10016
      AND UPPER(rfi_feld) = 'ARTNR, WG'
      AND awz.mandant_id IS NULL
    
    GROUP BY l.landkz, l.filnr, l.belegdatum
  )
;




-- Warengruppe

UPDATE dbp_etl_rfi.kmo_wpuums 
  SET rfi_freigabe = '2'
WHERE rfi_id = 10140
  AND UPPER(rfi_feld) = 'WG'
  AND TRIM(rfi_freigabe) = ''
  AND (landkz, filnr, belegdatum) NOT IN
  (
    SELECT 
      l.landkz, l.filnr, l.belegdatum
    FROM dbp_etl_rfi.kmo_wpuums l
    
    INNER JOIN dbp_etl.kmo_wpuums_art_map m
    ON l.landkz = m.landkz 
      AND l.artnr = m.artnr
    
    INNER JOIN dbp_etl_process.land_mandant_zu lm
    ON l.landkz = lm.land_id
  
    LEFT OUTER JOIN 
    (
      SELECT 
         mandant_id
        ,kl_art_id
        ,MAX(art_id) AS art_id 
      FROM dbp_data.art
      GROUP BY mandant_id, kl_art_id
    ) a
    ON m.kl_art_id = a.kl_art_id
      AND lm.mandant_id = a.mandant_id  
    
    LEFT OUTER JOIN dbp_data.art aa
    ON aa.mandant_id = lm.mandant_id 
      AND a.art_id = aa.art_id 
      
    LEFT OUTER JOIN dbp_data.art_wg_zu_per awz
    ON awz.mandant_id = lm.mandant_id 
      AND aa.art_id = awz.art_id 
      AND awz.dat_bis = to_date('99991231,YYYYMMDD')
      AND awz.arthiertyp_id = 2
      
    LEFT OUTER JOIN dbp_data.wg_per wp
    ON wp.mandant_id = lm.mandant_id 
      AND awz.wg_id = wp.wg_id 
      AND to_date(l.belegdatum ,'YYYYMMDD') BETWEEN wp.dat_von AND wp.dat_bis 
      AND wp.arthiertyp_id = 2

    WHERE rfi_id = 10140
      AND UPPER(rfi_feld) = 'WG'
      AND wp.mandant_id IS NULL
    
    GROUP BY l.landkz, l.filnr, l.belegdatum
  )
;




---- Fehlerfreie Verarbeitung der Kurs Datenlieferung
--
--UPDATE dbp_etl_rfi.kmo_wpuums 
--  SET rfi_freigabe = '2'
--WHERE rfi_id = 40038
--  AND UPPER(rfi_feld) = 'LANDKZ, BELEGDATUM'
--  AND TRIM(rfi_freigabe) = ''
--  AND (landkz, filnr, belegdatum) IN
--  (
--    SELECT 
--      l.landkz, l.filnr, l.belegdatum
--    FROM dbp_etl_rfi.kmo_wpuums l
--    
--    INNER JOIN 
--    (
--      SELECT 
--         land_id
--        ,CAST(CAST(dat AS date FORMAT 'YYYYMMDD') AS VARCHAR(10)) AS belegdatum
--      FROM dbp_etl_process.load_log_kurs l
--      
--      INNER JOIN dbp_etl_process.land_mandant_zu lm
--      ON l.mandant_id = lm.mandant_id
--      
--      WHERE ok_fg = 1
--    ) k
--    ON l.landkz = k.land_id
--      AND l.belegdatum = k.belegdatum
--  
--    WHERE rfi_id = 40038
--      AND UPPER(rfi_feld) = 'LANDKZ, BELEGDATUM'
--    
--    GROUP BY l.landkz, l.filnr, l.belegdatum
--  )
--;
--
--
--
--
/*
#------------------------------------------------------------------------------
# 6.) Hilfstabellen loeschen
#------------------------------------------------------------------------------
*/

DROP TABLE dbp_etl.kmo_wpuums_art_map;



DROP TABLE dbp_etl.kmo_wpuums_wup_map;



/*
#------------------------------------------------------------------------------
# 7.) BTEQ beenden
#------------------------------------------------------------------------------
*/

